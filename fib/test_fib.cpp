#include "fib.hpp"
#include <stdint.h>
#include <iostream>

using namespace std;

int main(int argc, char* argv[])
{
	ValueType output[1024];
	CountType count = 1024;
	fibonacci(count, output);

	ValueType a = 1, b = 1;
	for(size_t i = 0; i < count; i++) {
		if( output[i] != a ) {
			return 1;
		}
		ValueType c = a + b;
		a = b;
		b = c;

	}
	return 0;
}
