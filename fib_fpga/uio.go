package main

// #include <sys/mman.h>
// #include <stdint.h>

import (
	//"C"

	"unsafe"
)

type Device *device

type device struct {
	pointer unsafe.Pointer
	size    int64
}

func NewDevice(name string) (Device, error) {
	os.
}
