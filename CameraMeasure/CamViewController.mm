//
//  CamViewController.m
//  CameraMeasure
//
//  Created by Roberto Miranda on 27.05.13.
//  Copyright (c) 2013 Roberto Miranda. All rights reserved.
//

#import "CamViewController.h"
#import "GLOverlayController.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>
#import <opencv2/highgui/cap_ios.h>
#import "CustomCvVideoCamera.h"

@interface CamViewController () <CvVideoCameraDelegate> {
    __weak AVCaptureSession *_captureSession;
}
@property GLOverlayController *overlayController;
@property UIImagePickerController *imagePickerController;
@property (nonatomic, retain) CustomCvVideoCamera* videoCamera;
@end

@implementation CamViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    NSError *error;
//    
//    AVCaptureSession *captureSession = [[AVCaptureSession alloc] init];
//    
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
//        [captureSession setSessionPreset:AVCaptureSessionPreset640x480];
//    else
//        [captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
//    
//    // Select a video device, make an input
//    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
//    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
//    
//    if (!deviceInput) {
//        NSLog(@"No device input found: Error: %@", error);
//    }
//    
//    if ([captureSession canAddInput:deviceInput]) {
//        [captureSession addInput:deviceInput];
//    }
//    
//    AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:captureSession];
//    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    UIView *aView = self.view;
//    previewLayer.frame = aView.bounds; // Assume you want the preview layer to fill the view.
//    [aView.layer addSublayer:previewLayer];
//    _captureSession = captureSession;
//    [_captureSession startRunning];
//    
//    self.overlayController = [[GLOverlayController alloc] initWithNibName:nil bundle:nil];
//    self.overlayController.view.frame = self.view.bounds;
//    [self.view addSubview:self.overlayController.view];

    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:view atIndex:0];
    
    self.videoCamera = [[CustomCvVideoCamera alloc] initWithParentView:view];
    self.videoCamera.delegate = self;
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionBack;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPresetMedium;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UI Actions

- (IBAction)actionStart:(UIButton*)sender;
{
    if ([self.videoCamera running]) {
        [self.videoCamera stop];
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
    else {
        [self.videoCamera start];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    }
}

#pragma mark - Protocol CvVideoCameraDelegate

#ifdef __cplusplus
- (void)processImage:(Mat&)image
{
    // Do some OpenCV stuff with the image
    Mat image_copy;
    cvtColor(image, image_copy, CV_BGRA2BGR);
    
    // invert image
    bitwise_not(image_copy, image_copy);
    cvtColor(image_copy, image, CV_BGR2BGRA);
}
#endif

- (BOOL)shouldAutorotate {
    return NO;
}

@end
