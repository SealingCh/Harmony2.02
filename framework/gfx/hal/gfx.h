/*******************************************************************************
 Module for Microchip Graphics Library - Hardware Abstraction Layer

  Company:
    Microchip Technology Inc.

  File Name:
    gfx.h

  Summary:
    Main include file for the MPLAB Harmony Graphics Hardware Abstraction
    Layer

  Description:
    
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

#ifndef GFX_DRIVER_H
#define GFX_DRIVER_H

#include "gfx/hal/inc/gfx_color.h"
#include "gfx/hal/inc/gfx_display.h"
#include "gfx/hal/inc/gfx_draw.h"
#include "gfx/hal/inc/gfx_pixel_buffer.h"
#include "gfx/hal/inc/gfx_rect.h"

typedef struct GFX_Context_t GFX_Context;

// *****************************************************************************
/* Function:
    GFX_Result GFX_Initialize(void);

  Summary:
    Initializes the hardware abstraction layer global state.  Should be called 
    before any other HAL function.   
*/
LIB_EXPORT GFX_Result GFX_Initialize(void);

// *****************************************************************************
/* Function:
    GFX_Result GFX_Initialize(void);

  Summary:
    Creates a hardware abstraction layer context instance.
    
  Parameters:
    GFX_Driver - integer index of the driver to use for this context
    GFX_Display - integer index of the display to use for this context
    GFX_Processor - integer index of the accelerator to use for this context
    GFX_MemoryIntf* - pointer to a custom memory interface definition or NULL.  
                      If NULL, standard library memory interfaces will be used
  
  Returns:
    GFX_Handle - A pointer to the created context or NULL;
*/
LIB_EXPORT GFX_Handle GFX_Open(GFX_Driver driver,
                               GFX_Display display,
                               GFX_Processor processor,
                               GFX_MemoryIntf* intf);
                               
// *****************************************************************************
/* Function:
    void GFX_Close();

  Summary:
    Closes the currently active hardware abstraction layer context.
*/                                                             
LIB_EXPORT void GFX_Close();

// *****************************************************************************
/* Function:
    void GFX_Update();

  Summary:
    Updates the currently active hardware abstraction layer context.  Typically
    calls an update loop the display driver.
*/     
LIB_EXPORT GFX_Result GFX_Update();

// *****************************************************************************
/* Function:
    GFX_Result GFX_Begin();

  Summary:
    Indicates that the application wants to issue draw calls to the frame buffer.
    
  Description:
    This function attempts to lock the frame buffer for modification.  The display
    driver may not allow updates for various reason such as a pending frame buffer
    swap action.

  Returns:
    GFX_Result - Returns GFX_TRUE if the context is ready to draw, otherwise
                 returns GFX_FALSE;
*/   
LIB_EXPORT GFX_Result GFX_Begin();

// *****************************************************************************
/* Function:
    GFX_Result GFX_End();

  Summary:
    Indicates that the application has finished making updates to the frame
    buffer.
*/ 
LIB_EXPORT void GFX_End();

