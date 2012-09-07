//
//  main.m
//  Recorder
//
//  Created by 玉城 辰朗 on 12/09/06.
//  Copyright (c) 2012年 com geeoki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define kNumberRecordBuffers 3

#pragma mark user data struct
typedef struct MyRecorder{
    AudioFileID recordFile;
    SInt64      recordPacket;
    Boolean     running;
} MyRecorder;

OSStatus MyGetDefaultInputDeviceSampleRate(Float64 *outSampleRate);

#pragma mark utility functions
static void CheckError(OSStatus error,const char *operation)
{
    if(error == noErr) return;
    
    char errorString[20];
    //See it appears to be a 4-char-code
    *(UInt32 *)(errorString + 1) = CFSwapInt32HostToBig(error);
    if(isprint(errorString[1]) && isprint(errorString[2])&&
       isprint(errorString[3]) && isprint(errorString[4])){
        errorString[0] = errorString[5] = '\'';
        errorString[6] = '\0';
    }else{
        //No format it as an integer
        sprintf(errorString, "%d",(int)error);
        
        exit(1);
    }
}

//get sample rate of the default input device

//Insert Listing 4.20 and 4.21 here
OSStatus MyGetDefaultInputDeviceSampleRate(Float64 *outSampleRate)
{
    OSStatus error;
    AudioDeviceID deviceID = 0;
    
    AudioObjectPropertyAddress propertyAddress;
    UInt32 propertySize;
    propertyAddress.mSelector = kAudioHardwarePropertyDefaultInputDevice;
    propertyAddress.mScope = kAudioObjectPropertyScopeGlobal;
    propertyAddress.mElement = 0;
    propertySize = sizeof(AudioDeviceID);
    error = AudioHardwareServiceGetPropertyData(kAudioObjectSystemObject,
                                                &propertyAddress,
                                                0,
                                                NULL,
                                                &propertySize,
                                                &deviceID);
    if(error) return error;
    propertyAddress.mSelector = kAudioDevicePropertyNominalSampleRate;
    propertyAddress.mScope = kAudioObjectPropertyScopeGlobal;
    propertyAddress.mElement = 0;
    propertySize = sizeof(Float64);
    error = AudioHardwareServiceGetPropertyData(deviceID,
                                                &propertyAddress,
                                                0,
                                                NULL,
                                                &propertySize,
                                                outSampleRate);
    return error;
}

//Insert Listing 4.22 here

static void MyCopyEncoderCookieToFile(AudioQueueRef queue,AudioFileID theFile)
{
    UInt32 propertySize;
    
    OSStatus result = AudioQueueGetPropertySize(queue,
                                      kAudioConverterCompressionMagicCookie,
                                      &propertySize);
    
    if (result == noErr && propertySize > 0) {
        Byte *magicCookie = (Byte *)malloc(propertySize);
        CheckError(AudioQueueGetPropertySize(queue,
                                         kAudioQueueProperty_MagicCookie,
                                         &propertySize),
                "Couldn't get audio queue's magic cookie");
        CheckError(AudioFileSetProperty(theFile, kAudioFilePropertyMagicCookieData,
                                        propertySize,
                                        magicCookie),
                   "Couldn't set audio file's magic cookie");
        free(magicCookie);
    }
}


//Insert Listing 4.23 here
static int MyComputeRecordBufferSize(
                                    const AudioStreamBasicDescription *format,
                                     AudioQueueRef queue,
                                     float seconds)
{
    int packets,frames,bytes;
    
    frames = (int)ceil(seconds * format->mSampleRate);
    
    if(format->mBytesPerFrame >0)
        bytes = frames * format->mBytesPerFrame;
    else
    {
        UInt32 maxPacketSize;
        if(format->mBytesPerFrame >0)
            //Constant packet size
            maxPacketSize = format->mBytesPerPacket;
        else
        {
            //Get the largest single packet size possible
            UInt32 propertySize = sizeof(maxPacketSize);
            CheckError(AudioQueueGetProperty(queue,
                                             kAudioConverterPropertyMaximumOutputPacketSize,
                                                 &maxPacketSize,
                                                 &propertySize),
                       "Couldn't get queue's maximum output packet size");
        }
        if(format->mFramesPerPacket > 0)
            packets = frames / format->mFramesPerPacket;
        else
            //Worst-case scenario: 1 frame in a packet
            packets = frames;
        
        // Sanity check
        if(packets == 0)
            packets = 1;
        bytes = packets * maxPacketSize;
    }
    return bytes;
}

