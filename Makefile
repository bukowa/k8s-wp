.PHONY: composer

composer:
	rm -fr ./vendor ./wp-content
	docker run --rm -it --volume=${PWD}:/app \
	-u $(shell id -u):$(shell id -g) \
	$(shell docker build -q -f .composer.Dockerfile .) \
  	install