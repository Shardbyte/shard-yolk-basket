.PHONY: bake-print build-all build-debian validate

build-debian:
	docker buildx bake -f build/docker-bake.hcl oses-debian

build-all:
	docker buildx bake -f build/docker-bake.hcl

bake-print:
	docker buildx bake -f build/docker-bake.hcl --print

validate:
	./scripts/validate.sh
