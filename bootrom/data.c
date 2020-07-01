
#include <stdint.h>

typedef enum {
  GPIO_Mode_IN = 0x00, /*!< GPIO Input Mode */
  GPIO_Mode_OUT = 0x01, /*!< GPIO Output Mode */
  GPIO_Mode_AF = 0x02, /*!< GPIO Alternate function Mode */
  GPIO_Mode_AN = 0x03  /*!< GPIO Analog Mode */
} GPIOMode_TypeDef;
typedef enum {
  GPIO_Speed_2MHz = 0x00, /*!< Low speed */
  GPIO_Speed_25MHz = 0x01, /*!< Medium speed */
  GPIO_Speed_50MHz = 0x02, /*!< Fast speed */
  GPIO_Speed_100MHz = 0x03  /*!< High speed on 30 pF (80 MHz Output max speed on 15 pF) */
} GPIOSpeed_TypeDef;
typedef enum {
  GPIO_OType_PP = 0x00,
  GPIO_OType_OD = 0x01
} GPIOOType_TypeDef;
typedef enum {
  GPIO_PuPd_NOPULL = 0x00,
  GPIO_PuPd_UP = 0x01,
  GPIO_PuPd_DOWN = 0x02
} GPIOPuPd_TypeDef;

#define GPIO_Pin_13                ((uint16_t)0x2000)  /* Pin 13 selected */
#define GPIO_Pin_15                ((uint16_t)0x8000)  /* Pin 15 selected */

typedef struct {
  uint32_t GPIO_Pin;              /*!< Specifies the GPIO pins to be configured.
                                       This parameter can be any value of @ref GPIO_pins_define */

  GPIOMode_TypeDef GPIO_Mode;     /*!< Specifies the operating mode for the selected pins.
                                       This parameter can be a value of @ref GPIOMode_TypeDef */

  GPIOSpeed_TypeDef GPIO_Speed;   /*!< Specifies the speed for the selected pins.
                                       This parameter can be a value of @ref GPIOSpeed_TypeDef */

  GPIOOType_TypeDef GPIO_OType;   /*!< Specifies the operating output type for the selected pins.
                                       This parameter can be a value of @ref GPIOOType_TypeDef */

  GPIOPuPd_TypeDef GPIO_PuPd;     /*!< Specifies the operating Pull-up/Pull down for the selected pins.
                                       This parameter can be a value of @ref GPIOPuPd_TypeDef */
} GPIO_InitTypeDef;

typedef struct {
  uint16_t SPI_Direction;           /*!< Specifies the SPI unidirectional or bidirectional data mode.
                                         This parameter can be a value of @ref SPI_data_direction */

  uint16_t SPI_Mode;                /*!< Specifies the SPI operating mode.
                                         This parameter can be a value of @ref SPI_mode */

  uint16_t SPI_DataSize;            /*!< Specifies the SPI data size.
                                         This parameter can be a value of @ref SPI_data_size */

  uint16_t SPI_CPOL;                /*!< Specifies the serial clock steady state.
                                         This parameter can be a value of @ref SPI_Clock_Polarity */

  uint16_t SPI_CPHA;                /*!< Specifies the clock active edge for the bit capture.
                                         This parameter can be a value of @ref SPI_Clock_Phase */

  uint16_t SPI_NSS;                 /*!< Specifies whether the NSS signal is managed by
                                         hardware (NSS pin) or by software using the SSI bit.
                                         This parameter can be a value of @ref SPI_Slave_Select_management */

  uint16_t SPI_BaudRatePrescaler;   /*!< Specifies the Baud Rate prescaler value which will be
                                         used to configure the transmit and receive SCK clock.
                                         This parameter can be a value of @ref SPI_BaudRate_Prescaler
                                         @note The communication clock is derived from the master
                                               clock. The slave clock does not need to be set. */

  uint16_t SPI_FirstBit;            /*!< Specifies whether data transfers start from MSB or LSB bit.
                                         This parameter can be a value of @ref SPI_MSB_LSB_transmission */

  uint16_t SPI_CRCPolynomial;       /*!< Specifies the polynomial used for the CRC calculation. */
} SPI_InitTypeDef;

#define SPI_Direction_1Line_Tx          ((uint16_t)0xC000)
#define SPI_Mode_Master                 ((uint16_t)0x0104)
#define SPI_DataSize_8b                 ((uint16_t)0x0000)
#define SPI_CPOL_Low                    ((uint16_t)0x0000)
#define SPI_CPHA_1Edge                  ((uint16_t)0x0000)
#define SPI_NSS_Soft                    ((uint16_t)0x0200)
#define SPI_BaudRatePrescaler_8         ((uint16_t)0x0010)
#define SPI_FirstBit_MSB                ((uint16_t)0x0000)

int32_t _data0 = -1;

GPIO_InitTypeDef _data1 = {
    .GPIO_Pin = GPIO_Pin_13 | GPIO_Pin_15,
    .GPIO_Mode = GPIO_Mode_AF,
    .GPIO_Speed = GPIO_Speed_50MHz,
    .GPIO_OType = GPIO_OType_PP,
    .GPIO_PuPd = GPIO_PuPd_NOPULL,
};
SPI_InitTypeDef _data2 = {
    .SPI_Direction =  SPI_Direction_1Line_Tx,
    .SPI_Mode =  SPI_Mode_Master,
    .SPI_DataSize =  SPI_DataSize_8b,
    .SPI_CPOL =  SPI_CPOL_Low,
    .SPI_CPHA =  SPI_CPHA_1Edge,
    .SPI_NSS =  SPI_NSS_Soft,
    .SPI_BaudRatePrescaler =  SPI_BaudRatePrescaler_8,
    .SPI_FirstBit =  SPI_FirstBit_MSB,
    .SPI_CRCPolynomial =  0x7,
};