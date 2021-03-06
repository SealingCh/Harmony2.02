#include "gfx/libaria/inc/libaria_screen.h"

#include "gfx/hal/gfx.h"

#include "gfx/libaria/inc/libaria_context.h"
#include "gfx/libaria/inc/libaria_layer.h"

laScreen* laScreen_New(laBool persistent, laBool createAtStartup, laScreen_CreateCallback_FnPtr cb)
{
	laScreen* scr = NULL;

	if(laContext_GetActive() == NULL)
		return NULL;

	scr = laContext_GetActive()->memIntf.heap.calloc(1, sizeof(laScreen));
    
	laString_Initialize(&scr->name);

    scr->persistent = persistent;
    scr->createCB = cb;
    scr->created = LA_FALSE;
    
    if(scr->persistent == LA_TRUE && createAtStartup == LA_TRUE)
    {
        scr->createCB(scr);
    
        scr->created = LA_TRUE;
    }
    
	return scr;
}

void laScreen_Delete(laScreen* scr)
{
    uint32_t i;
    
    if(laContext_GetActive() == NULL ||
       scr == NULL || 
       scr->created == LA_FALSE)
        return;
        
	for(i = 0; i < LA_MAX_LAYERS; i++)
	{
	    // if screen is active, turn off all layers
	    if(laContext_GetActive()->activeScreen == scr)
	    {
		    GFX_Set(GFXF_LAYER_ACTIVE, i);
		    GFX_Set(GFXF_LAYER_ENABLED, LA_FALSE);
		    GFX_Set(GFXF_LAYER_BUFFER_FREE, i);
		}
		
		laLayer_Delete(scr->layers[i]);
		    
		laContext_GetActive()->memIntf.heap.free(scr->layers[i]);
		    
		scr->layers[i] = NULL;
	}
	
	scr->created = LA_FALSE;
}

static void setLayerAttributes(laLayer* layer, uint32_t idx)
{    
    uint32_t i;
    
    GFX_Set(GFXF_COLOR_MODE, laContext_GetActive()->colorMode);
    
	GFX_Set(GFXF_LAYER_ACTIVE, idx);
	GFX_Set(GFXF_LAYER_ENABLED, layer->widget.enabled);
	GFX_Set(GFXF_LAYER_VISIBLE, layer->widget.visible);
	GFX_Set(GFXF_LAYER_POSITION, layer->widget.rect.x, layer->widget.rect.y); 
	GFX_Set(GFXF_LAYER_SIZE, layer->widget.rect.width, layer->widget.rect.height); 
	GFX_Set(GFXF_LAYER_BUFFER_COUNT, layer->bufferCount);
	
	// manage buffer settings
	for(i = 0; i < layer->bufferCount; i++)
	{
        if(layer->buffers[i].type == LA_BUFFER_TYPE_AUTO)
        {
            GFX_Set(GFXF_LAYER_BUFFER_COHERENT, i, GFX_TRUE);
	        GFX_Set(GFXF_LAYER_BUFFER_ALLOCATE, i);
	    }
	    else
	        GFX_Set(GFXF_LAYER_BUFFER_ADDRESS, layer->buffers[i].address);
	}
	
	GFX_Set(GFXF_LAYER_VSYNC, layer->vsync);
	GFX_Set(GFXF_LAYER_ALPHA_ENABLE, layer->widget.alphaEnabled);
	GFX_Set(GFXF_LAYER_ALPHA_AMOUNT, layer->widget.alphaAmount);
	GFX_Set(GFXF_LAYER_MASK_ENABLE, layer->maskEnable);
	GFX_Set(GFXF_LAYER_MASK_COLOR, layer->maskColor);
}

