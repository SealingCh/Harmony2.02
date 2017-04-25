<#--
/*******************************************************************************
  I2C interrupt Template File

  File Name:
    drv_i2c_int.s

  Summary:
    This file contains source code necessary to initialize the system.

  Description:
    This file contains source code necessary to run the system.  It
	generates code that is added to system_interrupt.c in order to handle
	all interrupts.
 *******************************************************************************/

/*******************************************************************************
Copyright (c) 2013-2014 released Microchip Technology Inc.  All rights reserved.

Microchip licenses to you the right to use, modify, copy and distribute
Software only when embedded on a Microchip microcontroller or digital signal
controller that is integrated into your product or third party product
(pursuant to the sublicense terms in the accompanying license agreement).

You should refer to the license agreement accompanying this Software for
additional information regarding your rights and obligations.

SOFTWARE AND DOCUMENTATION ARE PROVIDED AS IS WITHOUT WARRANTY OF ANY KIND,
EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION, ANY WARRANTY OF
MERCHANTABILITY, TITLE, NON-INFRINGEMENT AND FITNESS FOR A PARTICULAR PURPOSE.
IN NO EVENT SHALL MICROCHIP OR ITS LICENSORS BE LIABLE OR OBLIGATED UNDER
CONTRACT, NEGLIGENCE, STRICT LIABILITY, CONTRIBUTION, BREACH OF WARRANTY, OR
OTHER LEGAL EQUITABLE THEORY ANY DIRECT OR INDIRECT DAMAGES OR EXPENSES
INCLUDING BUT NOT LIMITED TO ANY INCIDENTAL, SPECIAL, INDIRECT, PUNITIVE OR
CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF PROCUREMENT OF
SUBSTITUTE GOODS, TECHNOLOGY, SERVICES, OR ANY CLAIMS BY THIRD PARTIES
(INCLUDING BUT NOT LIMITED TO ANY DEFENSE THEREOF), OR OTHER SIMILAR COSTS.
 *******************************************************************************/
 -->
<#macro DRV_I2C_ASM_MX_INT DRV_I2C_INSTANCE DRV_I2C_ID>
<#if DRV_I2C_ID == "I2C_ID_1">
<#assign I2C_ISR_VECTOR = CONFIG_INT_VECT_I2C_1>
</#if>
<#if DRV_I2C_ID == "I2C_ID_2">
<#assign I2C_ISR_VECTOR = CONFIG_INT_VECT_I2C_2>
</#if>
<#if DRV_I2C_ID == "I2C_ID_3">
<#assign I2C_ISR_VECTOR = CONFIG_INT_VECT_I2C_3>
</#if>
<#if DRV_I2C_ID == "I2C_ID_4">
<#assign I2C_ISR_VECTOR = CONFIG_INT_VECT_I2C_4>
</#if>
<#if DRV_I2C_ID == "I2C_ID_5">
<#assign I2C_ISR_VECTOR = CONFIG_INT_VECT_I2C_5>
</#if>
<#if DRV_I2C_INSTANCE == "0">
<#assign I2C_ISR_NAME = "DrvI2CInstance0">
<#assign I2C_INTPRIO = CONFIG_DRV_I2C_INT_PRIORITY_IDX0>
</#if>
<#if DRV_I2C_INSTANCE == "1">
<#assign I2C_ISR_NAME = "DrvI2CInstance1">
<#assign I2C_INTPRIO = CONFIG_DRV_I2C_INT_PRIORITY_IDX1>
</#if>
<#if DRV_I2C_INSTANCE == "2">
<#assign I2C_ISR_NAME = "DrvI2CInstance2">
<#assign I2C_INTPRIO = CONFIG_DRV_I2C_INT_PRIORITY_IDX2>
</#if>
<#if DRV_I2C_INSTANCE == "3">
<#assign I2C_ISR_NAME = "DrvI2CInstance3">
<#assign I2C_INTPRIO = CONFIG_DRV_I2C_INT_PRIORITY_IDX3>
</#if>
<#if DRV_I2C_INSTANCE == "4">
<#assign I2C_ISR_NAME = "DrvI2CInstance4">
<#assign I2C_INTPRIO = CONFIG_DRV_I2C_INT_PRIORITY_IDX4>
</#if>

/* I2C Instance ${DRV_I2C_INSTANCE} Interrupt */

