#include <stdio.h>
#include <unistd.h>
#include <sys/io.h>

#include "kbdfixConfig.h"

#define I8042_COMMAND_REG 0x64
#define ENABLE_KBD 0xAE
#define DISABLE_KBD 0xAD
#define DEV_PORT "/dev/port"

int main(int argc, char *argv[]) {
    FILE *dev_port;
    char data = ENABLE_KBD;

    dev_port = fopen(DEV_PORT, "w");

    if (!dev_port) {
        printf("sorry, can't open '%s', you may not have permission.\n", DEV_PORT);
        return 0;
    }

    if ((argc == 2) && (argv[1][0] == '0'))
        data = DISABLE_KBD;

    fseek(dev_port, I8042_COMMAND_REG, SEEK_SET);
    fputc(data, dev_port);

    fclose(dev_port);

    return 0;
}
