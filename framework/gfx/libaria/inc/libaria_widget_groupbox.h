/*******************************************************************************
 Module for Microchip Graphics Library - Aria User Interface Library

  Company:
    Microchip Technology Inc.

  File Name:
    libaria_widget_groupbox.h

  Summary:
    

  Description:
    This module implements group box widget functions.
*******************************************************************************/

// DOM-IGNORE-BEGIN
/*******************************************************************************
Copyright (c) 2016 released Microchip Technology Inc.  All rights reserved.

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

#ifndef LIBARIA_GROUPBOX_H
#define LIBARIA_GROUPBOX_H
//DOM-IGNORE-END

#include "gfx/libaria/inc/libaria_common.h"

#if LA_GROUPBOX_WIDGET_ENABLED

#include "gfx/libaria/inc/libaria_widget.h"
#include "gfx/libaria/inc/libaria_string.h"

// *****************************************************************************
// *****************************************************************************
// Section: Data Types and Constants
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Enumeration:
    laGroupBoxWidget_t

  Summary:
    

  Description:
    

  Remarks:
    None.
*/		
typedef struct laGroupBoxWidget_t
{
	laWidget widget;

	laString text;

	laHAlignment halign;

	GFXU_ExternalAssetReader* reader;
} laGroupBoxWidget;

void _laGroupBoxWidget_Constructor(laGroupBoxWidget* box);
void _laGroupBoxWidget_Destructor(laGroupBoxWidget* box);

void _laGroupBoxWidget_Paint(laGroupBoxWidget* box);

// *****************************************************************************
// *****************************************************************************
// Section: Routines
// *****************************************************************************
// *****************************************************************************

// *****************************************************************************
/* Function:
    laGroupBoxWidget* laGroupBoxWidget_New()

  Summary:
    

  Description:
    

  Parameters:
	void
	
  Returns:
	laGroupBoxWidget*
	
  Remarks:
    
*/
LIB_EXPORT laGroupBoxWidget* laGroupBoxWidget_New();

LIB_EXPORT void laGroupBoxWidget_GetText(laGroupBoxWidget* box, laString* str);
LIB_EXPORT void laGroupBoxWidget_SetText(laGroupBoxWidget* box, laString str);

// *****************************************************************************
/* Function:
    laHAlignment laGroupBoxWidget_GetAlignment(laGroupBoxWidget* box)

  Summary:
    

  Description:
    

  Parameters:
	laGroupBoxWidget*
		
  Returns:
	laHAlignment
	
  Remarks:
    
*/
LIB_EXPORT laHAlignment laGroupBoxWidget_GetAlignment(laGroupBoxWidget* box);

// *****************************************************************************
/* Function:
    laResult laGroupBoxWidget_SetAlignment(laGroupBoxWidget* box,
											      laHAlignment align)

  Summary:
    

  Description:
    

  Parameters:
	laGroupBoxWidget*
	laHAlignment
	
  Returns:
	laResult
	
  Remarks:
    
*/
LIB_EXPORT laResult laGroupBoxWidget_SetAlignment(laGroupBoxWidget* box,
											      laHAlignment align);

#endif // LA_GROUPBOX_WIDGET_ENABLED
#endif /* LIBARIA_GROUPBOX_H */