/*******************************************************************************
 Display Tasks

  Company:
    Microchip Technology Inc.

  File Name:
   Display_tasks.c

  Summary:
    Contains the functional implementation of display task for

  Description:
    This file contains the functional implementation of data parsing functions
*******************************************************************************/

// DOM-IGNORE-BEGIN
/*******************************************************************************
Copyright (c) 2014 released Microchip Technology Inc.  All rights reserved.

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

// *****************************************************************************
// *****************************************************************************
// Section: Included Files
// *****************************************************************************
// *****************************************************************************

#include "app.h"
#include "display.h"

/**STATIC VARIABLES*/
static int32_t _displayEvent;
static APP_DISPLAY_DATA _displayData[1];

#ifdef USE_DISPLAY
static void _display_switch_screen();
static void _display_enable_decoder(APP_DECODER_TYPE decoder);
static void _display_track_name();
static void _display_artist_name();
static void _display_album_name();
static void _display_track_length();
static void _display_play_time();

static void _updateLabelWidgetText(laLabelWidget* lbl, const char *data, uint8_t fidx);
extern GFXU_FontAsset* fontList[5];
static int32_t pb_circle_initial_x = 0;
#endif

void APP_DisplayInit(){
#ifdef USE_DISPLAY
    _displayEvent = 0;
    if(CircleIndicator != NULL)
    {
        pb_circle_initial_x = CircleIndicator->widget.rect.x;
    }
    memset((void*)_displayData, 0, sizeof(APP_DISPLAY_DATA));
#endif
}

void APP_DisplayTasks()
{
#ifdef USE_DISPLAY
    if((_displayEvent >> DISPLAY_SWITCH_SCREEN) & 1)
    {
        _display_switch_screen();
        _displayEvent &= ~(1 << DISPLAY_SWITCH_SCREEN);
    }
   // check event bit
    if((_displayEvent >> DISPLAY_ENABLE_WAV) & 1){
        _display_enable_decoder(APP_DECODER_WAV);
        // clear this event
        _displayEvent &= ~(1 << DISPLAY_ENABLE_WAV);
    }
    if((_displayEvent >> DISPLAY_ENABLE_MP3) & 1){
        _display_enable_decoder(APP_DECODER_MP3);
        _displayEvent &= ~(1 << DISPLAY_ENABLE_MP3);
    }
    
    if((_displayEvent >> DISPLAY_TRACK_NAME) & 1){
        _display_track_name();
        _displayEvent &= ~(1 << DISPLAY_TRACK_NAME);
    }
    
    if((_displayEvent >> DISPLAY_ARTIST_NAME) & 1){
        _display_artist_name();
        _displayEvent &= ~(1 << DISPLAY_ARTIST_NAME);
    }
    
    if((_displayEvent >> DISPLAY_ALBUM_NAME) & 1){
        _display_album_name();
        _displayEvent &= ~(1 << DISPLAY_ALBUM_NAME);
    }
    
    if((_displayEvent >> DISPLAY_TRACK_LENGTH) & 1){
        _display_track_length();
        _displayEvent &= ~(1 << DISPLAY_TRACK_LENGTH);
    }
    
    if((_displayEvent >> DISPLAY_PLAY_TIME) & 1){
        _display_play_time();
        _displayEvent &= ~(1 << DISPLAY_PLAY_TIME);
    }
#endif
}

/**
 * provide the application a display API to update screen
 * @param de
 */
void APP_UpdateDisplay(DISPLAY_EVENT de){
    _displayEvent |= (1 << de);
    
}

void APP_UpdateTrackName(const char *data)
{
    if(data != NULL)
    {
        uint8_t cur = 0;
        while(data[cur]!='\0'){
            _displayData->track[cur] = data[cur];
            cur++;
        }
        _displayData->track[cur]='\0';
    }
}

void APP_UpdateArtistName(const char *data)
{
    if(data != NULL)
    {
        uint8_t cur = 0;
        while(data[cur]!='\0'){
            _displayData->artist[cur] = data[cur];
            cur++;
        }
        _displayData->artist[cur]='\0';
    }
}

void APP_UpdateAlbumName(const char *data)
{
    if(data != NULL)
    {
        uint8_t cur = 0;
        while(data[cur]!='\0'){
            _displayData->album[cur] = data[cur];
            cur++;
        }
        _displayData->album[cur]='\0';
    }
}

void APP_UpdateTrackLength(uint32_t data)
{
    if(data != 0)
    {
        _displayData->track_length = data;
    }
}

void APP_UpdatePlaytime(uint32_t data)
{
    _displayData->playtime = data;
}

