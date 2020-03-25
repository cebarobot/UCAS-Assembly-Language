#include <stdio.h>

char s[] = "ab1g2hA0H56po9wK78nB";

int main() {
    char * p;
    p = s;
    while (*p != 0) {
        if (*p >= 'a' && *p <= 'z') {
            *p += 'A' - 'a';
        }
        p++;
    }
    printf("%s\n", s);
    printf("'A' - 'a' = %d\n", 'A' - 'a');
    return 0;
}