//
//  main.m
//  CAMetadata
//
//  Created by 玉城 辰朗 on 12/09/03.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

int main(int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc]init];
    if(argc < 2){
        printf("Usage: CAMetadata /full/path/to/audiofile\n");
        return -1;
    }
    
    NSString *audioFilePath = [[NSString stringWithUTF8String:argv[1]]
                               stringByExpandingTildeInPath];
    NSURL *audioURL = [NSURL fileURLWithPath:audioFilePath];
    AudioFileID audioFile;
    OSStatus theErr = noErr;
    theErr = AudioFileOpenURL((CFURLRef)audioURL,
                              kAudioFileReadPermission,
                              0,
                              &audioFile);
    assert(theErr == noErr);
    UInt32 dictionarySize = 0;
    theErr = AudioFileGetPropertyInfo (audioFile,
                                       kAudioFilePropertyInfoDictionary,
                                       &dictionarySize,
                                       0);
    assert(theErr== noErr);
    CFDictionaryRef dictionary;
    theErr = AudioFileGetProperty (audioFile,
                                   kAudioFilePropertyInfoDictionary,
                                   &dictionarySize,
                                   &dictionary);
    assert(theErr == noErr);
    NSLog(@"dictionary:%@",dictionary);
    CFRelease(dictionary);
    theErr = AudioFileClose(audioFile);
    assert (theErr == noErr);
    
    [pool drain];
    return 0;
    
}

