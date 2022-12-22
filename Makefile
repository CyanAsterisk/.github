SHELL := /bin/bash

.PHONY: \
	help \
	coverage \
	vet \
	fmt


all: imports fmt vet errors build

help:
	@echo 'Usage: make <OPTIONS> ... <TARGETS>'
	@echo ''
	@echo 'Available targets are:'
	@echo ''
	@echo '    help               Show this help screen.'
	@echo '    coverage           Report code tests coverage.'
	@echo '    vet                Run go vet.'
	@echo '    fmt                Run go fmt.'
	@echo ''
	@echo 'Targets run by default are: lint, vet.'
	@echo ''

deps:
	go get golang.org/x/lint/golint

coverage:
	go test $(go list ./... | grep -v examples) -coverprofile coverage.txt ./...

vet:
	go vet ./...

fmt:
	go install mvdan.cc/gofumpt@latest
	gofumpt -l -w -extra .

version:
	@go version