laResult laScreen_Show(laScreen* scr)
{
	int i;

	if(laContext_GetActive() == NULL || scr == NULL)
		return LA_FAILURE;
		
    // screen is already active
    if(laContext_GetActive()->activeScreen == scr)
        return LA_FAILURE;
		
	if(scr->created == LA_FALSE)
	{
	    scr->createCB(scr);
        scr->created = LA_TRUE;
    }
    
    GFX_Set(GFXF_COLOR_MODE, laContext_GetActive()->colorMode);
    
	for(i = 0; i < LA_MAX_LAYERS; i++)
	{
		GFX_Set(GFXF_LAYER_ACTIVE, i);
		
		// turn on existing layers
		if(scr->layers[i] != NULL)
		{
			setLayerAttributes(scr->layers[i], i);
			
			laWidget_Invalidate((laWidget*)scr->layers[i]);
	    }
	}

	laContext_GetActive()->activeScreen = scr;

    // call show callback if set
    if(scr->showCB != NULL)
        scr->showCB(scr);

	return LA_SUCCESS;
}

laResult laScreen_Hide(laScreen* scr)
{
	int i;

	if(scr == NULL ||
	   laContext_GetActive() == NULL ||
	   laContext_GetActive()->activeScreen != scr)
		return LA_FAILURE;

    // call hide callback if set
    if(scr->hideCB != NULL)
        scr->hideCB(scr);

    // TODO change this to use laScreen_Destroy
	for(i = 0; i < LA_MAX_LAYERS; i++)
	{
		// turn off all layers
		GFX_Set(GFXF_LAYER_ACTIVE, i);
		GFX_Set(GFXF_LAYER_ENABLED, LA_FALSE);
		GFX_Set(GFXF_LAYER_BUFFER_FREE, i);
		
		if(scr->persistent == LA_FALSE)
		{
		    laLayer_Delete(scr->layers[i]);
		    
		    laContext_GetActive()->memIntf.heap.free(scr->layers[i]);
		    
		    scr->layers[i] = NULL;
		    
		    scr->created = LA_FALSE;
		}
	}
	
	GFX_Set(GFXF_LAYER_BUFFER_COUNT, 0);

	laContext_GetActive()->activeScreen = NULL;

	return LA_SUCCESS;
}

laResult laScreen_SetLayer(laScreen* scr, uint32_t idx, laLayer* layer)
{
	if(idx > LA_MAX_LAYERS - 1)
		return LA_FAILURE;

	if(scr->layers[idx] != NULL)
		scr->layers[idx]->screen = NULL;

	scr->layers[idx] = layer;
	layer->screen = scr;
	
    // don't worry about updating HAL if this screen is not active
	if(laContext_GetActive()->activeScreen == scr)
		setLayerAttributes(layer, idx);

	return LA_SUCCESS;
}

int32_t laScreen_GetLayerIndex(laScreen* scr, laLayer* layer)
{
	int i = 0;

	for(i = 0; i < LA_MAX_LAYERS; i++)
	{
		if(scr->layers[i] == layer)
			return i;
	}

	return -1;
}

laScreenOrientation laScreen_GetOrientation(laScreen* scr)
{
    if(scr == NULL)
        return 0;
        
    return scr->orientation;
}

laResult laScreen_SetOrientation(laScreen* scr, laScreenOrientation ori)
{
    if(scr == NULL)
        return LA_FAILURE;
        
    scr->orientation = ori;
    
    return LA_SUCCESS;
}

laScreen_ShowHideCallback_FnPtr laScreen_GetShowEventCallback(laScreen* scr)
{
    if(scr == NULL)
        return NULL;
        
    return scr->showCB;
}

laResult laScreen_SetShowEventCallback(laScreen* scr,
                                       laScreen_ShowHideCallback_FnPtr cb)
{
    if(scr == NULL)
        return LA_FAILURE;
        
    scr->showCB = cb;
    
    return LA_SUCCESS;
}

laScreen_ShowHideCallback_FnPtr laScreen_GetHideEventCallback(laScreen* scr)
{
    if(scr == NULL)
        return NULL;
        
    return scr->hideCB;
}

laResult laScreen_SetHideEventCallback(laScreen* scr,
                                       laScreen_ShowHideCallback_FnPtr cb)
{
    if(scr == NULL)
        return LA_FAILURE;
        
    scr->hideCB = cb;
    
    return LA_SUCCESS;
}