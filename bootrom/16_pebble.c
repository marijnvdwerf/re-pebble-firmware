#include <stdbool.h>
#include <stdint.h>
#include <stm32f2xx_usart.h>
#include <stm32f2xx_spi.h>

void putchar(char chracter)
{
    while (USART_GetFlagStatus(USART3, USART_FLAG_TC) == RESET) {}
    USART_SendData(USART3, chracter);
    while (USART_GetFlagStatus(USART3, USART_FLAG_TC) == RESET) {}
}

void spi2_write(uint16_t param_1) {
    SPI_I2S_SendData(SPI2, param_1);
    while (SPI_I2S_GetFlagStatus(SPI2, SPI_I2S_FLAG_TXE) == RESET);
}
