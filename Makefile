# makefile for gcov2lcov
.PHONY: build test inttest

build:
	GOOS=linux GOARCH=amd64 go build -o bin/gcov2lcov-linux-amd64 .
	GOOS=windows GOARCH=amd64 go build -o bin/gcov2lcov-win-amd64 .
	GOOS=darwin GOARCH=amd64 go build -o bin/gcov2lcov-darwin-amd64 .

test:
	go test ./... -coverprofile coverage.out
	go tool cover -func coverage.out

inttest: build
	./bin/gcov2lcov-linux-amd64 -infile testdata/coverage.out -outfile coverage.lcov
	diff -y testdata/coverage_expected.lcov coverage.lcov

clean:
	rm -f bin/*


