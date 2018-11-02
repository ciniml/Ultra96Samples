#include <ap_int.h>

typedef ap_uint<16> CountType;
typedef ap_uint<32> ValueType;

void fibonacci(const CountType& count, ValueType* output);
