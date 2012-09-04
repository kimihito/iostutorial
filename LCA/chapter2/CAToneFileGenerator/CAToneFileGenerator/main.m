//
//  main.m
//  CAToneFileGenerator
//
//  Created by 玉城 辰朗 on 12/09/03.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define SAMPLE_RATE 441000 //1
#define DURATION 5.0  //2
#define FILENAME_FORMAT @"%0.3f - square.aif" //3

int main(int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    if(argc < 2){
        printf("Usage: CAToneFileGenerator n\n(where n is tone in Hz)");
        return -1;
    }
    
    double hz = atof(argv[1]);  //4
    assert(hz > 0);
    NSLog(@"generating %f hz tone",hz);
    
    NSString *fileName = [NSString stringWithFormat:FILENAME_FORMAT,hz]; //5
    NSString *filePath = [[[NSFileManager defaultManager] currentDirectoryPath]
                          stringByAppendingPathComponent:fileName];
    NSURL *fileURL = [NSURL fileURLWithPath: filePath];
    
    //Prepare the format
    AudioStreamBasicDescription asbd; //6
    memset(&asbd,0,sizeof(asbd)); //7
    asbd.mSampleRate = SAMPLE_RATE; //8
    asbd.mFormatID = kAudioFormatLinearPCM;
    asbd.mFormatFlags = kAudioFormatFlagIsBigEndian |
    kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    
    asbd.mBitsPerChannel = 16;
    asbd.mChannelsPerFrame = 1;
    asbd.mFramesPerPacket = 1;
    
    asbd.mBytesPerFrame = 2;
    asbd.mBytesPerPacket = 2;
    
    //Set up the file
    AudioFileID audioFile;
    OSStatus audioErr = noErr;
    audioErr = AudioFileCreateWithURL((CFURLRef)fileURL, kAudioFileAIFFType, &asbd, kAudioFileFlags_EraseFile, &audioFile); //9
    
    assert(audioErr == noErr);
    
    //Start writing samples
    long maxSampleCount = SAMPLE_RATE * DURATION; //10
    long sampleCount = 0;
    UInt32 bytesToWrite = 2;
    double wavelengthInSamples = SAMPLE_RATE / hz; //11
    
    while (sampleCount < maxSampleCount){
        for(int i =0; i<wavelengthInSamples;i++){
            //Square wave
            SInt16 sample;
            if(i < wavelengthInSamples /2){ //12
                sample = CFSwapInt16HostToBig(SHRT_MAX); //13
            }else{
                sample = CFSwapInt16HostToBig(SHRT_MIN);
            }
            audioErr = AudioFileWriteBytes(audioFile, false, sampleCount * 2, &bytesToWrite, &sample); //14
            assert(audioErr == noErr);
            sampleCount++; //15
        }
    }
    audioErr = AudioFileClose(audioFile); //16
    assert(audioErr == noErr);
    NSLog(@"write %d samples", sampleCount);
    
    [pool drain];
    return 0;
    
}

