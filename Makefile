export KUBECONFIG:=$(shell pwd)/dev/kubeconfig.yaml

.PHONY: run build all

all: build run del rundel

build:
	make -C ./container.provisioner push

run:
	helm uninstall wp || true
	helm install wp --set-file=files.composer-json.content=./container.provisioner/composer.json \
	--values values.yaml \
	./charts/wordpress

del:
	sudo rm -fr ./dev/data/wp-wordpress

rundel: del run
