#include <stdbool.h>
#include <stdint.h>
#include <stm32f2xx_usart.h>

void putchar(char chracter)
{
    while (USART_GetFlagStatus(USART3, USART_FLAG_TC) == RESET) {}
    USART_SendData(USART3, chracter);
    while (USART_GetFlagStatus(USART3, USART_FLAG_TC) == RESET) {}
}

