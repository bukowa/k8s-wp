.PHONY: composer

composer:
	rm -fr ./vendor ./wp-content composer.lock || true
	docker run --rm -it --volume=${PWD}:/app \
	-u $(shell id -u):$(shell id -g) \
	$(shell docker build -q -f .composer.Dockerfile .) \
  	install

composer_cmd:
		docker run --rm -it --volume=${PWD}:/app \
    	-u $(shell id -u):$(shell id -g) \
    	--entrypoint=/bin/bash \
    	$(shell docker build -q -f .composer.Dockerfile .)