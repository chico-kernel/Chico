CC = i686-elf-gcc
LD = i686-elf-ld
QEMU = qemu-system-i386

CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra -nostdlib -lgcc
LDFLAGS = -T linker.ld

KERNEL_SRC = src/kernel.c
KERNEL_OBJ = build/kernel.o

KERNEL_BIN = bin/kernel.img

BOOTLOADER_BIN = bootloader/bin/boot.img

FINAL_IMG = bin/Chico.img

QEMU_FLAGS = -serial stdio -name Chico -drive format=raw,file=$(FINAL_IMG)

.PHONY: all clean bootloader run

all: $(BOOTLOADER_BIN) $(FINAL_IMG)

$(BOOTLOADER_BIN):
	@make -C bootloader

$(FINAL_IMG): $(KERNEL_BIN) $(BOOTLOADER_BIN)
	@mkdir -p $(@D)
	@printf "  OUT\t$@\n"
	@cat $(BOOTLOADER_BIN) $(KERNEL_BIN) > $@

$(KERNEL_BIN): $(KERNEL_OBJ)
	@mkdir -p $(@D)
	@printf "  LD\t$<\n"
	@$(LD) $(LDFLAGS) -o $@ $<

$(KERNEL_OBJ): $(KERNEL_SRC)
	@mkdir -p $(@D)
	@printf "  CC\t$<\n"
	@$(CC) $(CFLAGS) -c $< -o $@

run: $(FINAL_IMG)
	@$(QEMU) $(QEMU_FLAGS)

clean:
	rm -rf $(KERNEL_BIN) $(KERNEL_OBJ) bin build $(FINAL_IMG)
	@make -C bootloader clean
