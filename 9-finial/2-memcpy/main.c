#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <sys/time.h>

#define TEST_TIME 5

void * my_memcpy(void * dest, const void * src, size_t n);

size_t size_array[] = {
    // 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 100, 1000, 
    10000, 100000, 1000000, 10000000, 100000000, 1000000000
};

long time_sub(struct timeval tv1, struct timeval tv2);

int main() {
    int nn = sizeof(size_array) / sizeof(size_t);
    for (int i = 0; i < nn; i++) {
        printf("Testing: size = %ld\n", size_array[i]);

        char * src1 = malloc(size_array[i]);
        char * src2 = malloc(size_array[i]);
        char * dest1 = malloc(size_array[i]);
        char * dest2 = malloc(size_array[i]);

        for (size_t p = 0; p < size_array[i] - 1; p++) {
            char ch = (p + i * 3) % 90 + ' ';
            src1[p] = ch;
            src2[p] = ch;
        }
        src1[size_array[i] - 1] = 0;
        src2[size_array[i] - 1] = 0;

        struct timeval tv1, tv2, tv3;


        for (int k = 0; k < TEST_TIME; k++) {
            gettimeofday(&tv1, NULL);
            memcpy(dest1, src1, size_array[i]);
            gettimeofday(&tv2, NULL);
            my_memcpy(dest2, src2, size_array[i]);
            gettimeofday(&tv3, NULL);

            printf("    round %d: ", k);
            long time1 = time_sub(tv1, tv2);
            long time2 = time_sub(tv2, tv3);
            double ppp = (double) time2 / time1;
            printf("%ld us, %ld us, %f\n", time1, time2, ppp);

            printf("              ");
            if (strcmp(src2, dest2) == 0) {
                printf("Correct!\n");
            } else {
                printf("Wrong.\n");
            }
            // if (size_array[i] < 60) {
            //     printf("    src =   %s\n", src1);
            //     printf("    dest1 = %s\n", dest1);
            //     printf("    dest2 = %s\n", dest2);
            // }
        }
        free(src1);
        free(src2);
        free(dest1);
        free(dest2);
    }

    return 0;
}

long time_sub(struct timeval tv1, struct timeval tv2) {
    long sec = tv2.tv_sec - tv1.tv_sec;
    long usec = tv2.tv_usec - tv1.tv_usec;
    if (usec < 0) {
        sec -= 1;
        usec += 1000000;
    }
    return sec * 1000000 + usec;
}