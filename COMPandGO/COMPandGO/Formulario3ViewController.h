//
//  Formulario3ViewController.h
//  COMPandGO
//
//  Created by Jose Braña on 19/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Formulario3ViewController : UIViewController

{

    IBOutlet UITextField *TipoOperacionSeleccionada;
    IBOutlet UISegmentedControl *SelectorTipoOperacion;
 
    IBOutlet UITextField *DescripcionObjetivoCampo;
    
    IBOutlet UITextField *LocalidadCampo;
    
    IBOutlet UITextField *ProvinciaCampo;
    IBOutlet UITextField *DiasProhibidosCampo;

    IBOutlet UITextField *HorarioProhibidoCampo;

    IBOutlet UITextField *AltitudMaximaCampo;

    IBOutlet UITextField *AlcanceVisualMaximoCampo;



}

- (IBAction)BotonTipoOperacion: (id)sender;

- (IBAction)OcultarTeclado:(id)sender;


//- (IBAction)EligeTipoOperacion:(id)sender;


@end
