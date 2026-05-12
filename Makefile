.PHONY: all

CONTAINER_NAME = silverfort-web
IMAGE = silverfort-web:latest

all: build run

build:
	docker build -t $(IMAGE) .

run:
	docker run -d \
		--name $(CONTAINER_NAME) \
		--hostname $(CONTAINER_NAME) \
		-p 3000:3000 \
		$(IMAGE)
