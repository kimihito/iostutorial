//
//  main.m
//  CAStreamFormatTester
//
//  Created by 玉城 辰朗 on 12/09/04.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

int main(int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    AudioFileTypeAndFormatID fileTypeAndFormat;
    fileTypeAndFormat.mFileType = kAudioFileMP3Type; //1
    fileTypeAndFormat.mFormatID = kAudioFormatMPEG4AAC;
    
    OSStatus audioErr = noErr;
    UInt32 infoSize = 0; //2
    
    audioErr = AudioFileGetGlobalInfoSize( //3
                                          kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof(fileTypeAndFormat), &fileTypeAndFormat, &infoSize);
    if(audioErr != noErr){
        UInt32 err4cc = CFSwapInt32HostToBig(audioErr);
        NSLog(@"audioErr = %4.4s", (char*)&err4cc);
    }
    assert(audioErr == noErr);
    
    AudioStreamBasicDescription *asbds = malloc(infoSize); //4
    audioErr = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_AvailableStreamDescriptionsForFormat, sizeof (fileTypeAndFormat), &fileTypeAndFormat, &infoSize, asbds); //5
    assert(audioErr == noErr);
    
    int asbdCount = infoSize / sizeof(AudioStreamBasicDescription);
    
    for(int i =0; i< asbdCount;i++){ //6
        UInt32 format4cc = CFSwapInt32HostToBig(asbds[i].mFormatID); //7
        NSLog(@"%d: mFormatId:%4.4s,mFormatFlags: %d, mBitsPerChannel: %d",
              i,
              (char*)&format4cc,
              asbds[i].mFormatFlags,
              asbds[i].mBitsPerChannel);
    }
    free(asbds);
    [pool drain];
    return 0;
}

