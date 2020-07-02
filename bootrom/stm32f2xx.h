#include <stdint.h>                      /*!< standard types definitions                      */

#define     __IO    volatile             /*!< defines 'read / write' permissions              */

typedef enum { DISABLE = 0, ENABLE = !DISABLE } FunctionalState;
#define IS_FUNCTIONAL_STATE(STATE) (((STATE) == DISABLE) || ((STATE) == ENABLE))

#define  CRC_CR_RESET                        ((uint8_t)0x01)        /*!< RESET bit */
typedef struct {
  __IO uint32_t DR;         /*!< CRC Data register,             Address offset: 0x00 */
  __IO uint8_t IDR;        /*!< CRC Independent data register, Address offset: 0x04 */
  uint8_t RESERVED0;  /*!< Reserved, 0x05                                      */
  uint16_t RESERVED1;  /*!< Reserved, 0x06                                      */
  __IO uint32_t CR;         /*!< CRC Control register,          Address offset: 0x08 */
} CRC_TypeDef;

/**
  * @brief Debug MCU
  */

typedef struct {
  __IO uint32_t IDCODE;  /*!< MCU device ID code,               Address offset: 0x00 */
  __IO uint32_t CR;      /*!< Debug MCU configuration register, Address offset: 0x04 */
  __IO uint32_t APB1FZ;  /*!< Debug MCU APB1 freeze register,   Address offset: 0x08 */
  __IO uint32_t APB2FZ;  /*!< Debug MCU APB2 freeze register,   Address offset: 0x0C */
} DBGMCU_TypeDef;

#define PERIPH_BASE           ((uint32_t)0x40000000) /*!< Peripheral base address in the alias region */
#define CRC                 ((CRC_TypeDef *) CRC_BASE)
#define CRC_BASE              (AHB1PERIPH_BASE + 0x3000)
#define AHB1PERIPH_BASE       (PERIPH_BASE + 0x00020000)

#define DBGMCU_BASE           ((uint32_t )0xE0042000)
#define DBGMCU              ((DBGMCU_TypeDef *) DBGMCU_BASE)
