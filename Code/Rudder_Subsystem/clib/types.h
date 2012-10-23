#ifndef _TYPES_H_
#define _TYPES_H_

#include <stdint.h>

typedef union {
	uint16_t usData;
	uint8_t  chData[2];
} tUnsignedShortToChar; 

typedef union {
	int16_t shData;
	uint8_t chData[2];
} tShortToChar;

typedef union {
	uint32_t ulData;
	uint8_t  chData[4];
} tUnsignedLongToChar;

typedef union {
	int32_t lData;
	uint8_t chData[4];
} tLongToChar;

typedef union {
	float    flData;
	uint16_t usData[2];
	uint8_t  chData[4];
} tFloatToChar;

#ifndef NULL
#define NULL  0
#endif

#ifndef TRUE
#define TRUE  1
#endif

#ifndef FALSE
#define FALSE 0
#endif

#ifndef M_PI
#define M_PI 3.14159265358979323846264338327
#endif

#ifndef NAN
#define NAN __builtin_nan("")
#endif

#endif // _TYPES_H_