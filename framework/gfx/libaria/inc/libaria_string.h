/*******************************************************************************
 Module for Microchip Graphics Library - Aria User Interface Library

  Company:
    Microchip Technology Inc.

  File Name:
    libaria_string.h

  Summary:
    A string library implementation for the Aria user interface library.  

  Description:
    This is a string library implementation that is used internally by the 
    Aria user interface library.  All of the memory operations are handled
    by the memory interface that is provided by the active libaria
    context.  Applications that wish to use this implementation must ensure
    that the appropriate libaria context is active when calling these
    functions.
    
    This implementation relies on the GFXU_CHAR definition for characters
    provided by the GFX Utils library.  This chararcter definition is 32
    bits in size and allows libaria to support international character code
    points and Unicode encoding standards.
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

#ifndef LIBARIA_STRING_H
#define LIBARIA_STRING_H
//DOM-IGNORE-END

#include "gfx/libaria/inc/libaria_common.h"
#include "gfx/utils/gfx_utils.h"

typedef struct laContext_t laContext;

// *****************************************************************************
/* Structure:
    laString_t

  Summary:
    String definition

  Remarks:
    None.
*/
typedef struct laString_t
{
    GFXU_CHAR*   data; // local string data storage
    uint32_t    capacity; // actual memory capacity of the string
    uint32_t    length; // actual length of the string, typically this is
                        // capacity - 1, but can be less.

    GFXU_FontAsset*  font;  // the font that contains the glyph raster data
                            // for this string
                            
	int32_t     table_index; // if this is not LA_STRING_NULLIDX then this string
	                         // is referencing an index in the string table.  string
	                         // table references are read-only but can be extracted
	                         // to local modifiable versions
} laString;

#define LA_STRING_NULLIDX -1

// *****************************************************************************
/* Function:
    laString* laString_New(laString* src)

   Summary:
    Allocates a memory for a new string

   Parameters:
    laString* src - a string to copy, can be NULL

  Returns:
    laString* - pointer to the newly allocated string

  Remarks:
    Caller is responsible for freeing the memory allocated by this function
*/
LIB_EXPORT laString* laString_New(laString* src);

// *****************************************************************************
/* Function:
    void laString_Delete(laString** str)

   Summary:
    Deletes all memory associated with a string object

   Parameters:
    laString** str - pointer to a pointer to a string object

  Returns:
    void

  Remarks:
    Will free local string data and the memory for the string pointer itself,
    setting the pointer to NULL if successful
*/
LIB_EXPORT void laString_Delete(laString** str);

// *****************************************************************************
/* Function:
    void laString_Initialize(laString* str)

   Summary:
    Initializes a string struct to default

   Parameters:
    laString* str - pointer to a string object

  Returns:
    void

  Remarks:
    Allocates no memory
*/
LIB_EXPORT void laString_Initialize(laString* str);

// *****************************************************************************
/* Function:
    laString laString_CreateFromBuffer(const GFXU_CHAR* chr, GFXU_FontAsset* fnt)

   Summary:
    Creates a string object from a GFXU_CHAR buffer and a font asset pointer

   Parameters:
    const GFXU_CHAR* chr - pointer to a GFXU_CHAR buffer, can be NULL
    GFXU_FontAsset* fnt - pointer to a font asset, can be NULL

  Returns:
    laString - created string object

  Remarks:
    Makes an internal copy of the input buffer for the string object.  Caller
    is responsible for the allocated memory but does not need to preserve the
    input buffer to maintain the string buffer state.
    
    Caller must also ensure that the font contains all the glyphs for the
    string or rendering may not be possible.
*/
LIB_EXPORT laString laString_CreateFromBuffer(const GFXU_CHAR* chr, GFXU_FontAsset* fnt);

