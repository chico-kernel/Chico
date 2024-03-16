#include <stdint.h>

#define QEMU_SERIAL_PORT 0x3f8

void outb(uint16_t port, uint8_t value)
{
    __asm__ volatile("outb %1, %0" : : "dN"(port), "a"(value));
}

void kernel_main(void)
{
    outb(QEMU_SERIAL_PORT, 'A');
    return;

}
