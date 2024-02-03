SHELL=/bin/bash

export COMPOSE_DOCKER_CLI_BUILD=1
export DOCKER_BUILDKIT=1
export BUILDKIT_PROGRESS=plain

POSTGRES_VERSION ?= 16.1

TAG ?= latest
PLATFORM ?= linux/amd64

DOCKER_IMAGE_NAME:=nulldark/postgres
DOCKER_IMAGE:=$(DOCKER_IMAGE_NAME):$(TAG)

build:
	docker buildx build \
	   --load \
       --platform $(PLATFORM) \
       --tag $(DOCKER_IMAGE) \
       --file $(POSTGRES_VERSION)/Dockerfile $(POSTGRES_VERSION)/

push:
	docker buildx build \
	   --push \
       --platform $(PLATFORM) \
       --tag $(DOCKER_IMAGE) \
       --file $(POSTGRES_VERSION)/Dockerfile $(POSTGRES_VERSION)/

release: build push