# Dockerfile for pre-configured mysql server
It can be used for local tests in https://github.com/go-mysql-org/go-mysql.

docker hub: https://hub.docker.com/repository/docker/atercattus/go-mysql

Based on: https://github.com/siddontang/mysql-docker

## Install

Use `make` or `make clean` to install or uninstall it. 

## Usage

```
docker run --rm -p 3306:3306 --name go-mysql atercattus/go-mysql:5.7.36
```
