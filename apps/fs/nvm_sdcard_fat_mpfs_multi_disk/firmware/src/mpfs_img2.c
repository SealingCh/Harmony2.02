/***************************************************************
 * FileName:    mpfs_img2.c
 * Description: Defines an MPFS2 image to be stored in program memory.
 * Processor:   PIC32
 * Compiler:    Microchip C32,XC32
 *
 * NOT FOR HAND MODIFICATION
 * This file is automatically generated by the MPFS2 Utility
 * ALL MODIFICATIONS WILL BE OVERWRITTEN BY THE MPFS2 GENERATOR
 * Generated Wed Jul 30 2014 12:38:06 
 *
 * Software License Agreement
 *
 * Copyright (C) 2012 Microchip Technology Inc.  All rights
 * reserved.
 *
 * Microchip licenses to you the right to use, modify, copy, and distribute
 * software only embedded on a Microchip microcontroller or digital signal 
 * controller that is integrated into your product or third party product
 * (pursuant to the sublicense terms in the accompanying license agreement)

 * You should refer to the license agreement accompanying this 
 * Software for additional information regarding your rights and 
 * obligations.
 *
 * THE SOFTWARE AND DOCUMENTATION ARE PROVIDED "AS IS" WITHOUT
 * WARRANTY OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT
 * LIMITATION, ANY WARRANTY OF MERCHANTABILITY, FITNESS FOR A 
 * PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL
 * MICROCHIP BE LIABLE FOR ANY INCIDENTAL, SPECIAL, INDIRECT OR
 * CONSEQUENTIAL DAMAGES, LOST PROFITS OR LOST DATA, COST OF
 * PROCUREMENT OF SUBSTITUTE GOODS, TECHNOLOGY OR SERVICES, ANY CLAIMS
 * BY THIRD PARTIES (INCLUDING BUT NOT LIMITED TO ANY DEFENSE 
 * THEREOF), ANY CLAIMS FOR INDEMNITY OR CONTRIBUTION, OR OTHER 
 * SIMILAR COSTS, WHETHER ASSERTED ON THE BASIS OF CONTRACT, TORT
 * (INCLUDING NEGLIGENCE), BREACH OF WARRANTY, OR OTHERWISE.
 *
 ***************************************************************/
#include <stdint.h>
#include "system_config.h"

/**************************************
 * MPFS2 Image Data
 **************************************/ 

const uint8_t __attribute__((space(prog),address(DRV_NVM_MEDIA_START_ADDRESS))) __attribute__ ((keep)) NVM_MEDIA_DATA[DRV_NVM_MEDIA_SIZE * 1024] = { \
	0x4d,0x50,0x46,0x53,0x02,0x01,0x01,0x00,0xa8,0x5e,0x20,0x00,0x00,0x00,0x28,0x00, /* MPFS.....^ ...(. */ \
	0x00,0x00,0x0d,0x00,0x00,0x00,0xb5,0x99,0xd8,0x53,0x00,0x00,0x00,0x00,0x00,0x00, /* .........S...... */ \
	0x61,0x62,0x63,0x2e,0x74,0x78,0x74,0x00,0x48,0x65,0x6c,0x6c,0x6f,0x20,0x57,0x6f, /* abc.txt.Hello Wo */ \
	0x72,0x6c,0x64,0x20,0x21                                                         /* rld !            */


};

/**************************************
 * MPFS2 C linkable symbols
 **************************************/
// The entire data array is defined as a single variable to 
// ensure that the linker does not reorder the data chunks in Flash when compiler 
// optimizations are turned on.
struct MEDIA_STORAGE_PARTITION_INFO
{
	const char*     partName;           // name that identifies the partition
										// valid names: "mpfs2", "tcpip_storage";
	unsigned long   partStartOffset;    // the absolute starting offset on that media 
	unsigned long   partSize;           // size of the partition, in bytes
} MPFS_IMAGE_PARTITION_INFO = 
{
	"mpfs2",
	(unsigned long)NVM_MEDIA_DATA,
	sizeof(NVM_MEDIA_DATA),
};

/**************************************************************
 * End of MPFS
 **************************************************************/
