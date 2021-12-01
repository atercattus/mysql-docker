all: build

build:
	@docker build -t atercattus/go-mysql:5.7.36 .

clean:
	@docker rmi atercattus/go-mysql:5.7.36
