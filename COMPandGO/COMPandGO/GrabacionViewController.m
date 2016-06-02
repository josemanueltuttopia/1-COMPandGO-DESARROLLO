//
//  GrabacionViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 31/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import "GrabacionViewController.h"
#import <DJISDK/DJISDK.h>
#import <VideoPreviewer/VideoPreviewer.h>

@interface GrabacionViewController ()<DJICameraDelegate, DJISDKManagerDelegate, DJIBaseProductDelegate>


@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UISegmentedControl *changeWorkModeSegmentControl;
@property (weak, nonatomic) IBOutlet UIView *fpvPreviewView;
@property (assign, nonatomic) BOOL isRecording;
@property (weak, nonatomic) IBOutlet UILabel *currentRecordTimeLabel;

- (IBAction)captureAction:(id)sender;
- (IBAction)recordAction:(id)sender;
- (IBAction)changeWorkModeAction:(id)sender;

@end

@implementation GrabacionViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[VideoPreviewer instance] setView:self.fpvPreviewView];
    [self registerApp];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[VideoPreviewer instance] setView:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.currentRecordTimeLabel setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Custom Methods
- (DJICamera*) fetchCamera {
    
    if (![DJISDKManager product]) {
        return nil;
    }
    
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft*)[DJISDKManager product]).camera;
    }else if ([[DJISDKManager product] isKindOfClass:[DJIHandheld class]]){
        return ((DJIHandheld *)[DJISDKManager product]).camera;
    }
    
    return nil;
}

- (void)showAlertViewWithTitle:(NSString *)title withMessage:(NSString *)message
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)registerApp
{
    NSString *appKey = @"2ea4792d08037f65c6b536e2";
    [DJISDKManager registerApp:appKey withDelegate:self];
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

#pragma mark DJISDKManagerDelegate Method

-(void) sdkManagerProductDidChangeFrom:(DJIBaseProduct* _Nullable) oldProduct to:(DJIBaseProduct* _Nullable) newProduct
{
    if (newProduct) {
        [newProduct setDelegate:self];
        DJICamera* camera = [self fetchCamera];
        if (camera != nil) {
            camera.delegate = self;
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

#pragma mark - DJIBaseProductDelegate Method

-(void) componentWithKey:(NSString *)key changedFrom:(DJIBaseComponent *)oldComponent to:(DJIBaseComponent *)newComponent {
    
    if ([key isEqualToString:DJICameraComponentKey] && newComponent != nil) {
        __weak DJICamera* camera = [self fetchCamera];
        if (camera) {
            [camera setDelegate:self];
        }
    }
}

#pragma mark - DJICameraDelegate
-(void)camera:(DJICamera *)camera didReceiveVideoData:(uint8_t *)videoBuffer length:(size_t)size
{
    [[VideoPreviewer instance] push:videoBuffer length:(int)size];
}

-(void) camera:(DJICamera*)camera didUpdateSystemState:(DJICameraSystemState*)systemState
{
    self.isRecording = systemState.isRecording;
    
    [self.currentRecordTimeLabel setHidden:!self.isRecording];
    [self.currentRecordTimeLabel setText:[self formattingSeconds:systemState.currentVideoRecordingTimeInSeconds]];
    
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
    }
    
}

#pragma mark - IBAction Methods

- (IBAction)captureAction:(id)sender {
    
    __weak GrabacionViewController *weakSelf = self;
    __weak DJICamera* camera = [self fetchCamera];
    if (camera) {
        [camera startShootPhoto:DJICameraShootPhotoModeSingle withCompletion:^(NSError * _Nullable error) {
            if (error) {
                [weakSelf showAlertViewWithTitle:@"Take Photo Error" withMessage:error.description];
            }
        }];
    }
    
}

- (IBAction)recordAction:(id)sender {
    
    __weak GrabacionViewController *weakSelf = self;
    
    __weak DJICamera* camera = [self fetchCamera];
    if (camera) {
        
        if (self.isRecording) {
            
            [camera stopRecordVideoWithCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf showAlertViewWithTitle:@"Stop Record Video Error" withMessage:error.description];
                }
            }];
            
        }else
        {
            [camera startRecordVideoWithCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf showAlertViewWithTitle:@"Start Record Video Error" withMessage:error.description];
                }
            }];
        }
        
    }
}