<@RTOS_ISR VECTOR = I2C_ISR_VECTOR NAME = I2C_ISR_NAME PRIORITY = I2C_INTPRIO/>
</#macro>
<#macro DRV_I2C_ASM_MZ_INT DRV_I2C_INSTANCE DRV_I2C_ID DRV_I2C_MODE DRV_I2C_STATIC_MODE DRV_I2C_BIT_BANG DRV_TMR_BB_ID>
<#if DRV_I2C_ID == "I2C_ID_1">
    <#if DRV_I2C_BIT_BANG == true>
        <#if DRV_TMR_BB_ID == "TMR_ID_9">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_9>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_8">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_8>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_7">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_7>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_6">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_6>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_5">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_5>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_4">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_4>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_3">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_3>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_2">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_2>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_1">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_1>
        </#if>
    <#else>
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_I2C1_MASTER>
    </#if>
<#assign I2C_SLAVE_ISR_VECTOR = CONFIG_INT_VECT_I2C1_SLAVE>
<#assign I2C_BUS_ISR_VECTOR = CONFIG_INT_VECT_I2C1_BUS>
</#if>
<#if DRV_I2C_ID == "I2C_ID_2">
    <#if DRV_I2C_BIT_BANG == true>
        <#if DRV_TMR_BB_ID == "TMR_ID_9">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_9>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_8">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_8>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_7">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_7>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_6">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_6>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_5">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_5>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_4">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_4>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_3">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_3>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_2">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_2>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_1">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_1>
        </#if>
    <#else>
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_I2C2_MASTER>
    </#if>
<#assign I2C_SLAVE_ISR_VECTOR = CONFIG_INT_VECT_I2C2_SLAVE>
<#assign I2C_BUS_ISR_VECTOR = CONFIG_INT_VECT_I2C2_BUS>
</#if>
<#if DRV_I2C_ID == "I2C_ID_3">
    <#if DRV_I2C_BIT_BANG == true>
        <#if DRV_TMR_BB_ID == "TMR_ID_9">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_9>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_8">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_8>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_7">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_7>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_6">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_6>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_5">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_5>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_4">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_4>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_3">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_3>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_2">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_2>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_1">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_1>
        </#if>
    <#else>
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_I2C3_MASTER>
    </#if>
<#assign I2C_SLAVE_ISR_VECTOR = CONFIG_INT_VECT_I2C3_SLAVE>
<#assign I2C_BUS_ISR_VECTOR = CONFIG_INT_VECT_I2C3_BUS>
</#if>
<#if DRV_I2C_ID == "I2C_ID_4">
    <#if DRV_I2C_BIT_BANG == true>
        <#if DRV_TMR_BB_ID == "TMR_ID_9">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_9>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_8">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_8>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_7">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_7>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_6">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_6>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_5">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_5>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_4">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_4>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_3">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_3>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_2">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_2>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_1">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_1>
        </#if>
    <#else>
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_I2C4_MASTER>
    </#if>
<#assign I2C_SLAVE_ISR_VECTOR = CONFIG_INT_VECT_I2C4_SLAVE>
<#assign I2C_BUS_ISR_VECTOR = CONFIG_INT_VECT_I2C4_BUS>
</#if>
<#if DRV_I2C_ID == "I2C_ID_5">
    <#if DRV_I2C_BIT_BANG == true>
        <#if DRV_TMR_BB_ID == "TMR_ID_9">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_9>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_8">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_8>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_7">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_7>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_6">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_6>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_5">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_5>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_4">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_4>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_3">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_3>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_2">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_2>
        <#elseif DRV_TMR_BB_ID == "TMR_ID_1">
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_TIMER_1>
        </#if>
    <#else>
<#assign I2C_MASTER_ISR_VECTOR = CONFIG_INT_VECT_I2C5_MASTER>
    </#if>
