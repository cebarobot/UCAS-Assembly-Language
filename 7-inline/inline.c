#include <stdio.h>

unsigned int shld5(unsigned int a, unsigned int b) {
    unsigned int result;    
    // result = (a << 5) | (b >> (32 - 5)); // 此语句用嵌入式汇编编写
    asm(
        "shll   %[a_count], %[a]\n"
        "shrl   %[b_count], %[b]\n"
        "orl    %[b], %[a]\n"
        "movl   %[a], %[result]"
        :   [result] "=r" (result)
        :   [a] "r" (a),
            [a_count] "i" (5),
            [b] "r" (b),
            [b_count] "i" (32 - 5)
    );
    return result;
}

unsigned int _shld5(unsigned int a, unsigned int b) {
    unsigned int result;    
    result = (a << 5) | (b >> (32 - 5)); // 此语句用嵌入式汇编编写
    return result;
}

int main() {
    unsigned int aa, bb;
    printf("please input a and b: ");
    scanf("%x %x", &aa, &bb);
    printf("Your result of shld5 is \t0x%x\n", shld5(aa, bb));
    printf("Correct result of shld5 is \t0x%x\n", _shld5(aa, bb));
}