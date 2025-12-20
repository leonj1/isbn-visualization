.PHONY: build stop start restart

IMAGE_NAME := isbn-visualization
CONTAINER_NAME := isbn-visualization
HOST_PORT ?= 8083

build:
	docker build -f Dockerfile.web -t $(IMAGE_NAME):latest .

stop:
	docker stop $(CONTAINER_NAME) || true
	docker rm $(CONTAINER_NAME) || true

DATA_DIR := $(shell dirname $(CURDIR))

start:
	docker run -d --name $(CONTAINER_NAME) -p $(HOST_PORT):80 \
		-v $(DATA_DIR)/isbn-visualization-images/tiled:/usr/share/nginx/html/images/tiled:ro \
		-v $(DATA_DIR)/isbn-visualization-json/prefix-data:/usr/share/nginx/html/prefix-data:ro \
		$(IMAGE_NAME):latest

restart: stop start
