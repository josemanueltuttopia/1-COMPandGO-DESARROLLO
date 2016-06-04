//
//  GaleriaViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 3/6/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import "GaleriaViewController.h"
#import <DJISDK/DJISDK.h>
#import <VideoPreviewer/VideoPreviewer.h>




@interface GaleriaViewController ()<DJICameraDelegate, DJISDKManagerDelegate, DJIPlaybackDelegate, DJIBaseProductDelegate>


@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeWorkModeSegmentControl;
@property (weak, nonatomic) IBOutlet UIView *fpvPreviewView;
@property (weak, nonatomic) IBOutlet UILabel *currentRecordTimeLabel;
@property (strong, nonatomic) IBOutlet UIView *playbackBtnsView;
@property (strong, nonatomic) IBOutlet UIButton *playVideoBtn;





@property (weak, nonatomic) IBOutlet UIView *bottomBarView;


@property (strong, nonatomic) DJICameraSystemState* cameraSystemState;
@property (strong, nonatomic) DJICameraPlaybackState* cameraPlaybackState;
@property (strong, nonatomic) NSMutableData *downloadedImageData;
//@property (strong, nonatomic) NSMutableArray *downloadedImageArray;

@property (assign, nonatomic) BOOL isRecording;
//@property (strong, nonatomic) UISwipeGestureRecognizer *swipeLeftGesture;
//@property (strong, nonatomic) UISwipeGestureRecognizer *swipeRightGesture;

- (IBAction)captureAction:(id)sender;
- (IBAction)recordAccion:(id)sender;
- (IBAction)changeWorkModeAccion:(id)sender;

- (IBAction)playVideoBtnAction:(id)sender;

- (IBAction)stopVideoBtnAction:(id)sender;


@end


@implementation GaleriaViewController


- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[VideoPreviewer instance] setView:self.fpvPreviewView];
    [self registerApp];
   }

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    __weak DJICamera* camera = [self fetchCamera];
    if (camera && camera.delegate == self) {
        [camera setDelegate:nil];
    }
    if (camera && camera.playbackManager.delegate == self) {
        [camera.playbackManager setDelegate:nil];
    }
    
    [self cleanVideoPreview];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //[self initData];
  
    // Do any additional setup after loading the view.
}

/*
- (void)initData
{
    self.downloadedImageData = [NSMutableData data];
    self.downloadedImageArray = [NSMutableArray array];
}*/