// *****************************************************************************
/* Function:
    laString laString_CreateFromCharBuffer(const char* chr, GFXU_FontAsset* fnt)

   Summary:
    Creates a string object from a const char* buffer and a font asset pointer.
    This method provides compatibility with standard c-style strings.  Input
    string will be converted from 8-bit with to 32-bit width.

   Parameters:
    const char* chr - pointer to a const char* buffer, can be NULL
    GFXU_FontAsset* fnt - pointer to a font asset, can be NULL

  Returns:
    laString - created string object

  Remarks:
    Makes an internal copy of the input buffer for the string object.  Caller
    is responsible for the allocated memory but does not need to preserve the
    input buffer to maintain the string buffer state.
    
    Caller must also ensure that the font contains all the glyphs for the
    string or rendering may not be possible.
*/
LIB_EXPORT laString laString_CreateFromCharBuffer(const char* chr, GFXU_FontAsset* fnt);

// *****************************************************************************
/* Function:
    laString laString_CreateFromID(uint32_t id)

   Summary:
    Creates a string object that simply references a string in the string table.

   Parameters:
    uint32_t id - the string table id to use

  Returns:
    laString - created string object

  Remarks:
    Allocates no memory.
*/
LIB_EXPORT laString laString_CreateFromID(uint32_t id);

// *****************************************************************************
/* Function:
    void laString_Allocate(laString* str, uint32_t size)

   Summary:
    Attempts to resize the local data buffer for a string.

   Parameters:
    laString* str - the string to modify
    uint32_t size - the desired size of the string

  Returns:
    laResult - LA_SUCCESS if the function succeeded

  Remarks:
    If size is zero then the memory will be freed and the function will return
    success.
*/
LIB_EXPORT laResult laString_Allocate(laString* str, uint32_t size);

// *****************************************************************************
/* Function:
    laResult laString_Set(laString* str, const GFXU_CHAR* buffer)

   Summary:
    Attempts to set the local data buffer of a string to an input buffer

   Parameters:
    laString* str - the string to modify
    const GFXU_CHAR* buffer - the input buffer

  Returns:
    laResult - LA_SUCCESS if the function succeeded

  Remarks:
    Makes an internal copy of the input buffer for the string object.  Caller
    is responsible for the allocated memory but does not need to preserve the
    input buffer to maintain the string buffer state.
        
    Caller must also ensure that the font contains all the glyphs for the
    string or rendering may not be possible.
*/
LIB_EXPORT laResult laString_Set(laString* str, const GFXU_CHAR* buffer);

// *****************************************************************************
/* Function:
    void laString_Destroy(laString* str)

   Summary:
    Destroys a string object.  This frees the strings internal data buffer, if
    it exists, sets its string table reference to null, and clears all supporting
    attributes.

   Parameters:
    laString* str - the string to modify
*/
LIB_EXPORT void laString_Destroy(laString* str);

// *****************************************************************************
/* Function:
    laResult laString_Copy(laString* dst, const laString* src)

   Summary:
    Copies the values from one string into another

   Parameters:
    laString* dst - the destination string object
    laString* src - the source string object

  Returns:
    laResult - LA_SUCCESS if the function succeeded

  Remarks:
    Makes duplicate of a given string.  Destination will have the same length and
    data but may not have the same overall capacity.  The source may have lots of
    unused space and the destination may not match to avoid waste.  Caller
    is responsible for the allocated memory but does not need to preserve the
    input string to maintain the destination string buffer state.
        
    Caller must also ensure that the font contains all the glyphs for the
    string or rendering may not be possible.
*/
LIB_EXPORT laResult laString_Copy(laString* dst, const laString* src);

// *****************************************************************************
/* Function:
    void laString_ExtractFromTable(laString* dst, uint32_t table_index)

   Summary:
    Extracts a read-only string from the string table into a modifiable
    string object.  This relies on the active context to indicate which string
    table to reference as well as which language entry to extract.

   Parameters:
    laString* dst - the destination string object
    uint32_t table_index - the table index to extract

  Returns:
    void

  Remarks:
    Caller is responsible for the allocated memory but does not need to preserve the
    input buffer to maintain the string buffer state.
*/
LIB_EXPORT void laString_ExtractFromTable(laString* dst, uint32_t table_index);

