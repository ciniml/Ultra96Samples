.PHONY: all clean run

GO = /usr/local/go/bin/go

all: fib_fpga

clean:
	-@rm fib_fpga

fib_fpga: main.go
	$(GO) build

run: fib_fpga
	./fib_fpga