#include <stdio.h>
#include <unistd.h>

int main()
{
    int n = 0;
    while (n++ < 10)
    {
        sleep(1);
        printf("%s\n", "active");
    }
}