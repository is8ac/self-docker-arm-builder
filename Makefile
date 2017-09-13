SYSTEM_ARCH := $(shell uname -m | sed 's/\(...\).*/\1/')

GROUP_ID := $(shell id -g)
USER_ID := $(shell id -u)



git_repo: self/.git/HEAD
	git clone --branch develop --recursive https://github.com/watson-intu/self.git
	cd self && git submodule update --init --recursive

self: target/builddockerimage
	docker run -it \
	-v $$PWD/self:/self \
	self-builder \
	sh -c "cd /self/ && scripts/build_raspi.sh"

target/builddockerimage: Dockerfile
	docker build -t self-builder -f Dockerfile-linux.bld .
	touch target/builddockerimage
