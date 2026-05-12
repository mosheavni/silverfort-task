.PHONY: all build run clean

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

clean:
	docker rm -f $(CONTAINER_NAME) || true