void APP_UpdateScreen(uint32_t data)
{
    _displayData->screenID = (uint8_t)data;
}
#ifdef USE_DISPLAY
void _display_enable_decoder(APP_DECODER_TYPE decoder)
{
    GFX_Color brightGreen = 0x7C0;
    if(laContext_GetActiveScreenIndex() == MainScreen_ID)
    {
        switch(decoder){
            case APP_DECODER_WAV:
                WAVIndicator->widget.scheme->text = brightGreen;
                laWidget_Invalidate((laWidget*)WAVIndicator);
    //            laLabelWidget_SetTextColor(WAVIndicator, brightGreen);
                break;
            case APP_DECODER_MP3:
                MP3Indicator->widget.scheme->text = brightGreen;
                laWidget_Invalidate((laWidget*)MP3Indicator);
                //laLabelWidget_SetTextColor(MP3Indicator, brightGreen);
                break;
            default:break;
        }
    }    
}



void _display_track_name()
{
    if(laContext_GetActiveScreenIndex() == MainScreen_ID)
    {
        if(_displayData->track[0] != '\0')
        {
            _updateLabelWidgetText(TrackNameLabel, _displayData->track, 3);
        }
    }
    
}
void _display_artist_name()
{
    if(laContext_GetActiveScreenIndex() == MainScreen_ID)
    {
        if(_displayData->artist[0] != '\0')
        {
            _updateLabelWidgetText(TrackArtistLabel, _displayData->artist, 3);
        }
    }
}

void _display_album_name()
{
    if(laContext_GetActiveScreenIndex() == MainScreen_ID)
    {
        if(_displayData->album[0] != '\0')
        {
            _updateLabelWidgetText(TrackAlbumLabel, _displayData->album, 3);
        }
    }
}


void _convertSeconds2TimeString(int32_t data, char* ret)
{
    ret[0] = '\0';
    uint16_t hour  = data/3600;
    uint8_t minute = (data-hour*3600)/60;
    uint8_t second = data - hour*3600 - minute*60;    
    uint8_t cur = 0;
    if(hour != 0)
    {
        sprintf(ret,"%d", hour);
        while(ret[cur] != '\0')
        {
            cur++;
        }
        ret[cur] = ':';
        ret[cur+1] = '\0';
        cur++;
    }

    if(minute != 0)
    {
        sprintf(&(ret[cur]), "%d", minute);
        while(ret[cur] != '\0')
        {
            cur++;
        }
        ret[cur] = ':';
        ret[cur+1] = '\0';
        cur++;
    }else
    {
        ret[cur] = '0';
        ret[cur+1] = '0';
        ret[cur+2] = ':';
        ret[cur+3] = '\0';
        cur += 3;
        
    }

    if(second != 0)
    {
        sprintf(&(ret[cur]), "%d", second);
        if(second/10 == 0)
        {
            char tmp = ret[cur];
            ret[cur] = '0'; 
            ret[cur+1] = tmp;
            ret[cur+2]='\0';
            
        }
        cur += 2;
    }else
    {
        ret[cur] = '0';
        ret[cur+1]='0';
        ret[cur+2] = '\0';
        cur += 2;
    }
}

void _display_track_length()
{
    if(laContext_GetActiveScreenIndex() == MainScreen_ID)
    {
        if(_displayData->track_length != 0)
        {
            char tracklength[16];
            _convertSeconds2TimeString(_displayData->track_length, tracklength);
            _updateLabelWidgetText(TrackLengthLabel, tracklength, 4);
        }
    }
}

void _display_play_time()
{
    if(laContext_GetActiveScreenIndex() == MainScreen_ID)
    {
        int32_t pb_width = ProgressBarRect->widget.rect.width;
        int32_t circle_indicator_offset_x = 0;
        if(_displayData->track_length != 0)
        {
            circle_indicator_offset_x = (pb_width*_displayData->playtime)/_displayData->track_length;

        }
        char playtime[16];
        _convertSeconds2TimeString(_displayData->playtime, playtime);
        _updateLabelWidgetText(PlaytimeLabel, playtime, 4);

        CircleIndicator->widget.rect.x = pb_circle_initial_x+circle_indicator_offset_x;
        laWidget_Invalidate((laWidget*)CircleIndicator);
    }
//    laImageWidget_SetPositionX(CircleIndicator, pb_circle_initial_x+circle_indicator_offset_x);   
}


void _updateLabelWidgetText(laLabelWidget* lbl, const char *data, uint8_t fidx)
{
    GFXU_CHAR gchar_data[64];
    laString str;
    int len = 0;
    while(data[len]!='\0'){
        gchar_data[len] = data[len];
        len ++;
    }
    gchar_data[len] = 0x00;
    
    str = laString_CreateFromBuffer(gchar_data, fontList[fidx]);

//    laLabelWidget_SetTextFont(lbl, fontList[fidx]);
    laLabelWidget_SetText(lbl, str);
}


void _display_switch_screen()
{
    laContext_SetActiveScreen(_displayData->screenID);
}
#endif