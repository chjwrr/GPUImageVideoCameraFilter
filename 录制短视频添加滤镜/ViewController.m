//
//  ViewController.m
//  录制短视频添加滤镜
//
//  Created by chj on 2017/5/22.
//  Copyright © 2017年 chj. All rights reserved.
//

#import "ViewController.h"

#import "GPUImage.h"

#import "GPUImageBeautifyFilter.h"

@interface ViewController (){
    
    GPUImageVideoCamera *videoCamera;
    
    GPUImageMovieWriter *movieWriter;
    
    NSString *pathToMovie;
    
    
    
    
    // 滤镜
    GPUImageGammaFilter *filter;

}







@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initViews];
    
    UIButton *backButt = [UIButton buttonWithType:UIButtonTypeCustom];
    backButt.frame = CGRectMake(10, 10, 30, 30);
    [backButt setTitle:@"返回" forState:UIControlStateNormal];
    [backButt setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [backButt addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButt];
}

- (void)initViews
{
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPreset640x480 cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIInterfaceOrientationPortrait;
    videoCamera.horizontallyMirrorFrontFacingCamera = NO;
    videoCamera.horizontallyMirrorRearFacingCamera = NO;
    
    
    GPUImageView *filterView = [[GPUImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:filterView];
    
    pathToMovie = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/Movie2.m4v"];
    
    unlink([pathToMovie UTF8String]);
    
    NSLog(@"视频路径%@",pathToMovie);
    NSURL *movieURL = [NSURL fileURLWithPath:pathToMovie];
    
    movieWriter = [[GPUImageMovieWriter alloc] initWithMovieURL:movieURL size:CGSizeMake(480.0, 640.0)];
    
    movieWriter.encodingLiveVideo = YES;
    
  
    
    // 设置滤镜
    filter = [[GPUImageGammaFilter alloc] init];
    [videoCamera addTarget:filter];
    [filter addTarget:movieWriter];
    [filter addTarget:filterView];

    
    
    
    [videoCamera startCameraCapture];
    double delayToStartRecording = 0.5;
    dispatch_time_t startTime = dispatch_time(DISPATCH_TIME_NOW, delayToStartRecording * NSEC_PER_SEC);
    dispatch_after(startTime, dispatch_get_main_queue(), ^(void){
        NSLog(@"Start recording");
        videoCamera.audioEncodingTarget = movieWriter;
        [movieWriter startRecording];
        double delayInSeconds = 10.0;
        dispatch_time_t stopTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(stopTime, dispatch_get_main_queue(), ^(void){
            
            [filter removeTarget:movieWriter];
            videoCamera.audioEncodingTarget = nil;
            
            [movieWriter finishRecording];
            NSLog(@"Movie completed");
            
        });
    });
    
}


- (void)updatePixelWidth:(id)sender
{
    [(GPUImageSepiaFilter *)filter setIntensity:[(UISlider *)sender value]];
}

- (void)play {
    
    NSURL *movieURl = [NSURL fileURLWithPath:pathToMovie];
    
    AVAsset *movieSet = [AVURLAsset URLAssetWithURL:movieURl options:nil];
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:movieSet];
    
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    AVPlayerLayer *playerlayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    playerlayer.frame = self.view.bounds;
    
    playerlayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    [self.view.layer addSublayer:playerlayer];
    
    [player play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
