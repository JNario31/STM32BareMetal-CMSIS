# Steps to flash MCU
# make final
# make load
# Open second terminal
# arm-none-eabi-gdb
# target remote localhost:3333
# monitor reset init
# monitor flash write_image erase {output file name}.elf
# monitor reset init
# monitor resume
# quit
# y
# make clean
CMSIS_PATH   := chip-headers/CMSIS
INCLUDES     := \
   -I$(CMSIS_PATH)/Include \ #Path to core include files 
   -I$(CMSIS_PATH)/Device/ST/STM32F4xx/Include # Path to CMSIS include files

CC = arm-none-eabi-gcc
CFLAGS = -DSTM32F446xx -c -mcpu=cortex-m4 -mthumb -std=gnu11 $(INCLUDES)
LDFLAGS = -nostdlib -T stm32_ls.ld -Wl,-Map=stm32_blink.map

final : stm32_blink.elf

main.o : main.c
	$(CC) $(CFLAGS) $^ -o $@
	
stm32f446_startup.o : stm32f446_startup.c
	$(CC) $(CFLAGS) $^ -o $@
	
stm32_blink.elf : main.o stm32f446_startup.o
	$(CC) $(LDFLAGS) $^ -o $@

load :
	openocd -f board/st_nucleo_f4.cfg

clean:
	rm -f *.o *.elf *.map