/*
- (void)initData
{
   
    self.swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeftGestureAction:)];
    self.swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    self.swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeRightGestureAction:)];
    self.swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:self.swipeLeftGesture];
    [self.view addGestureRecognizer:self.swipeRightGesture];
}

- (void)swipeLeftGestureAction:(UISwipeGestureRecognizer *)gesture
{
     __weak GaleriaViewController *weakSelf = self;
    __weak DJICamera* camera = [weakSelf fetchCamera];
    [camera.playbackManager goToNextSinglePreviewPage];
}

- (void)swipeRightGestureAction:(UISwipeGestureRecognizer *)gesture
{
     __weak GaleriaViewController *weakSelf = self;
    __weak DJICamera* camera = [weakSelf fetchCamera];
    [camera.playbackManager goToPreviousSinglePreviewPage];
}

*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)cleanVideoPreview {
    [[VideoPreviewer instance] unSetView];
    
    if (self.fpvPreviewView != nil) {
        [self.fpvPreviewView removeFromSuperview];
        self.fpvPreviewView = nil;
    }
}



- (DJICamera*) fetchCamera {
    
    if (![DJISDKManager product]) {
        return nil;
    }
    
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft*)[DJISDKManager product]).camera;
    }
    
    return nil;
}



- (void)registerApp
{
    NSString *appKey = @"2ea4792d08037f65c6b536e2";
    [DJISDKManager registerApp:appKey withDelegate:self];
}

- (void)showAlertViewWithTitle:(NSString *)title withMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark DJISDKManagerDelegate Method

-(void) sdkManagerProductDidChangeFrom:(DJIBaseProduct* _Nullable) oldProduct to:(DJIBaseProduct* _Nullable) newProduct
{
    if (newProduct) {
        [newProduct setDelegate:self];
        DJICamera* camera = [self fetchCamera];
        if (camera != nil) {
            camera.delegate = self;
            camera.playbackManager.delegate = self;
        }
    }
    
}


- (void)sdkManagerDidRegisterAppWithError:(NSError *)error
{
    NSString* message = @"Register App Successed!";
    if (error) {
        message = @"Register App Failed! Please enter your App Key and check the network.";
        
    }else
    {
        NSLog(@"registerAppSuccess");
        [DJISDKManager startConnectionToProduct];
        [[VideoPreviewer instance] start];
    }
    
    [self showAlertViewWithTitle:@"Register App" withMessage:message];
}



- (NSString *)formattingSeconds:(int)seconds
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *formattedTimeString = [formatter stringFromDate:date];
    return formattedTimeString;
}



#pragma mark - DJICameraDelegate
- (void)camera:(DJICamera *)camera didReceiveVideoData:(uint8_t *)videoBuffer length:(size_t)size
{
    [[VideoPreviewer instance] push:videoBuffer length:(int)size];
}






- (void)camera:(DJICamera *)camera didUpdateSystemState:(DJICameraSystemState *)systemState
{
    self.cameraSystemState = systemState; //Update camera system state

    
    //Update currentRecordTimeLabel State
    self.isRecording = systemState.isRecording;
    [self.currentRecordTimeLabel setHidden:!self.isRecording];
    [self.currentRecordTimeLabel setText:[self formattingSeconds:systemState.currentVideoRecordingTimeInSeconds]];
    
    //Update playbackBtnsView state
    BOOL isPlayback = (systemState.mode == DJICameraModePlayback) || (systemState.mode == DJICameraModeMediaDownload);
    self.playbackBtnsView.hidden = !isPlayback;

    
    //Update recordBtn State
    if (self.isRecording) {
        [self.recordBtn setTitle:@"Stop Record" forState:UIControlStateNormal];
    }else
    {
        [self.recordBtn setTitle:@"Start Record" forState:UIControlStateNormal];
    }
    
    //Update UISegmented Control's state
    if (systemState.mode == DJICameraModeShootPhoto) {
        [self.changeWorkModeSegmentControl setSelectedSegmentIndex:0];
    }else if (systemState.mode == DJICameraModeRecordVideo){
        [self.changeWorkModeSegmentControl setSelectedSegmentIndex:1];
    }else if (systemState.mode == DJICameraModePlayback){
        [self.changeWorkModeSegmentControl setSelectedSegmentIndex:2];
    }
}




#pragma mark - DJIPlaybackDelegate
- (void)playbackManager:(DJIPlaybackManager *)playbackManager didUpdatePlaybackState:(DJICameraPlaybackState *)playbackState
{
    
    if (self.cameraSystemState.mode == DJICameraModePlayback) {
        
        self.cameraPlaybackState = playbackState;
        [self updateUIWithPlaybackState:playbackState];
        
    }else
    {
        [self.playVideoBtn setHidden:YES];
    }
    
}

- (void)updateUIWithPlaybackState:(DJICameraPlaybackState *)playbackState
{
    
    if (playbackState.playbackMode == DJICameraPlaybackModeSingleFilePreview) {
        
        if (playbackState.mediaFileType == DJICameraPlaybackFileFormatJPEG || playbackState.mediaFileType == DJICameraPlaybackFileFormatRAWDNG) { //Photo Type
            
            [self.playVideoBtn setHidden:YES];
            
        }else if (playbackState.mediaFileType == DJICameraPlaybackFileFormatVIDEO) //Video Type
        {
            [self.playVideoBtn setHidden:NO];
        }
        
    }else if (playbackState.playbackMode == DJICameraPlaybackModeSingleVideoPlaybackStart){ //Playing Video
        

        [self.playVideoBtn setHidden:YES];
        
    }else if (playbackState.playbackMode == DJICameraPlaybackModeMultipleFilesPreview){
        

        [self.playVideoBtn setHidden:YES];
  }
}











- (IBAction)captureAction:(id)sender {
    
    __weak GaleriaViewController *weakSelf = self;
    __weak DJICamera *camera = [self fetchCamera];
    
    [camera startShootPhoto:DJICameraShootPhotoModeSingle withCompletion:^(NSError * _Nullable error) {
        
        if (error) {
            UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Take Photo Error" message:error.description delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [errorAlert show];
        }
        
    }];
    

    
    
}

- (IBAction)recordAccion:(id)sender {
    __weak GaleriaViewController *weakSelf = self;
    __weak DJICamera *camera = [self fetchCamera];
    
    if (self.isRecording) {
        
        [camera stopRecordVideoWithCompletion:^(NSError * _Nullable error) {
            
            if (error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Stop Record Error" message:error.description delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlert show];
            }
            
        }];
        
    }else
    {
        [camera startRecordVideoWithCompletion:^(NSError * _Nullable error) {
            
            if (error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Start Record Error" message:error.description delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlert show];
            }
        }];
        
    }

    
    
    
}

- (IBAction)changeWorkModeAccion:(id)sender {
    
    
    __weak GaleriaViewController *weakSelf = self;
    __weak DJICamera *camera = [self fetchCamera];
    
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    if (segmentControl.selectedSegmentIndex == 0) { //CaptureMode
        
        [camera setCameraMode:DJICameraModeShootPhoto withCompletion:^(NSError * _Nullable error) {
            
            if (error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Set CameraWorkModeCapture Failed" message:error.description delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlert show];
            }
            
        }];
        
    }else if (segmentControl.selectedSegmentIndex == 1){ //RecordMode
        
        [camera setCameraMode:DJICameraModeRecordVideo withCompletion:^(NSError * _Nullable error) {
            
            if (error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Set CameraWorkModeRecord Failed" message:error.description delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlert show];
            }
            
        }];
        
    }else if (segmentControl.selectedSegmentIndex == 2){  //PlaybackMode
        
        [camera setCameraMode:DJICameraModePlayback withCompletion:^(NSError * _Nullable error) {
            
            if (error) {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Set CameraWorkModePlayback Failed" message:error.description delegate:weakSelf cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [errorAlert show];
            }
            
        }];
        
    }
    
    
    
    
}

- (IBAction)playVideoBtnAction:(id)sender {
    __weak DJICamera *camera = [self fetchCamera];
    if (self.cameraPlaybackState.mediaFileType == DJICameraPlaybackFileFormatVIDEO) {
        [camera.playbackManager startVideoPlayback];
    }
    
}

- (IBAction)stopVideoBtnAction:(id)sender {
    
    __weak DJICamera *camera = [self fetchCamera];
    if (self.cameraPlaybackState.mediaFileType == DJICameraPlaybackFileFormatVIDEO) {
        if (self.cameraPlaybackState.videoPlayProgress > 0) {
            [camera.playbackManager stopVideoPlayback];
        }
    }

    
}




- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;}
- (BOOL)shouldAutorotate {return NO;}
@end
