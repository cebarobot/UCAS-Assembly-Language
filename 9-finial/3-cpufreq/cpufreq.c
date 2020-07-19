#include <stdio.h>
#include <sys/time.h>

static inline unsigned long rdtsc(void) {
    unsigned long long tick;
    asm volatile ("rdtsc":"=A"(tick));
    return tick;
}

int main() {
    struct timeval tv1, tv2;
    long cpufreq;
    long cycle1, cycle2;
    gettimeofday(&tv1, NULL);
    // printf("%ld ", rdtsc());
    asm volatile (
        "cpuid \n"
        "rdtsc \n"
        "movq %%rax, %[cycle1] \n"
        "movq $100000000, %%rcx \n"
        "xorq %%r8, %%r8 \n"
        "movq $1, %%r9 \n"
        "LOOP: \n"
        "leaq (%%r8, %%r9), %%r10 \n"
        "movq %%r9, %%r8 \n"
        "movq %%r10, %%r9 \n"
        "loop LOOP \n"
        "cpuid \n"
        "rdtsc \n"
        "movq %%rax, %[cycle2] \n"
        :   [cycle1] "=r" (cycle1),
            [cycle2] "=r" (cycle2)
        :
        :   "rax", "rcx"
    );
    // printf("%ld\n", rdtsc());
    gettimeofday(&tv2, NULL);
    cpufreq = (cycle2 - cycle1) / (tv2.tv_usec - tv1.tv_usec);
    
    printf("cycle: %ld - %ld = %ld\n", cycle1, cycle2, cycle2 - cycle1);
    printf("time1: %ld %ld\n", tv1.tv_sec, tv1.tv_usec);
    printf("time2: %ld %ld\n", tv2.tv_sec, tv2.tv_usec);
    printf("The cpu frequency is %ld MHz\n", cpufreq);
    cpufreq = 400000000 / (tv2.tv_usec - tv1.tv_usec);
    printf("The cpu frequency is %ld MHz\n", cpufreq);
    return 0;
}