<#assign I2C_SLAVE_ISR_VECTOR = CONFIG_INT_VECT_I2C5_SLAVE>
<#assign I2C_BUS_ISR_VECTOR = CONFIG_INT_VECT_I2C5_BUS>
</#if>
<#if DRV_I2C_INSTANCE == "0">
<#assign I2C_MASTER_ISR_NAME = "DrvI2CMasterInstance0">
<#assign I2C_SLAVE_ISR_NAME = "DrvI2CSlaveInstance0">
<#assign I2C_BUS_ISR_NAME = "DrvI2CErrorInstance0">
<#assign I2C_MASTER_INTPRIO = CONFIG_DRV_I2C_MASTER_INT_PRIORITY_IDX0>
<#assign I2C_SLAVE_INTPRIO = CONFIG_DRV_I2C_SLAVE_INT_PRIORITY_IDX0>
<#assign I2C_ERROR_INTPRIO = CONFIG_DRV_I2C_ERR_INT_PRIORITY_IDX0>
</#if>
<#if DRV_I2C_INSTANCE == "1">
<#assign I2C_MASTER_ISR_NAME = "DrvI2CMasterInstance1">
<#assign I2C_SLAVE_ISR_NAME = "DrvI2CSlaveInstance1">
<#assign I2C_BUS_ISR_NAME = "DrvI2CErrorInstance1">
<#assign I2C_MASTER_INTPRIO = CONFIG_DRV_I2C_MASTER_INT_PRIORITY_IDX1>
<#assign I2C_SLAVE_INTPRIO = CONFIG_DRV_I2C_SLAVE_INT_PRIORITY_IDX1>
<#assign I2C_ERROR_INTPRIO = CONFIG_DRV_I2C_ERR_INT_PRIORITY_IDX1>
</#if>
<#if DRV_I2C_INSTANCE == "2">
<#assign I2C_MASTER_ISR_NAME = "DrvI2CMasterInstance2">
<#assign I2C_SLAVE_ISR_NAME = "DrvI2CSlaveInstance2">
<#assign I2C_BUS_ISR_NAME = "DrvI2CErrorInstance2">
<#assign I2C_MASTER_INTPRIO = CONFIG_DRV_I2C_MASTER_INT_PRIORITY_IDX2>
<#assign I2C_SLAVE_INTPRIO = CONFIG_DRV_I2C_SLAVE_INT_PRIORITY_IDX2>
<#assign I2C_ERROR_INTPRIO = CONFIG_DRV_I2C_ERR_INT_PRIORITY_IDX2>
</#if>
<#if DRV_I2C_INSTANCE == "3">
<#assign I2C_MASTER_ISR_NAME = "DrvI2CMasterInstance3">
<#assign I2C_SLAVE_ISR_NAME = "DrvI2CSlaveInstance3">
<#assign I2C_BUS_ISR_NAME = "DrvI2CErrorInstance3">
<#assign I2C_MASTER_INTPRIO = CONFIG_DRV_I2C_MASTER_INT_PRIORITY_IDX3>
<#assign I2C_SLAVE_INTPRIO = CONFIG_DRV_I2C_SLAVE_INT_PRIORITY_IDX3>
<#assign I2C_ERROR_INTPRIO = CONFIG_DRV_I2C_ERR_INT_PRIORITY_IDX3>
</#if>
<#if DRV_I2C_INSTANCE == "4">
<#assign I2C_MASTER_ISR_NAME = "DrvI2CMasterInstance4">
<#assign I2C_SLAVE_ISR_NAME = "DrvI2CSlaveInstance4">
<#assign I2C_BUS_ISR_NAME = "DrvI2CErrorInstance4">
<#assign I2C_MASTER_INTPRIO = CONFIG_DRV_I2C_MASTER_INT_PRIORITY_IDX4>
<#assign I2C_SLAVE_INTPRIO = CONFIG_DRV_I2C_SLAVE_INT_PRIORITY_IDX4>
<#assign I2C_ERROR_INTPRIO = CONFIG_DRV_I2C_ERR_INT_PRIORITY_IDX4>
</#if>

/* I2C Instance ${DRV_I2C_INSTANCE} Interrupt */

