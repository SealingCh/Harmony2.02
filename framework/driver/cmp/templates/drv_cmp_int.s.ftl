<#--
/*******************************************************************************
  IC Driver Functions for Static Single Instance Driver

  Company:
    Microchip Technology Inc.

  File Name:
    drv_cmp_int.s.ftl

  Summary:
    IC driver interrupt handler templates.

  Description:
    The IC device driver provides a simple interface to manage the IC
    modules on Microchip microcontrollers and this module implements the
    interrupts.
    
  Remarks:
    Static interfaces incorporate the driver instance number within the names
    of the routines, eliminating the need for an object ID or object handle.
    Static single-open interfaces also eliminate the need for the open handle.
*******************************************************************************/

//DOM-IGNORE-BEGIN
/*******************************************************************************
Copyright (c) 2013 released Microchip Technology Inc.  All rights reserved.

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
//DOM-IGNORE-END
-->
<#macro DRV_CMP_ASM_INT DRV_CMP_INSTANCE DRV_CMP_ID>
<#if DRV_CMP_ID == "CMP_ID_1">
<#assign CMP_ISR_VECTOR = CONFIG_INT_VECT_COMPARATOR_1>
</#if>
<#if DRV_CMP_ID == "CMP_ID_2">
<#assign CMP_ISR_VECTOR = CONFIG_INT_VECT_COMPARATOR_2>
</#if>
<#if DRV_CMP_ID == "CMP_ID_3">
<#assign CMP_ISR_VECTOR = CONFIG_INT_VECT_COMPARATOR_3>
</#if>
<#if DRV_CMP_INSTANCE == "0">
<#assign CMP_ISR_NAME = "DrvCMPInstance0">
<#assign CMP_ISR_INTPRIO = CONFIG_DRV_CMP_INT_PRIORITY_IDX0>
</#if>
<#if DRV_CMP_INSTANCE == "1">
<#assign CMP_ISR_NAME = "DrvCMPInstance1">
<#assign CMP_ISR_INTPRIO = CONFIG_DRV_CMP_INT_PRIORITY_IDX1>
</#if>
<#if DRV_CMP_INSTANCE == "2">
<#assign CMP_ISR_NAME = "DrvCMPInstance2">
<#assign CMP_ISR_INTPRIO = CONFIG_DRV_CMP_INT_PRIORITY_IDX2>
</#if>
/* CMP Instance ${DRV_CMP_INSTANCE} Interrupt */
<@RTOS_ISR VECTOR = CMP_ISR_VECTOR NAME = CMP_ISR_NAME PRIORITY = CMP_ISR_INTPRIO/>
</#macro>
<#if CONFIG_DRV_CMP_INTERRUPT_MODE == true>
<#if CONFIG_DRV_CMP_INST_IDX0 == true>
<@DRV_CMP_ASM_INT DRV_CMP_INSTANCE="0" DRV_CMP_ID=CONFIG_DRV_CMP_PERIPHERAL_ID_IDX0/>
</#if>
<#if CONFIG_DRV_CMP_INST_IDX1 == true>
<@DRV_CMP_ASM_INT DRV_CMP_INSTANCE="1" DRV_CMP_ID=CONFIG_DRV_CMP_PERIPHERAL_ID_IDX1/>
</#if>
<#if CONFIG_DRV_CMP_INST_IDX2 == true>
<@DRV_CMP_ASM_INT DRV_CMP_INSTANCE="2" DRV_CMP_ID=CONFIG_DRV_CMP_PERIPHERAL_ID_IDX2/>
</#if>
</#if>
