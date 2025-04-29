CMSIS_PATH   := chip-headers/CMSIS
INCLUDES     := \
   -I$(CMSIS_PATH)/Include \
   -I$(CMSIS_PATH)/Device/ST/STM32F4xx/Include

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