- (IBAction)changeWorkModeAction:(id)sender {
    
    __weak GrabacionViewController *weakSelf = self;
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    
    __weak DJICamera* camera = [self fetchCamera];
    
    if (camera) {
        
        if (segmentControl.selectedSegmentIndex == 0) { //Take photo
            
            [camera setCameraMode:DJICameraModeShootPhoto withCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf showAlertViewWithTitle:@"Set DJICameraModeShootPhoto Failed" withMessage:error.description];
                }
                
            }];
            
        }else if (segmentControl.selectedSegmentIndex == 1){ //Record video
            
            [camera setCameraMode:DJICameraModeRecordVideo withCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf showAlertViewWithTitle:@"Set DJICameraModeRecordVideo Failed" withMessage:error.description];
                }
                
            }];
            
        }
    }
    
}

@end














//----------OLD
/*
@property (weak, nonatomic) IBOutlet UIButton *botonGrabar;
@property (weak, nonatomic) IBOutlet UISegmentedControl *ControlCambiaModoDeGrabacion;
@property (weak, nonatomic) IBOutlet UIView *PrevioVideo;
@property (assign, nonatomic) BOOL estaGrabando;
@property (weak, nonatomic) IBOutlet UILabel *TiempoDeGrabacion;


- (IBAction)Capturar:(id)sender;
- (IBAction)Grabar:(id)sender;
- (IBAction)CambiarModoDeGrabacion:(id)sender;

@end
//--------------------------------------------------------------------------------------
@implementation GrabacionViewController

- (void)viewDidAppear:(BOOL)animated {
    [[VideoPreviewer instance] setView:self.PrevioVideo];
    [self registerApp];
    
    // Do any additional setup after loading the view.
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[VideoPreviewer instance] setView:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
     [self.TiempoDeGrabacion setHidden:YES];
    
    // Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//--------------------------------------------------------------------------------------

- (DJICamera*) ConectaCamara {
    
    if (![DJISDKManager product]) {
        return nil;
    }
    if ([[DJISDKManager product] isKindOfClass:[DJIAircraft class]]) {
        return ((DJIAircraft*)[DJISDKManager product]).camera;
    }else if ([[DJISDKManager product] isKindOfClass:[DJIHandheld class]]){
        return ((DJIHandheld *)[DJISDKManager product]).camera;
    }
    
    
    return nil;
    
    
    
}

- (void)MuestraAlerta:(NSString *)title withMessage:(NSString *)mensajeDeAlerta
{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:title message:mensajeDeAlerta preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alerta addAction:okAction];
    [self presentViewController:alerta animated:YES completion:nil];
}


- (void)registerApp
{
    NSString *appKey = @"2ea4792d08037f65c6b536e2";
    [DJISDKManager registerApp:appKey withDelegate:self];
}

- (NSString *)ConversionSegundos:(int)seconds
{
    NSDate *fecha = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSDateFormatter *formato = [[NSDateFormatter alloc] init];
    [formato setDateFormat:@"mm:ss"];
    [formato setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    
    NSString *TiempoFormateado = [formato stringFromDate:fecha];
    return TiempoFormateado;
}


-(void) sdkManagerProductDidChangeFrom:(DJIBaseProduct* _Nullable) oldProduct to:(DJIBaseProduct* _Nullable) newProduct
{
    if (newProduct) {
        [newProduct setDelegate:self];
        DJICamera* camara = [self ConectaCamara];
        if (camara != nil) {
            camara.delegate = self;
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
    
    [self MuestraAlerta :@"Register App" withMessage:message];
}






-(void) componentWithKey:(NSString *)key changedFrom:(DJIBaseComponent *)oldComponent to:(DJIBaseComponent *)newComponent {
    
    if ([key isEqualToString:DJICameraComponentKey] && newComponent != nil) {
        __weak DJICamera* camara = [self ConectaCamara];
        if (camara) {
            [camara setDelegate:self];
        }
    }
}


//-------------------------------
-(void)camara:(DJICamera *)camara didReceiveVideoData:(uint8_t *)videoBuffer length:(size_t)size
{
    [[VideoPreviewer instance] push:videoBuffer length:(int)size];
}


//-------------------------------
-(void) camara:(DJICamera*)camara didUpdateSystemState:(DJICameraSystemState*)EstadoDelSistema
{
    self.estaGrabando = EstadoDelSistema.isRecording;
    
    [self.TiempoDeGrabacion setHidden:!self.estaGrabando];
    [self.TiempoDeGrabacion setText:[self ConversionSegundos:EstadoDelSistema.currentVideoRecordingTimeInSeconds]];
    
    if (self.estaGrabando) {
        [self.botonGrabar setTitle:@"STOP" forState:UIControlStateNormal];
    }else
    {
        [self.botonGrabar setTitle:@"START" forState:UIControlStateNormal];
    }
    
    //Update UISegmented Control's state
    if (EstadoDelSistema.mode == DJICameraModeShootPhoto) {
        [self.ControlCambiaModoDeGrabacion setSelectedSegmentIndex:0];
    }else if (EstadoDelSistema.mode == DJICameraModeRecordVideo){
        [self.ControlCambiaModoDeGrabacion
         setSelectedSegmentIndex:1];
    }
    
}





//----------ACCIONES---------------------



- (IBAction)Capturar:(id)sender {
    
    
    __weak GrabacionViewController *weakSelf = self;
    __weak DJICamera* camera = [self ConectaCamara];
    if (camera) {
        [camera startShootPhoto:DJICameraShootPhotoModeSingle withCompletion:^(NSError * _Nullable error) {
            if (error) {
                [weakSelf MuestraAlerta:@"Error de Captura de Imagen" withMessage:error.description];
            }
        }];
    }
    //Con DJICameraShootPhotoModeSingle definimos el Modo de Captura fotográfica entre los seis existentes.
    

}

- (IBAction)Grabar:(id)sender {
   
    __weak GrabacionViewController *weakSelf = self;
    
    __weak DJICamera* camara = [self ConectaCamara];
    if (camara) {
        
        if (self.estaGrabando) {
            
            [camara stopRecordVideoWithCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf MuestraAlerta:@"Stop Record Video Error" withMessage:error.description];
                }
            }];
            
        }else
        {
            [camara startRecordVideoWithCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf MuestraAlerta:@"Start Record Video Error" withMessage:error.description];
                }
            }];
        }
        
    }
}

- (IBAction)CambiarModoDeGrabacion:(id)sender {
    
    __weak GrabacionViewController *weakSelf = self;
    UISegmentedControl *segmentControl = (UISegmentedControl *)sender;
    
    __weak DJICamera* camara = [self ConectaCamara];
    
    if (camara) {
        
        if (segmentControl.selectedSegmentIndex == 0) { //Take photo
            
            [camara setCameraMode:DJICameraModeShootPhoto withCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf MuestraAlerta:@"Set DJICameraModeShootPhoto Failed" withMessage:error.description];
                }
                
            }];
            
        }else if (segmentControl.selectedSegmentIndex == 1){ //Record video
            
            [camara setCameraMode:DJICameraModeRecordVideo withCompletion:^(NSError * _Nullable error) {
                if (error) {
                    [weakSelf MuestraAlerta:@"Set DJICameraModeRecordVideo Failed" withMessage:error.description];
                }
                
            }];
            
        }
    }
    

    
    
}
/*
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;}
- (BOOL)shouldAutorotate {return NO;}



@end
*/