// *****************************************************************************
/* Function:
    GFXU_CHAR laString_CharAt(const laString* str, uint32_t idx)

   Summary:
    Extracts the code point for the character in a string at a given index.

   Parameters:
    const laString* str - the string to reference
    uint32_t idx - the character index to reference

  Returns:
    GFXU_CHAR - the code point of the character
*/
LIB_EXPORT GFXU_CHAR laString_CharAt(const laString* str, uint32_t idx);

// *****************************************************************************
/* Function:
    uint32_t laString_Length(const laString* str)

   Summary:
    Calculates the length of a string in characters

   Parameters:
    const laString* str - the string to reference

  Returns:
    uint32_t - the number of characters in the string
*/
LIB_EXPORT uint32_t laString_Length(const laString* str);

// *****************************************************************************
/* Function:
    void laString_ReduceLength(laString* str, uint32_t length)

   Summary:
    Reduces the length of a string.  This simply slides the null terminator to
    the left and does not affect the string's capacity value.

   Parameters:
    laString* str - the string to modify
    uint32_t length - the new desired length in characters

  Returns:
    void
*/
LIB_EXPORT void laString_ReduceLength(laString* str, uint32_t length);

// *****************************************************************************
/* Function:
    uint32_t laString_Capacity(const laString* str)

   Summary:
    Returns the capacity of a string

   Parameters:
    const laString* str - the string to reference

  Returns:
    uint32_t - the capacity of a string in characters
*/
LIB_EXPORT uint32_t laString_Capacity(const laString* str);

// *****************************************************************************
/* Function:
    void laString_SetCapacity(laString* str, uint32_t cap)

   Summary:
    Attempts to adjust the capacity of a string

   Parameters:
    laString* str - the string to modify
    uint32_t cap - the new desired capacity
    
  Returns:
    laResult - LA_SUCCESS if the operation succeeded
*/
LIB_EXPORT laResult laString_SetCapacity(laString* str, uint32_t cap);

// *****************************************************************************
/* Function:
    int32_t laString_Compare(const laString* lstr, const laString* rstr)

   Summary:
    Compares two string objects

   Parameters:
    const laString* lstr - the left argument
    const laString* rstr - the right argument
    
  Returns:
    int32_t - the result of the string comparison, 0 if the strings are equal
              see strcmp() for more information
*/
LIB_EXPORT int32_t laString_Compare(const laString* lstr, const laString* rstr);

// *****************************************************************************
/* Function:
    int32_t laString_Compare(const laString* lstr, const GFXU_CHAR* buffer)

   Summary:
    Compares a string object and a GFXU_CHAR* buffer

   Parameters:
    const laString* lstr - the string
    const GFXU_CHAR* buffer - the GFXU_CHAR buffer
    
  Returns:
    int32_t - the result of the string comparison, 0 if the strings are equal
              see strcmp() for more information
*/
LIB_EXPORT int32_t laString_CompareBuffer(const laString* str, const GFXU_CHAR* buffer);

// *****************************************************************************
/* Function:
    void laString_Append(laString* dst, const laString* src)

   Summary:
    Appends a string onto the end of another string

   Parameters:
    laString* dst - the destination string
    const laString* src - the source string
    
  Returns:
    laResult - LA_SUCCESS if the operation succeeded
*/
LIB_EXPORT laResult laString_Append(laString* dst, const laString* src);

// *****************************************************************************
/* Function:
    void laString_Insert(laString* dst,const laString* src, uint32_t idx)

   Summary:
    Inserts a string into another string at a given index

   Parameters:
    laString* dst - the destination string
    const laString* src - the source string
    uint32_t idx - the insertion index
    
  Returns:
    laResult - LA_SUCCESS if the operation succeeded
*/
LIB_EXPORT laResult laString_Insert(laString* dst, const laString* src, uint32_t idx);

