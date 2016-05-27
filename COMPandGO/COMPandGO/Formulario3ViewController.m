//
//  Formulario3ViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 19/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import "Formulario3ViewController.h"
#import "Formulario1ViewController.h"

@interface Formulario3ViewController ()

@end

@implementation Formulario3ViewController

-(IBAction)BotonTipoOperacion:(id)sender
{
    
    if (SelectorTipoOperacion.selectedSegmentIndex == 0) {
        TipoOperacionSeleccionada.text = @"VLOS";
    }
    if (SelectorTipoOperacion.selectedSegmentIndex == 1) {
        TipoOperacionSeleccionada.text = @"EVLOS";
    }
    if (SelectorTipoOperacion.selectedSegmentIndex == 2) {
        TipoOperacionSeleccionada.text = @"BVLOS";
    }
    NSString *TipoDeOperacion =  TipoOperacionSeleccionada.text;
    NSLog(@" %@", TipoDeOperacion);
}

- (IBAction)OcultarTeclado:(id)sender {
    [self resignFirstResponder];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

//- (IBAction)EligeTipoOperacion:(id)sender {
//    if ()
//
//
//
//}
@end
