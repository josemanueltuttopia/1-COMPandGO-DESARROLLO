//
//  PrincipalViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 19/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import "PrincipalViewController.h"




@interface PrincipalViewController () 
@end

@implementation PrincipalViewController

- (void)viewDidLoad {
    
    
    NSURL *Boton1Audio = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PulsaSonido" ofType:@"m4a"] ];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)Boton1Audio, & BotonTipo1);
    
    [super viewDidLoad];
    

    
    
}

-(IBAction)Boton1Audio:(id)sender
{
    AudioServicesPlaySystemSound(BotonTipo1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
