#include "gfx/libaria/inc/libaria_widget_progressbar.h"

#if LA_PROGRESSBAR_WIDGET_ENABLED

#include "gfx/libaria/inc/libaria_context.h"
#include "gfx/libaria/inc/libaria_string.h"
#include "gfx/libaria/inc/libaria_utils.h"
#include "gfx/libaria/inc/libaria_widget.h"

#define DEFAULT_WIDTH           100
#define DEFAULT_HEIGHT          25

void _laProgressBarWidget_Constructor(laProgressBarWidget* bar)
{
	_laWidget_Constructor((laWidget*)bar);
	
	bar->widget.destructor = (laWidget_Destructor_FnPtr)&_laProgressBarWidget_Destructor;

	bar->widget.type = LA_WIDGET_PROGRESSBAR;

	// override base class methods
	bar->widget.paint = (laWidget_Paint_FnPtr)&_laProgressBarWidget_Paint;

	bar->widget.rect.width = DEFAULT_WIDTH;
	bar->widget.rect.height = DEFAULT_HEIGHT;

	bar->widget.borderType = LA_WIDGET_BORDER_BEVEL;
	bar->widget.drawBackground = LA_TRUE;
}

void _laProgressBarWidget_Destructor(laProgressBarWidget* bar)
{
	_laWidget_Destructor((laWidget*)bar);
}

laProgressBarWidget* laProgressBarWidget_New()
{
	laProgressBarWidget* bar = NULL;

	if(laContext_GetActive() == NULL)
		return NULL;

	bar = laContext_GetActive()->memIntf.heap.calloc(1, sizeof(laProgressBarWidget));

    if(bar == NULL)
        return NULL;
    
	_laProgressBarWidget_Constructor(bar);

	return bar;
}

laProgressBarDirection laProgressBarWidget_GetDirection(laProgressBarWidget* bar)
{
    if(bar == NULL)
        return 0;
        
    return bar->direction;
}

laResult laProgressBarWidget_SetDirection(laProgressBarWidget* bar, laProgressBarDirection dir)
{
    if(bar == NULL)
        return LA_FAILURE;
        
    if(bar->direction == dir)
        return LA_SUCCESS;
        
    bar->direction = dir;
    
    laWidget_Invalidate((laWidget*)bar);
        
    return LA_SUCCESS;
}

uint32_t laProgressBarWidget_GetValue(laProgressBarWidget* bar)
{
    if(bar == NULL)
        return 0;
        
    return bar->value;
}

laResult laProgressBarWidget_SetValue(laProgressBarWidget* bar, uint32_t value)
{
    if(bar == NULL)
        return LA_FAILURE;
        
    if(bar->value == value)
        return LA_SUCCESS;
    
    if(value > 100)
        value = 100;
    
    bar->value = value;
    
    if(bar->cb != NULL)
        bar->cb(bar, value);
    
    laWidget_Invalidate((laWidget*)bar);
        
    return LA_SUCCESS;
}

laProgressBar_ValueChangedEventCallback laProgressBarWidget_GetValueChangedEventCallback(laProgressBar* bar)
{
    if(bar == NULL)
        return NULL;
        
    return bar->cb;
}

laResult laProgressBarWidget_SetValueChangedCallback(laProgressBar* bar, laProgressBar_ValueChangedEventCallback cb)
{
    if(bar == NULL)
        return LA_FAILURE;
        
    bar->cb = cb;
        
    return LA_SUCCESS;
}

#endif // LA_PROGRESSBAR_WIDGET_ENABLED