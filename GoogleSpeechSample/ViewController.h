//
//  ViewController.h
//  GoogleSpeechSample
//
//  Created by Victor Ilinskiy on 10/12/12.
//  Copyright (c) 2012 Victor Ilinskiy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AVFoundation/AVFoundation.h"
#import "GoogleSpeechClient.h"

@interface ViewController : UIViewController {
@private
    UIButton* _recordButton;
    BOOL _isRecording;
    
    AVAudioRecorder* _recorder;
    CGoogleSpeechClient* _speechClient;
}

@property(nonatomic, strong) IBOutlet UIButton* recordButton;

@end
