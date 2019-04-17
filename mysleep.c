#include<stdio.h>
#include<signal.h>

void test1(int sign)
{
    printf("%d catch singal %d\n", getpid(), sign);
}

int main(int argc, char* argv[])
{
    signal(SIGTERM, test1);

    while(1) {
        sleep(0.1);
    }

    return 0;
}

/*
 * gcc mysleep.c -o mysleep
 * */
