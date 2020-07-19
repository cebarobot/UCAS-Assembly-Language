#include <stdio.h>
#include <ctype.h>

int atoi(const char *nptr);

char str_set[][100] = {
    "123456789",
    "-123456789",
    "1978UCAS2020",
    "    2020UCAS~",
    "UCAS welcome~",
    "1346792580852976431",
    "-1346792580852976431",
    "2147483647",
    "2147483648",
    "-2147483648",
    "-2147483649",
    "    \t\t-1346792580852976431UCAS",
    "    \t\t134679UCAS",
    ""
};

int main() {
    printf("Testing int atoi(const char *nptr) ...\n");
    for (int i = 0; i < 14; i++) {
        printf("%x\n", (int) str_set[i]);
        printf("\"%s\" : %d\n", str_set[i], atoi(str_set[i]));
    }
    return 0;
}