// *****************************************************************************
/* Function:
    GFX_Result GFX_Get(GFX_Flag flag, ...);

  Summary:
    Abstract state data retreival interface.
    
  Description:
    This function is a generic data 'getter' function.  Its first argument is
    always a flag from the 'GFX_Flag's table.  The flag indicates the
    desired data to retrieve.  Flags will often require additional arguments
    to be passed by reference to hold the returned data.
    
    Below is a table describing the function of each flag and its 
    associated arguments:
    
    GFX_Get(GFXF_DISPLAY_COUNT, uint32_t*);
    Gets the number of displays supported

    GFX_Get(GFXF_DISPLAY_INFO, GFX_DisplayInfo*);
    Gets a copy of the display information struct for a display index.

    GFX_Get(GFXF_DRIVER_COUNT, uint32_t*);
    Gets the number of drivers supported by the HAL.

    GFX_Get(GFXF_DRIVER_INFO, GFX_DriverInfo*);
    Gets a copy of the driver information struct for a driver index.

    GFX_Get(GFXF_BRIGHTNESS_RANGE, uint32_t*, uint32_t*);
    Gets the valid range of brightness values supported by a display.

    GFX_Get(GFXF_BRIGHTNESS, uint32_t*);
    Gets the current display brightness setting.

    GFX_Get(GFXF_VSYNC_CALLBACK, GFX_SyncCallback_FnPtr*);
    Gets the function pointer that a driver may call to indicate that it has 
    entered VSYNC state.

    GFX_Get(GFXF_HSYNC_CALLBACK, GFX_SyncCallback_FnPtr*);
    Gets the function pointer that a driver may call to indicate that it has 
    entered HSYNC state.

    GFX_Get(GFXF_ORIENTATION, GFX_Orientation*);
    Gets the orientation mode for a given context.  Raster operation points are
    orthogonally rotated by a right angle multiple in the display space.

    GFX_Get(GFXF_MIRRORED, GFX_Bool*);
    Gets mirroring mode for a given context.  Raster operation points are
    mirrored to the opposite X coordinate in relative space.

    GFX_Get(GFXF_LAYER_COUNT, uint32_t*);
    Gets the number of available driver layers.

    GFX_Get(GFXF_LAYER_ACTIVE, uint32_t*);
    Gets the active layer index.

    GFX_Get(GFXF_LAYER_ENABLED, GFX_Bool*);
    Gets the active layer enabled state.

    GFX_Get(GFXF_LAYER_VISIBLE, GFX_Bool*);
    Gets the active layer visible state.

    GFX_Get(GFXF_LAYER_VSYNC, GFX_Bool*);
    Gets the vsync swap mode of the active layer.  Only relevant for 
    multi-buffer layers.

    GFX_Get(GFXF_LAYER_POSITION, uint32_t*, uint32_t*);
    Gets the X and Y coordinate of the active layer.  Arguments are x and y.

    GFX_Get(GFXF_LAYER_SIZE, uint32_t*, uint32_t*);
    Gets the width and height of the active layer. Arguments are width
    and height.

    GFX_Get(GFXF_LAYER_ALPHA_ENABLE, GFX_Bool*);
    Gets the layer-based alpha blending state for the active layer.

    GFX_Get(GFXF_LAYER_ALPHA_AMOUNT, uint32_t*);
    Gets the layer-based alpha blending amount of the active layer.

    GFX_Get(GFXF_LAYER_MASK_ENABLE, GFX_Bool*);
    Gets the layer-based masking state for the active layer.

    GFX_Get(GFXF_LAYER_MASK_COLOR, GFX_Color*);
    Gets the layer-based masking color for the active layer.

    GFX_Get(GFXF_LAYER_BUFFER_COUNT, uint32_t*);
    Gets the buffer count for the active layer.

    GFX_Get(GFXF_LAYER_BUFFER_ADDRESS, GFX_BUFFER*);
    Gets the pixel data address for a buffer of the active layer.

    GFX_Get(GFXF_LAYER_BUFFER_COHERENT, GFX_Bool*);
    Gets the coherent allocation flag for a buffer of the active layer.

    GFX_Get(GFXF_DRAW_COLOR, GFX_DrawMode*);
    Gets the draw mode for the active context.

    GFX_Get(GFXF_DRAW_COLOR, GFX_Color*);
    Gets the draw color for the active context.

    GFX_Get(GFXF_DRAW_COLOR, GFX_Color*, GFX_Color*, GFX_Color*, GFX_Color*);
    Gets the gradient draw colors for the active context.

    GFX_Get(GFXF_DRAW_PALETTE, GFX_PixelBuffer*);
    Gets the reference palette to be used when performing indexed blit
    operations.

    GFX_Get(GFXF_DRAW_THICKNESS, uint32_t*);
    Gets the draw hint for thickness.

    GFX_Get(GFXF_DRAW_BLEND_MODE, GFX_BlendMode*);
    Gets the combined draw feature mask for the context.  This includes
    masking and alpha blending.

    GFX_Get(GFXF_DRAW_ALPHA_ENABLE, GFX_Bool*);
    Gets the per-pixel alpha blend enabled flag. 

    GFX_Get(GFXF_DRAW_ALPHA_AMOUNT, uint32_t*);
    Gets the per-pixel alpha blending amount for the context.

    GFX_Get(GFXF_DRAW_MASK_ENABLE, GFX_Bool*);
    Gets the per-pixel color masking enabled flag.

    GFX_Get(GFXF_DRAW_MASK_VALUE, GFX_Color*);
    Gets the per-pixel color mask value. 

    GFX_Get(GFXF_DRAW_CLIP_ENABLE, GFX_Bool*);
    Gets the clipping enabled flag for the context.  

    GFX_Get(GFXF_DRAW_CLIP_RECT, GFX_Rect*);
    Gets the clip rectangle for the context.

  Returns:
    GFX_Result - Returns GFX_TRUE if the data was retrieved successfully.
                 Otherwise returns GFX_FALSE.
*/ 
LIB_EXPORT GFX_Result GFX_Get(GFX_Flag flag, ...);




