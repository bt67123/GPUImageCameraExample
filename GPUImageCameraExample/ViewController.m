//
//  ViewController.m
//  GPUImageCameraExample
//
//  Created by 罗楚健 on 16/8/1.
//  Copyright © 2016年 lcj. All rights reserved.
//

#import "ViewController.h"
#import "GPUImage.h"

@interface ViewController ()
@property (strong, nonatomic) GPUImageVideoCamera *videoCamera;
@property (strong, nonatomic) GPUImageCropFilter *cropFilter;
@property (strong, nonatomic) GPUImageMovieWriter *movieWriter;

@property (strong, nonatomic) IBOutlet GPUImageView *cameraView;
@property (strong, nonatomic) IBOutlet UIButton *captureButton;
@property (strong, nonatomic) IBOutlet UIButton *lookButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initVideoCamera];
}

-(void)initVideoCamera {
    self.videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    self.videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    self.videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    self.videoCamera.horizontallyMirrorRearFacingCamera = NO;
    
    self.cropFilter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.0f, 0.0f, 1.0f, 480/640.0)];
    [self.videoCamera addTarget:self.cropFilter];
    [self.cropFilter addTarget:self.cameraView];
    [self.videoCamera startCameraCapture];
}

- (void)connectMovieWriter {
    NSString *fileName = @"Documents/123.mov";
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    unlink([filePath UTF8String]);
    NSURL *movieURL = [NSURL fileURLWithPath:filePath];
    
    self.movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 480.0)];
    _movieWriter.encodingLiveVideo = YES;
    //_movieWriter.shouldPassthroughAudio = NO;
    _videoCamera.audioEncodingTarget = _movieWriter;
    
    [self.cropFilter addTarget:self.movieWriter];
}

- (void)gotoPlayVideo {
}

- (IBAction)onCaptureButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        [self connectMovieWriter];
        [_movieWriter startRecording];
        [_lookButton setHidden:YES];
    } else {
        [_movieWriter finishRecording];
        [_lookButton setHidden:NO];
    }
}

@end
