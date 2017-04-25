/*******************************************************************************
  ADCHS Peripheral Library Template Implementation

  File Name:
    adchs_AnalogFeatureControl_Unsupported.h

  Summary:
    ADCHS PLIB Template Implementation

  Description:
    This header file contains template implementations
    For Feature : AnalogFeatureControl
    and its Variant : Unsupported
    For following APIs :
        PLIB_ADCHS_ChannelAnalogFeatureEnable
        PLIB_ADCHS_ChannelAnalogFeatureDisable
        PLIB_ADCHS_ChannelIsReady
        PLIB_ADCHS_ChannelIsReadyInterruptEnable
        PLIB_ADCHS_ChannelIsReadyInterruptDisable
        PLIB_ADCHS_ExistsChannelAnalogControl

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

SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY KIND,
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

#ifndef _ADCHS_ANALOGFEATURECONTROL_UNSUPPORTED_H
#define _ADCHS_ANALOGFEATURECONTROL_UNSUPPORTED_H

//******************************************************************************
/* Routines available for accessing VREGS, MASKS, POS, LEN are 

  VREGs: 
    None.

  MASKs: 
    None.

  POSs: 
    None.

  LENs: 
    None.

*/


//******************************************************************************
/* Function :  ADCHS_ChannelAnalogFeatureEnable_Unsupported

  Summary:
    Implements Unsupported variant of PLIB_ADCHS_ChannelAnalogFeatureEnable 

  Description:
    This template implements the Unsupported variant of the PLIB_ADCHS_ChannelAnalogFeatureEnable function.
*/

PLIB_TEMPLATE void ADCHS_ChannelAnalogFeatureEnable_Unsupported( ADCHS_MODULE_ID index , ADCHS_CHANNEL_ID channelID )
{
    PLIB_ASSERT(false, "The device selected does not implement PLIB_ADCHS_ChannelAnalogFeatureEnable");
}


//******************************************************************************
/* Function :  ADCHS_ChannelAnalogFeatureDisable_Unsupported

  Summary:
    Implements Unsupported variant of PLIB_ADCHS_ChannelAnalogFeatureDisable 

  Description:
    This template implements the Unsupported variant of the PLIB_ADCHS_ChannelAnalogFeatureDisable function.
*/

PLIB_TEMPLATE void ADCHS_ChannelAnalogFeatureDisable_Unsupported( ADCHS_MODULE_ID index , ADCHS_CHANNEL_ID channelID )
{
    PLIB_ASSERT(false, "The device selected does not implement PLIB_ADCHS_ChannelAnalogFeatureDisable");
}


//******************************************************************************
/* Function :  ADCHS_ChannelIsReady_Unsupported

  Summary:
    Implements Unsupported variant of PLIB_ADCHS_ChannelIsReady 

  Description:
    This template implements the Unsupported variant of the PLIB_ADCHS_ChannelIsReady function.
*/

PLIB_TEMPLATE bool ADCHS_ChannelIsReady_Unsupported( ADCHS_MODULE_ID index , ADCHS_CHANNEL_ID channelID )
{
    PLIB_ASSERT(false, "The device selected does not implement PLIB_ADCHS_ChannelIsReady");

    return false;
}


//******************************************************************************
/* Function :  ADCHS_ChannelIsReadyInterruptEnable_Unsupported

  Summary:
    Implements Unsupported variant of PLIB_ADCHS_ChannelIsReadyInterruptEnable 

  Description:
    This template implements the Unsupported variant of the PLIB_ADCHS_ChannelIsReadyInterruptEnable function.
*/

PLIB_TEMPLATE void ADCHS_ChannelIsReadyInterruptEnable_Unsupported( ADCHS_MODULE_ID index , ADCHS_CHANNEL_ID channelID )
{
    PLIB_ASSERT(false, "The device selected does not implement PLIB_ADCHS_ChannelIsReadyInterruptEnable");
}


//******************************************************************************
/* Function :  ADCHS_ChannelIsReadyInterruptDisable_Unsupported

  Summary:
    Implements Unsupported variant of PLIB_ADCHS_ChannelIsReadyInterruptDisable 

  Description:
    This template implements the Unsupported variant of the PLIB_ADCHS_ChannelIsReadyInterruptDisable function.
*/

PLIB_TEMPLATE void ADCHS_ChannelIsReadyInterruptDisable_Unsupported( ADCHS_MODULE_ID index , ADCHS_CHANNEL_ID channelID )
{
    PLIB_ASSERT(false, "The device selected does not implement PLIB_ADCHS_ChannelIsReadyInterruptDisable");
}


//******************************************************************************
/* Function :  ADCHS_ExistsChannelAnalogControl_Unsupported

  Summary:
    Implements Unsupported variant of PLIB_ADCHS_ExistsChannelAnalogControl

  Description:
    This template implements the Unsupported variant of the PLIB_ADCHS_ExistsChannelAnalogControl function.
*/

PLIB_TEMPLATE bool ADCHS_ExistsChannelAnalogControl_Unsupported( ADCHS_MODULE_ID index )
{
    return false;
}


#endif /*_ADCHS_ANALOGFEATURECONTROL_UNSUPPORTED_H*/

/******************************************************************************
 End of File
*/

