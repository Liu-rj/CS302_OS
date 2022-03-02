#include <stdio.h>
#include <string.h>
#include <console.h>

int kern_init(void) __attribute__((noreturn));

int kern_init(void) {
    extern char edata[], end[];
    memset(edata, 0, end - edata);

    const char *message = "os is loading ...\n";
    cputs(message);

    const char* msg = "SUSTech OS\n";
    cputs(msg);

    const char* double_msg = "ILOVEOS\n";
    double_puts(double_msg);

    while (1)
        ;
}
