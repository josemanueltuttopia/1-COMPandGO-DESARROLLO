//
//  VerPdfViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 26/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import "VerPdfViewController.h"

@interface VerPdfViewController ()

@end

@implementation VerPdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    NSArray *ruta = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [ruta objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/PlanVueloPreliminar.pdf",
                          documentsDirectory];

    //NSString *path = [[NSBundle mainBundle] pathForResource:@"PlanVueloPreliminar" ofType:@"pdf"  inDirectory:documentsDirectory];
    NSURL *url = [NSURL fileURLWithPath:fileName];
    NSURLRequest  *solicita = [NSURLRequest requestWithURL:url];
    [_PantallaPdf loadRequest:solicita];
    [_PantallaPdf setScalesPageToFit:YES];

    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end

