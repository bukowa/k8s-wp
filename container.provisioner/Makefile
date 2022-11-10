.PHONY: composer composer_cmd

composer:
	rm -fr ./vendor ./wp-content composer.lock || true
	docker run --rm -it --volume=${PWD}:/var/www/html \
	-u $(shell id -u):$(shell id -g) \
	$(shell docker build -q -f Dockerfile .) \
  	"composer install"

composer_cmd:
		docker run --rm -it --volume=${PWD}:/var/www/html \
    	-u $(shell id -u):$(shell id -g) \
    	--entrypoint=/bin/bash \
    	$(shell docker build -q -f Dockerfile .)