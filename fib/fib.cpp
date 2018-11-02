#include "fib.hpp"

void fibonacci(const CountType& count, ValueType* output)
{
#pragma HLS INTERFACE s_axilite port=return
#pragma HLS INTERFACE m_axi depth=1024 port=output
#pragma HLS INTERFACE s_axilite register port=count
	ValueType a = 1;
	ValueType b = 1;
	for(CountType i = count; i > 0; --i) {
#pragma HLS PIPELINE II=1
		*output++ = a;
		ValueType c = a + b;
		a = b;
		b = c;
	}
}
