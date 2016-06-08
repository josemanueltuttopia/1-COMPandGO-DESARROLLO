//
//  InicioViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 6/6/16.
//  Copyright © 2016 DJI. All rights reserved.
//

#import "InicioViewController.h"

@interface InicioViewController ()



@end

@implementation InicioViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.



    
    NSURL *Boton4Audio = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SonidoCreaPdf" ofType:@"m4a"] ];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)Boton4Audio, & BotonTipo4);

    
    
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

- (IBAction)Suena:(id)sender {
        AudioServicesPlaySystemSound(BotonTipo4);
    
}
@end