// *****************************************************************************
/* Function:
    GFX_Result GFX_Set(GFX_Flag flag, ...);

  Summary:
    Abstract state data modification interface.
    
  Description:
    This function is a generic data 'setter' function.  Its first argument is
    always a flag from the 'GFX_Flag's table.  The flag indicates the
    desired operation to perform.  Operations will often require additional
    arguments to be passed to the function.
    
    Below is a table describing the function of each flag and its 
    associated arguments:
    
    GFX_Set(GFXF_BRIGHTNESS, uint32_t);
    Sets the current display brightness setting.  Must be in the range provided
    by GFXF_BRIGHTNESS_RANGE.

    GFX_Set(GFXF_VSYNC_CALLBACK, GFX_SyncCallback_FnPtr);
    sets the function pointer that a driver may call to indicate that it has
    entered VSYNC state.

    GFX_Set(GFXF_HSYNC_CALLBACK, GFX_SyncCallback_FnPtr);
    Sets the function pointer that a driver may call to indicate that it has
    entered HSYNC state.

    GFX_Set(GFXF_ORIENTATION, GFX_Orientation);
    Sets the orientation mode for a given context.  Raster operation points
    are orthogonally rotated by a right angle multiple in the display space.

    GFX_Set(GFXF_MIRRORED, GFX_Bool);
    Sets the mirroring mode for a given context.  Raster operation points
    are mirrored to the opposite X coordinate in relative space.

    GFX_Set(GFXF_LAYER_ACTIVE, uint32_t);
    Sets the active layer index.

    GFX_Set(GFXF_LAYER_ENABLED, GFX_Bool);
    Sets the active layer enabled state.  This might mean that a hardware
    layer needs to be enabled by the graphics controller.  Drivers may
    need this to manage hardware features.

    GFX_Set(GFXF_LAYER_VISIBLE, GFX_Bool);
    Sets the active layer visible state.  This might mean that a hardware
    layer needs to be set to visible by the graphics controller.  Drivers
    may need this to manage hardware features.

    GFX_Set(GFXF_LAYER_VSYNC, GFX_Bool);
    Sets the vsync swap mode of the active layer.  Only relevant for 
    multi-buffer layers.  In this mode the driver becomes responsible for
    managing the layer swap chain and should perform layer swapping during
    its VSYNC period.  If this option is off, the layer swaps immediately
    upon request.
    
    GFX_Set(GFXF_LAYER_SWAP);
    Indicates that the active layer should advance its swap chain to the
    next valid state.  This is typically done after performing raster
    operations.  If GFXF_LAYER_VSYNC is off then the swap happens
    immediately.  Otherwise it happens at the drivers discretion which
    is most likely during its next VSYNC period.

    GFX_Set(GFXF_LAYER_POSITION, uint32_t, uint32_t);
    Sets the X and Y coordinate of the active layer.  Arguments are x and y.

    GFX_Set(GFXF_LAYER_SIZE, uint32_t, uint32_t);
    Sets the width and height of the active layer. Arguments are width
    and height.  Changing the size of the layer may cause all frame buffers
    owned by that layer to be reallocated.

    GFX_Set(GFXF_LAYER_ALPHA_ENABLE, GFX_Bool);
    Sets the layer-based alpha blending state for the active layer. This is
    mainly a hardware feature and must be supported by the graphics driver.

    GFX_Set(GFXF_LAYER_ALPHA_AMOUNT, uint32_t);
    Sets the layer-based alpha blending amount of the active layer. This is
    mainly a hardware feature and must be supported by the graphics driver.

    GFX_Set(GFXF_LAYER_MASK_ENABLE, GFX_Bool);
    Sets the layer-based masking state for the active layer. This is mainly
    a hardware feature and must be supported by the graphics driver.

    GFX_Set(GFXF_LAYER_MASK_COLOR, GFX_Color);
    Sets the layer-based masking color for the active layer. This is mainly
    a hardware feature and must be supported by the graphics driver.

    GFX_Set(GFXF_LAYER_BUFFER_COUNT, uint32_t);
    Sets the buffer count for the active layer.  Drivers may restrict
    this value.

    GFX_Set(GFXF_LAYER_BUFFER_ADDRESS, GFX_BUFFER);
    Sets the pixel data address for a buffer of the active layer.

    GFX_Set(GFXF_LAYER_BUFFER_COHERENT, GFX_Bool);
    Sets the coherent allocation flag for a buffer of the active layer.
    Coherent buffers will be dynamically allocated from coherent memory
    instead of regular memory if able.

    GFX_Set(GFXF_LAYER_BUFFER_ALLOCATE, uint32_t);
    Indicates that a buffer of the active layer should attempt to
    dynamically allocate its pixel data buffer.  This will return failure
    if the driver has ownership of the buffer or it is already allocated.
    
    GFX_Set(GFXF_LAYER_BUFFER_FREE, uint32_t);
    Indicates that a buffer of the active layer should attempt to free its
    dynamically allocated pixel buffer.  This will return failure if the
    buffer has not been dynamically allocated, or the driver has ownership
    of the buffer.

    GFX_Set(GFXF_DRAW_COLOR, GFX_DrawMode);
    Sets the draw mode for the active context.  This includes drawing shape
    outlines, drawing filled shapes, or drawing gradient filled shapes.

    GFX_Set(GFXF_DRAW_COLOR, GFX_Color);
    Gets the draw color for the active context.  All simple raster operations
    use this color when writing to the write buffer.  The color value is
    expected to be in the same color format as the context.  Mismatching
    will result in rendering errors.

    GFX_Set(GFXF_DRAW_COLOR, GFX_Color, GFX_Color, GFX_Color, GFX_Color);
    Gets the gradient draw colors for the active context.  Gradient-based
    raster operations will use these colors for drawing.  The first two are
    used for biliniear gradient modes and all four are used for quadlinear
    operations.

    GFX_Set(GFXF_DRAW_PALETTE, GFX_PixelBuffer*);
    Sets the reference palette to be used when performing indexed blit
    operations.  Applications decoding palette-based images must use this
    to set the palette before performing the blit operation.

    GFX_Set(GFXF_DRAW_THICKNESS, uint32_t);
    Sets the draw hint for thickness.  Raster operation algorithms may
    reference this value if they support drawing thicker primitives.

    GFX_Set(GFXF_DRAW_BLEND_MODE, GFX_BlendMode);
    Gets the combined draw feature mask for the context.  This includes
    masking and alpha blending.

    GFX_Set(GFXF_DRAW_ALPHA_ENABLE, GFX_Bool);
    Sets the per-pixel alpha blend enabled flag. This enables the alpha
    blending stage of the per-pixel transformation pipeline.  The source
    color mode does not need to contain an alpha channel to be blended
    using this method.

    GFX_Set(GFXF_DRAW_ALPHA_AMOUNT, uint32_t);
    Sets the per-pixel alpha blending amount for the context.  This value
    acts as an alpha channel for every pixel drawn while enabled.  Valid
    values are 0-255.

    GFX_Set(GFXF_DRAW_MASK_ENABLE, GFX_Bool);
    Sets the per-pixel color masking (transparency) enabled flag.  This
    enables the color masking state of the per-pixel transformation
    pipeline.

    GFX_Set(GFXF_DRAW_MASK_VALUE, GFX_Color);
    Sets the per-pixel color mask value. 

    GFX_Get(GFXF_DRAW_CLIP_ENABLE, GFX_Bool*);
    During raster operations, the source pixel color will be compared
    to this.  If it matches the pixel will be discarded.  

    GFX_Set(GFXF_DRAW_CLIP_ENABLE, GFX_Bool);
    Sets the clipping enabled flag for the context.  

    GFX_Set(GFXF_DRAW_CLIP_RECT, GFX_Rect*);
    Any pixel that falls outside of this rectangle will be discarded.

  Returns:
    GFX_Result - Returns GFX_TRUE if the operation was processed
                 successfully. Otherwise returns GFX_FALSE.
*/ 
LIB_EXPORT GFX_Result GFX_Set(GFX_Flag flag, ...);

