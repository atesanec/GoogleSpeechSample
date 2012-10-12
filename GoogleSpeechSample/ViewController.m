//
//  ViewController.m
//  GoogleSpeechSample
//
//  Created by Victor Ilinskiy on 10/12/12.
//  Copyright (c) 2012 Victor Ilinskiy. All rights reserved.
//

#import "ViewController.h"
#import "FileOperations.h"
#import "wav_to_flac.h"

@interface ViewController ()

@property(nonatomic, strong) AVAudioRecorder* recorder;
@property(nonatomic, strong) CGoogleSpeechClient* speechClient;

-(IBAction)onRecord:(id)sender;

@end

@implementation ViewController

@synthesize recordButton = _recordButton;
@synthesize recorder = _recorder;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onRecord:(id)sender
{
    NSString* title = _isRecording ? @"Record" : @"Stop";
    [_recordButton setTitle:title forState:UIControlStateNormal];
    
    NSString* wavPath = [[CFileOperations getDocumentsPath] stringByAppendingPathComponent:@"sample.wav"];
    if( !_isRecording ) {
        _isRecording = YES;
        
        [[NSFileManager defaultManager] removeItemAtPath:wavPath error:NULL];
        NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
        
        [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
        [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
        [recordSetting setValue:[NSNumber numberWithInt: 2] forKey:AVNumberOfChannelsKey];
        
        [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
        [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
        
        self.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:wavPath] settings:recordSetting error:NULL];
        [_recorder record];
        return;
    }
    
    _isRecording = NO;
    [_recorder stop];
    NSString* flacPath = [[CFileOperations getDocumentsPath] stringByAppendingPathComponent:@"sample.flac"];
    convertWavToFlac([wavPath UTF8String], [flacPath UTF8String]);
    
    self.speechClient = [[CGoogleSpeechClient alloc] init];
    [_speechClient queryRecognizeSoundFile:flacPath];
}

@end
