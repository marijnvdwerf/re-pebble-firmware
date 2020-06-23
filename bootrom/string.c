#include "string.h"
#include "stdbool.h"

void *memcpy(void *dest, const void *src, size_t n) {
    unsigned char *_dest = (unsigned char *) dest;
    unsigned char *_src = (unsigned char *) src;

    size_t i = 0;
    while (true) {
        if (i == n) break;
        _dest[i] = _src[i];
        i++;
    }

    return dest;
}