#pragma mark record callback function
//Replace with Listing 4.24-4.26

static void MyAQIntputCallback(void *inUserData,
                               AudioQueueRef inQueue,
                               AudioQueueBufferRef inBuffer,
                               const AudioTimeStamp *inStartTime,
                               UInt32 inNumPackets,
                               const AudioStreamPacketDescription *inPacketDesc)
{
    MyRecorder *recorder = (MyRecorder *)inUserData;
    if(inNumPackets > 0)
    {
        //Write packets to a file
        CheckError(AudioFileWritePackets(recorder->recordFile,
                                         FALSE,
                                         inBuffer -> mAudioDataByteSize,
                                         inPacketDesc,
                                         recorder->recordPacket,
                                         &inNumPackets,
                                         inBuffer->mAudioData),
                   "AudioFileWritePackets failed");
        //Incriment the packet index
        recorder->recordPacket += inNumPackets;
        if(recorder->running)
            CheckError(AudioQueueEnqueueBuffer(inQueue,
                                               inBuffer,
                                               0,
                                               NULL
                                               ),
                       "AudioQueueEnqueueBuffer failed");
    }

}



#pragma mark main function
int main(int argc, const char * argv[])
{
    //Set up format
    MyRecorder recorder = {0};
    AudioStreamBasicDescription recordFormat;
    memset(&recordFormat, 0, sizeof(recordFormat));
    
    recordFormat.mFormatID = kAudioFormatMPEG4AAC;
    recordFormat.mChannelsPerFrame = 2;
    
    MyGetDefaultInputDeviceSampleRate(&recordFormat.mSampleRate);
    
    UInt32 propSize = sizeof(recordFormat);
    CheckError(AudioFormatGetProperty(kAudioFormatProperty_FormatInfo,
                                      0,
                                      NULL,
                                      &propSize,
                                      &recordFormat),
               "AudioFormatGetProperty failed");
    
    
    
    //Set up queue
    AudioQueueRef queue = {0};
    CheckError(AudioQueueNewInput(&recordFormat, MyAQIntputCallback, &recorder, NULL, NULL, 0, &queue),"AudioQueueNewInput failed");
    
    UInt32 size = sizeof(recordFormat);
    CheckError(AudioQueueGetProperty(queue, kAudioConverterCurrentOutputStreamDescription, &recordFormat,&size), "Couldn't get queue's format" );
    
    
    //Set up file
    CFURLRef myFileURL = CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                                       CFSTR("output.caf"),
                                                       kCFURLPOSIXPathStyle,
                                                       false);
    CheckError(AudioFileCreateWithURL(myFileURL,
                                      kAudioFileCAFType,
                                      &recordFormat,
                                      kAudioFileFlags_EraseFile,
                                      &recorder.recordFile),
               "AudioFileCreateWithURL failed");
    CFRelease(myFileURL);
    MyCopyEncoderCookieToFile(queue,recorder.recordFile);
    
    
    
    //Other setup as needed
    int bufferByteSize = MyComputeRecordBufferSize(&recordFormat,queue,0.5);
    int bufferIndex;
    for(bufferIndex =0;
        bufferIndex < kNumberRecordBuffers;
        ++bufferIndex)
    {
        AudioQueueBufferRef buffer;
        CheckError(AudioQueueAllocateBuffer(queue,
                                            bufferByteSize,
                                            &buffer),
                   "AudioQueueAllocateBuffer failed");
        CheckError(AudioQueueEnqueueBuffer(queue,
                                            buffer,
                                            0,
                                            NULL),
                   "AudioQueueEnqueueBuffer failed");
        
    }
    
    //Start queue
    recorder.running = TRUE;
    CheckError(AudioQueueStart(queue,
                               NULL),
               "AudioQueueStart failed");
    
    printf("Recording, press <return> to stop:\n");
    getchar();
    
    //Stop queue
    printf("* recording done *\n");
    recorder.running = FALSE;
    CheckError(AudioQueueStop(queue,
                              TRUE),
               "AudioQueueStop failed");
    MyCopyEncoderCookieToFile(queue,recorder.recordFile);
    AudioFileClose(recorder.recordFile);
    return 0;
    
}



