#include <stdio.h>
void print_abs_hex(int x) {
    if (x < 0) {
        x = -x;
    }
    char buf[12];
    int i;
    char c;
    for (i = 0; i < 8; i++) {

        c = (x & 0xf);
        if (c < 10) {
            c += '0';
        } else {
            c += 'a' - 10;
        }
        buf[9 - i] = c;
        x >>= 4;
        if (x == 0) {
            break;
        }
    }
    buf[9 - i - 1] = 'x';
    buf[9 - i - 2] = '0';
    buf[10] = '\n';
    buf[11] = 0;
    printf("%s\n", buf + (9 - i - 2));
    printf("==end%d\n", (9 - i - 2));
}
int main() {
    print_abs_hex(0x0812abcd);
    print_abs_hex(0x80001234);
    printf("%d %d", '0', 'a' - 10);
}