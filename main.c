#include "stm32f4xx.h"
#include "stm32f446xx.h"

#define GPIOAEN     (1U<<0)

#define PIN5        (1U<<5)

#define LED_PIN     PIN5

int main(void)
{
    // 5: Enable clock access to GPIOA
    RCC->AHB1ENR |= GPIOAEN;
    // 6: Set PA5 to output mode
    GPIOA->MODER |= (1U<<10);
    GPIOA->MODER &= ~(1U<<11);
    while(1)
    {
    // 7: Set PA5(LED_PIN) high
    GPIOA->ODR^= LED_PIN;
    // 8: Simple delay
    for(int i=0;i<100000;i++){}
    }
}