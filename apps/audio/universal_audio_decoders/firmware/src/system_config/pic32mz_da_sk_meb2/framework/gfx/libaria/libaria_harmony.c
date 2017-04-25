/*******************************************************************************
  MPLAB Harmony Graphics Composer Generated Implementation File

  File Name:
    libaria_harmony.c

  Summary:
    Build-time generated implementation from the MPLAB Harmony
    Graphics Composer.

  Description:
    Build-time generated implementation from the MPLAB Harmony
    Graphics Composer.

    Created with MPLAB Harmony Version 2.02
*******************************************************************************/
// DOM-IGNORE-BEGIN
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
// DOM-IGNORE-END

#include "gfx/libaria/libaria_harmony.h"
#include "gfx/libaria/libaria_init.h"

#include "gfx/libaria/libaria.h"


/*** libaria Object Global ***/
libaria_objects libariaObj;
static LIBARIA_STATES libariaState;

/*** Message System Service Globals ***/
SYS_MSG_INSTANCE iSysMsg = SYS_MSG_0;
SYS_OBJ_HANDLE hSysMsg, hMsgType, hMailbox;

void LibAria_TouchMessageCallback(SYS_MSG_OBJECT *pMsg);

int32_t LibAria_Initialize(void) 
{
	if(laInitialize() == LA_FAILURE)
		return -1;
		
	libariaObj.context = laContext_Create(0, 0, 0, GFX_COLOR_MODE_RGB_888, NULL);

	if(libariaObj.context == NULL)
		return -1;
	
	laContext_SetActive(libariaObj.context);
	
	libaria_initialize();

	hMsgType = SYS_MSG_TypeCreate(SYS_MSG_0, TYPE_TOUCHSCREEN , 0);
    hMailbox = SYS_MSG_MailboxOpen(SYS_MSG_0, (SYS_MSG_RECEIVE_CALLBACK) &LibAria_TouchMessageCallback );
    SYS_MSG_MailboxMsgAdd( hMailbox, hMsgType);
	
	libariaState = LIBARIA_STATE_RUNNING;
	
	return 0;
}

void LibAria_Tasks(void)
{
    switch(libariaState)
    {
        case LIBARIA_STATE_RUNNING:
		{
			laContext_SetActive(libariaObj.context);
			laUpdate(0);
            
			break;
		}
        
		default:
		{
            break;
		}
    }
}

void LibAria_TouchMessageCallback(SYS_MSG_OBJECT *pMsg)
{	
	if(pMsg->nMessageTypeID == TYPE_TOUCHSCREEN)
	{
		if(pMsg->param0 == EVENT_PRESS)
		{
			laInput_InjectTouchDown(0, pMsg->param1, pMsg->param2);
		}
		else if(pMsg->param0 == EVENT_RELEASE)
		{
			laInput_InjectTouchUp(0, pMsg->param1, pMsg->param2);
		}
		else if(pMsg->param0 == EVENT_MOVE)
		{
			laInput_InjectTouchMoved(0, pMsg->param1, pMsg->param2);
		}
	}
	else if(pMsg->nMessageTypeID == TYPE_KEYBOARD)
	{
	
	}
	else if(pMsg->nMessageTypeID == TYPE_MOUSE)
	{
	
	}
}
