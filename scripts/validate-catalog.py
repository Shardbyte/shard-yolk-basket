#!/usr/bin/env python3
"""
Validate catalog/images.yml for internal consistency and agreement with
build/docker-bake.hcl and the filesystem.

Checks:
  - Required fields present on every image entry
  - Dockerfile path exists on disk
  - No duplicate image ids or tags
  - Every catalog id appears in the bake target list
  - Every active image has a known namespace, type, category, and status
  - depends_on references a valid id (or null)
  - extra_tags are fully qualified (namespace:tag) and not duplicated
"""

import re
import sys
from pathlib import Path

try:
    import yaml
except ModuleNotFoundError:
    sys.exit("error: PyYAML not available — run: pip install pyyaml")

REPO = Path(__file__).resolve().parent.parent
CATALOG = REPO / "catalog" / "images.yml"
BAKE = REPO / "build" / "docker-bake.hcl"

REQUIRED_FIELDS = {"id", "dockerfile", "namespace", "tag", "platforms", "depends_on", "type", "category", "description", "status"}
VALID_NAMESPACES = {"yolks", "games", "installers", "steamcmd"}
VALID_TYPES = {"base", "runtime", "build", "installer"}
VALID_STATUSES = {"active", "deprecated", "planned"}
VALID_CATEGORIES = {"os", "java", "nodejs", "python", "dotnet", "go", "rust", "mono", "wine", "game"}
VALID_PLATFORMS = {"linux/amd64", "linux/arm64"}


def load_catalog():
    with CATALOG.open() as f:
        return yaml.safe_load(f)


def load_bake_targets():
    text = BAKE.read_text()
    return set(re.findall(r'^\s*"([a-z][a-z0-9-]+)"', text, re.MULTILINE))


def err(msg):
    print(f"error: {msg}", file=sys.stderr)
    return 1


def main():
    failures = 0

    data = load_catalog()
    images = data.get("images", [])
    if not images:
        sys.exit("error: catalog/images.yml has no images entries")

    bake_targets = load_bake_targets()
    all_ids = set()
    all_primary_tags = set()
    all_extra_tags = set()

    for img in images:
        iid = img.get("id", "<missing>")

        # Required fields
        missing = REQUIRED_FIELDS - img.keys()
        if missing:
            failures += err(f"{iid}: missing required fields: {sorted(missing)}")

        # Duplicate id
        if iid in all_ids:
            failures += err(f"duplicate image id: {iid}")
        all_ids.add(iid)

        # Dockerfile exists
        df = REPO / img.get("dockerfile", "")
        if not df.is_file():
            failures += err(f"{iid}: dockerfile not found: {img.get('dockerfile')}")

        # Namespace
        ns = img.get("namespace")
        if ns not in VALID_NAMESPACES:
            failures += err(f"{iid}: unknown namespace '{ns}' — expected one of {sorted(VALID_NAMESPACES)}")

        # Type
        typ = img.get("type")
        if typ not in VALID_TYPES:
            failures += err(f"{iid}: unknown type '{typ}' — expected one of {sorted(VALID_TYPES)}")

        # Category
        cat = img.get("category")
        if cat not in VALID_CATEGORIES:
            failures += err(f"{iid}: unknown category '{cat}' — expected one of {sorted(VALID_CATEGORIES)}")

        # Status
        status = img.get("status")
        if status not in VALID_STATUSES:
            failures += err(f"{iid}: unknown status '{status}' — expected one of {sorted(VALID_STATUSES)}")

        # Platforms
        platforms = img.get("platforms", [])
        unknown_platforms = set(platforms) - VALID_PLATFORMS
        if unknown_platforms:
            failures += err(f"{iid}: unknown platforms: {sorted(unknown_platforms)}")

        # Primary tag uniqueness
        primary = f"{ns}:{img.get('tag', '')}"
        if primary in all_primary_tags:
            failures += err(f"{iid}: duplicate primary tag: {primary}")
        all_primary_tags.add(primary)

        # Extra tags format and uniqueness
        for extra in img.get("extra_tags", []):
            if ":" not in extra:
                failures += err(f"{iid}: extra_tag '{extra}' must be fully qualified as namespace:tag")
            if extra in all_extra_tags or extra in all_primary_tags:
                failures += err(f"{iid}: duplicate extra_tag: {extra}")
            all_extra_tags.add(extra)

        # depends_on references a valid id
        dep = img.get("depends_on")
        if dep is not None and dep not in all_ids:
            # Only flag if we've already seen all entries (second pass check below)
            pass

    # Second pass: validate depends_on against full id set
    for img in images:
        dep = img.get("depends_on")
        if dep is not None and dep not in all_ids:
            failures += err(f"{img['id']}: depends_on '{dep}' not found in catalog")

    # Every active catalog id should have a bake target
    for img in images:
        if img.get("status") == "active" and img["id"] not in bake_targets:
            failures += err(f"{img['id']}: active image has no matching bake target in build/docker-bake.hcl")

    if failures:
        print(f"\ncatalog validation failed: {failures} error(s)", file=sys.stderr)
        sys.exit(1)

    print(f"catalog/images.yml: {len(images)} images validated OK")


if __name__ == "__main__":
    main()