// *****************************************************************************
/* Function:
    GFX_Result GFX_DrawPixel(int32_t x, int32_t y);

  Summary:
    Sets the pixel at X and Y using the current draw state.

  Parameters:
    x - the x coordinate of the pixel
	y - the y coordinate of the pixel
	
  Returns:
    GFX_Result - Returns GFX_TRUE if the pixel was drawn
                 successfully. Otherwise returns GFX_FALSE.
*/
LIB_EXPORT GFX_Result GFX_DrawPixel(int32_t x, int32_t y);

// *****************************************************************************
/* Function:
    GFX_Result GFX_Result GFX_DrawLine(int32_t x1,
                                       int32_t y1,
                                       int32_t x2,
                                       int32_t y2);

  Summary:
    Draws a line from (x1,y1) to (x2,y2) using the current draw state.

  Parameters:
    x1 - the x component of the first coordinate of the line
	y1 - the y component of the first coordinate of the line
	x2 - the x component of the second coordinate of the line
	y2 - the y component of the second coordinate of the line
	
  Returns:
    GFX_Result - Returns GFX_TRUE if the line was drawn
                 successfully. Otherwise returns GFX_FALSE.
*/
LIB_EXPORT GFX_Result GFX_DrawLine(int32_t x1,
                                   int32_t y1,
                                   int32_t x2,
                                   int32_t y2);

