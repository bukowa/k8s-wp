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
    	-p 8999:8999 \
    	$(shell docker build -q -f Dockerfile .)

push:
	docker tag $(shell docker build -q -f Dockerfile .) bukowa/test:provisioner
	docker push bukowa/test:provisioner