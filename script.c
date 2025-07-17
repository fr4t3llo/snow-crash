#include <libc.h>
int main(int ac, char **av) {
    if (ac < 2)
        return 1; // No arguments provided, exit with error code 1
    char *arg = av[1];
    int i = 0;
    while (*arg)
    {
        printf("%c", *arg - i);
        i++;
        arg++;
    }
}