<#if (DRV_I2C_MODE == "DRV_I2C_MODE_MASTER") || (DRV_I2C_STATIC_MODE == "DRV_I2C_MODE_MASTER")>
<@RTOS_ISR VECTOR = I2C_MASTER_ISR_VECTOR NAME = I2C_MASTER_ISR_NAME PRIORITY = I2C_MASTER_INTPRIO/>
<#else>
<@RTOS_ISR VECTOR = I2C_SLAVE_ISR_VECTOR NAME = I2C_SLAVE_ISR_NAME PRIORITY = I2C_SLAVE_INTPRIO/>
</#if>
<#if DRV_I2C_BIT_BANG == false>
<@RTOS_ISR VECTOR = I2C_BUS_ISR_VECTOR NAME = I2C_BUS_ISR_NAME PRIORITY = I2C_ERROR_INTPRIO/>
</#if>
</#macro>
<#if CONFIG_DRV_I2C_INTERRUPT_MODE == true>
<#if CONFIG_PIC32MX == true>
<#if CONFIG_DRV_I2C_INST_IDX0 == true>
<@DRV_I2C_ASM_MX_INT DRV_I2C_INSTANCE="0" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX0/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX1 == true>
<@DRV_I2C_ASM_MX_INT DRV_I2C_INSTANCE="1" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX1/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX2 == true>
<@DRV_I2C_ASM_MX_INT DRV_I2C_INSTANCE="2" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX2/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX3 == true>
<@DRV_I2C_ASM_MX_INT DRV_I2C_INSTANCE="3" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX3/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX4 == true>
<@DRV_I2C_ASM_MX_INT DRV_I2C_INSTANCE="4" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX4/>
</#if>
<#else>
<#if CONFIG_DRV_I2C_INST_IDX0 == true>
<@DRV_I2C_ASM_MZ_INT DRV_I2C_INSTANCE="0" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX0 DRV_I2C_MODE=CONFIG_DRV_I2C_OPERATION_MODE_IDX0 DRV_I2C_STATIC_MODE=CONFIG_DRV_I2C_STATIC_OPERATION_MODE_IDX0 DRV_I2C_BIT_BANG=CONFIG_DRV_I2C_BIT_BANG_IDX0 DRV_TMR_BB_ID=CONFIG_DRV_I2C_BIT_BANG_TMR_MODULE_IDX0/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX1 == true>
<@DRV_I2C_ASM_MZ_INT DRV_I2C_INSTANCE="1" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX1 DRV_I2C_MODE=CONFIG_DRV_I2C_OPERATION_MODE_IDX1 DRV_I2C_STATIC_MODE=CONFIG_DRV_I2C_STATIC_OPERATION_MODE_IDX1 DRV_I2C_BIT_BANG=CONFIG_DRV_I2C_BIT_BANG_IDX1 DRV_TMR_BB_ID=CONFIG_DRV_I2C_BIT_BANG_TMR_MODULE_IDX1/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX2 == true>
<@DRV_I2C_ASM_MZ_INT DRV_I2C_INSTANCE="2" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX2 DRV_I2C_MODE=CONFIG_DRV_I2C_OPERATION_MODE_IDX2 DRV_I2C_STATIC_MODE=CONFIG_DRV_I2C_STATIC_OPERATION_MODE_IDX2 DRV_I2C_BIT_BANG=CONFIG_DRV_I2C_BIT_BANG_IDX2 DRV_TMR_BB_ID=CONFIG_DRV_I2C_BIT_BANG_TMR_MODULE_IDX2/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX3 == true>
<@DRV_I2C_ASM_MZ_INT DRV_I2C_INSTANCE="3" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX3 DRV_I2C_MODE=CONFIG_DRV_I2C_OPERATION_MODE_IDX3 DRV_I2C_STATIC_MODE=CONFIG_DRV_I2C_STATIC_OPERATION_MODE_IDX3 DRV_I2C_BIT_BANG=CONFIG_DRV_I2C_BIT_BANG_IDX3 DRV_TMR_BB_ID=CONFIG_DRV_I2C_BIT_BANG_TMR_MODULE_IDX3/>
</#if>
<#if CONFIG_DRV_I2C_INST_IDX4 == true>
<@DRV_I2C_ASM_MZ_INT DRV_I2C_INSTANCE="4" DRV_I2C_ID=CONFIG_DRV_I2C_PERIPHERAL_ID_IDX4 DRV_I2C_MODE=CONFIG_DRV_I2C_OPERATION_MODE_IDX4 DRV_I2C_STATIC_MODE=CONFIG_DRV_I2C_STATIC_OPERATION_MODE_IDX4 DRV_I2C_BIT_BANG=CONFIG_DRV_I2C_BIT_BANG_IDX4 DRV_TMR_BB_ID=CONFIG_DRV_I2C_BIT_BANG_TMR_MODULE_IDX4/>
</#if>
</#if>
</#if>