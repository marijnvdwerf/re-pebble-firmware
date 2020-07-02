#include "stm32f2xx_dbgmcu.h"

void DBGMCU_APB1PeriphConfig(uint32_t DBGMCU_Periph, FunctionalState NewState)
{
    if (NewState != DISABLE)
    {
        DBGMCU->APB1FZ |= DBGMCU_Periph;
    }
    else
    {
        DBGMCU->APB1FZ &= ~DBGMCU_Periph;
    }
}
