export KUBECONFIG:=$(shell pwd)/dev/kubeconfig.yaml

.PHONY: run build all

all: build run

build:
	make -C ./container.provisioner push

run:
	helm uninstall wp
	helm install wp ./charts/wordpress