// *****************************************************************************
/* Function:
    void laString_Clear(laString* str)

   Summary:
    Sets a string's length to zero and its string table reference to NULL.
    Does not free any associated data and preserves capacity.

   Parameters:
    laString* str - the string to modify
    
  Returns:
    void
*/
LIB_EXPORT void laString_Clear(laString* str);


// *****************************************************************************
/* Function:
    uint32_t laString_ToCharBuffer(const laString* str,
								   GFXU_CHAR* buffer,
								   uint32_t size)

   Summary:
    Extracts the data buffer from a string and copies it into the provided
    buffer argument.

   Parameters:
    laString* str - the string to reference
    GFXU_CHAR* buffer - the destination buffer
    uint32_t size - the max size of the destination buffer
    
  Returns:
    uint32_t - the number of characters copied
*/
LIB_EXPORT uint32_t laString_ToCharBuffer(const laString* str,
									      GFXU_CHAR* buffer,
									      uint32_t size);

// *****************************************************************************
/* Function:
    void laString_GetRect(laString* str, GFX_Rect* rect)

   Summary:
    Calculates the rectangle for a given string object.  References the
    associated font for the height but must perform a summation for each
    character in the string by doing a font meta-data lookup.

   Parameters:
    laString* str - the string to reference
    GFX_Rect* rect - the calculated string rectangle result
    
  Returns:
    void
*/
LIB_EXPORT void laString_GetRect(laString* str, GFX_Rect* rect);

// *****************************************************************************
/* Function:
    uint32_t laString_GetHeight(laString* str)

   Summary:
    Returns the height of a string by referencing its associated font asset
    data.

   Parameters:
    laString* str - the string to reference
    
  Returns:
    uint32_t - the height of the string
*/
LIB_EXPORT uint32_t laString_GetHeight(laString* str);

// *****************************************************************************
/* Function:
    uint32_t laString_GetCharOffset(laString* str, uint32_t idx)

   Summary:
    Returns the offset of a given character index in pixels.

   Parameters:
    laString* str - the string to reference
    uint32_t idx - the character index offset to calculate
    
  Returns:
    uint32_t - the offset in pixels
*/
LIB_EXPORT uint32_t laString_GetCharOffset(laString* str, uint32_t idx);

// *****************************************************************************
/* Function:
    uint32_t laString_GetCharIndexAtPoint(laString* str, int32_t x)

   Summary:
    Given an offset in pixels returns the corresponding character index.

   Parameters:
    laString* str - the string to reference
    int32_t x - x offset in pixels
    
  Returns:
    uint32_t - character index
*/
LIB_EXPORT uint32_t laString_GetCharIndexAtPoint(laString* str, int32_t x);

// *****************************************************************************
/* Function:
    uint32_t laString_GetCharWidth(laString* str, uint32_t idx)

   Summary:
    Given a character index, gets the width of that character.  Only accurate
    if the string has a font associated with it and that font contains all 
    the characters in the string in question.

   Parameters:
    laString* str - the string to reference
    uint32_t x - character index to reference
    
  Returns:
    uint32_t - character width in pixels
*/
LIB_EXPORT uint32_t laString_GetCharWidth(laString* str, uint32_t idx);

// *****************************************************************************
/* Function:
    void laString_Draw(laString* str,
                       int32_t x,
                       int32_t y,
                       GFXU_ExternalAssetReader** reader)

   Summary:
    Wrapper around GFX Utility string draw function for Aria user interface
    library.  Internal use only.

   Parameters:
    laString* str - the string to draw
    int32_t x - x position to render at
    int32_t y - y position to render at
    GFXU_ExternalAssetReader** reader - external reader state machine, if
                                        string font is located external
    
  Returns:
    void
*/
LIB_EXPORT void laString_Draw(laString* str,
                              int32_t x,
                              int32_t y,
                              GFXU_ExternalAssetReader** reader);

#endif // LIBARIA_STRING_H