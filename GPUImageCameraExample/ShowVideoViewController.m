//
//  ShowVideoViewController.m
//  GPUImageCameraExample
//
//  Created by lcj on 16/8/1.
//  Copyright © 2016年 lcj. All rights reserved.
//

#import "ShowVideoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ShowVideoViewController ()
@property (strong, nonatomic) IBOutlet UIView *playView;
@property (strong, nonatomic) AVPlayerLayer *playerLayer;
@property (strong, nonatomic) AVPlayer *player;

@end

@implementation ShowVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSString *fileName = @"Documents/123.mov";
    NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:fileName];
    NSURL *movieURL = [NSURL fileURLWithPath:filePath];
    
    self.player = [AVPlayer playerWithURL:movieURL];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
    [_playView.layer addSublayer:_playerLayer];
    _playerLayer.frame = _playView.bounds;
    [_player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
