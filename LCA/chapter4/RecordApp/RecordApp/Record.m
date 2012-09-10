//
//  Record.m
//  RecordApp
//
//  Created by 玉城 辰朗 on 12/09/07.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import "Record.h"
#import <AudioToolbox/AudioToolbox.h>
#import "RecordViewController.h"

typedef struct MyRecorder{
    AudioFileID     recordFile;
    SInt64          recordPacket;
    Boolean         running;
}MyRecorder;


static void CheckError(OSStatus error,const char *operation)
{
    if(error == noErr) return;
    
    char errorString[20];
    //see if it appears to be a 4-char-code
    *(UInt32 *)(errorString + 1) = CFSwapInt32HostToBig(error);
    if(isprint(errorString[1]) && isprint(errorString[2]) && isprint(errorString[3]) && isprint(errorString[4])){
        errorString[0] = errorString[5] = '\'';
        errorString[6] = '\0';
    }else
        sprintf(errorString, "%d",(int)error);
    NSLog(stderr, @"Error: %s (%s)\n",operation,errorString);
    
    exit(1);
}

@implementation Record
-(void)recordFunction{
    MyRecorder recorder = {0};
    AudioStreamBasicDescription recordFormat = {0};
    memset(&recordFormat,0,sizeof(recordFormat));
    
    //Configure the output data format to be AAC
    recordFormat.mFormatID = kAudioFormatMPEG4AAC;
    recordFormat.mChannelsPerFrame = 2;
    
    //get the sample rate of the default input device
    //we use this to adapt the output data format to match hardware capabilities
    MyGetDefaultInputDeviceSampleRate(&recordFormat.mSampleRate);
    
    UInt32 propSize = sizeof(recordFormat);
    CheckError(AudiooFormatGetProperty(kAudioFormatProperty_FormatInfo,0,NULL,
                                       &propSize,&recordFormat),
               textField.text = @"AudioFormatGetProperty failed");
    

}
@end


OSStatus MyGetDefaultInputDeviceSampleRate(Float64 *outSampleRate){
    OSStatus error;
    AudioDeviceID deviceID = 0;
    
    //get the default input device
    AudioObjectPropertyAddress propertyAddress;
    UInt32 propertySize;
    propertyAddress.mSelector = kAudioHardwarePropertyDefaultInputDevice;
    pripertyAddress.mScope = kAudioObjectPropertyScopeGlobal;
    propertySize = sizeof(AudioDeviceID);
    error = AudioHardwareServiceGetPropertyData(deviceID,&propertyAddress,0,NULL, &propertySize,outSampleRate);
    return error;
    
    
}

