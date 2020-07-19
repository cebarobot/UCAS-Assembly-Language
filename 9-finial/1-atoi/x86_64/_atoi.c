#include <stdio.h>

inline int is_space(char x) {
    return x == ' ' || x == '\t' || x == '\n' || x == '\v' || x == '\f' || x == '\r';
}

inline int is_digit(char x) {
    return x >= '0' && x <= '9';
}

int atoi(const char *nptr) {
    int sign = 1;
    int ans = 0;
    if (is_space(*nptr)) {
        do {
            nptr ++;
        } while (is_space(*nptr));
    }
    if (*nptr == '-') {
        sign = -1;
        nptr ++;
    } else if (*nptr == '+') {
        sign = 1;
        nptr ++;
    }
    while (is_digit(*nptr)) {
        ans = ans * 10 + *nptr - '0';
        nptr++;
    }
    return sign * ans;
}

int main() {
    // printf("%d\n", atoi("-123xxx123"));
}