// *****************************************************************************
/* Function:
    GFX_Result GFX_Result GFX_DrawLine(int32_t x,
                                       int32_t x,
                                       int32_t width,
                                       int32_t height);

  Summary:
    Draws a rectangle  using the specified dimensions and the current
    draw state.
    
  Description:
    Draws a rectangle using the coordinates:
        x,y                     x + width - 1, y
        
        x, y + height - 1       x + width - 1, y + height - 1

  Parameters:
    x - the x position of the top left point of the rectangle
	y - the y position of the top left point of the rectangle
	width - the width of the rectangle in pixels
	height - the height of the rectangle in pixels
	
  Returns:
    GFX_Result - Returns GFX_TRUE if the rectangle was drawn
                 successfully. Otherwise returns GFX_FALSE.
*/                                      
LIB_EXPORT GFX_Result GFX_DrawRect(int32_t x,
                                   int32_t y,
                                   int32_t width,
                                   int32_t height);

// *****************************************************************************
/* Function:
    GFX_Result GFX_Result GFX_DrawCircle(int32_t x,
                                         int32_t y,
                                         int32_t radius);

  Summary:
    Draws a circle from using the specified dimensions and the current
    draw state.
    
  Parameters:
    x - the x component of the origin position
	y - the y component of the origin position
	radius - the radius of the circle in pixels
	
  Returns:
    GFX_Result - Returns GFX_TRUE if the circle was drawn
                 successfully. Otherwise returns GFX_FALSE.
*/
LIB_EXPORT GFX_Result GFX_DrawCircle(int32_t x,
                                     int32_t y,
                                     int32_t radius);                       

// *****************************************************************************
/* Function:
    GFX_Result GFX_Result GFX_DrawBlit(GFX_PixelBuffer* buffer,
                                       int32_t src_x,
                                       int32_t src_y,
                                       int32_t src_width,
                                       int32_t src_height,
                                       int32_t dest_x,
                                       int32_t dest_y);

  Summary:
    Blits a buffer of pixels into the frame buffer.
    
  Description:
    A pixel buffer is an array of pixel data that can be applied in bulk, or
    'blit'ed, to the frame buffer.  Pixel buffers may be of a different color
    mode and will be converted to match the destination frame buffer before
    application.
    
  Parameters:
    buffer - the pointer to the source pixel buffer
    
    src_x - the x component of the rectangle of the buffer to blit, usually 0
    
    src_y - the y component of the rectangle of the buffer to blit, usually 0
    
    src_width - width of the rectangle of the buffer to blit, usually the
                entire with of the source buffer
                
    src_height - height of the rectangle of the buffer to blit, usually the
                 entire height of the source buffer
    
    dest_x - the x position to blit the source rectangle in the
             destination buffer
    
    dest_x - the y position to blit the source rectangle in the
             destination buffer
	
  Returns:
    GFX_Result - Returns GFX_TRUE if the circle was drawn
                 successfully. Otherwise returns GFX_FALSE.
*/
LIB_EXPORT GFX_Result GFX_DrawBlit(GFX_PixelBuffer* buffer,
                                   int32_t src_x,
                                   int32_t src_y,
                                   int32_t src_width,
                                   int32_t src_height,
                                   int32_t dest_x,
                                   int32_t dest_y);

// *****************************************************************************
/* Function:
    GFX_Result GFX_HandleInterrupt(uint32_t id);

  Summary:
    A utility function to allow a driver to react to some external event.
    
  Parameters:
    id - the id of the interrupt that occurred
	
  Returns:
    GFX_Result - GFX_TRUE if the driver handled the interrupt as expected.
                 GFX_FALSE otherwise
*/
LIB_EXPORT GFX_Result GFX_HandleInterrupt(uint32_t id);

#endif /* GFX_DRIVER_H */
