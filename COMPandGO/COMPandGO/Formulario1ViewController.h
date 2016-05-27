//
//  Formulario1ViewController.h
//  COMPandGO
//
//  Created by Jose Braña on 19/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Formulario1ViewController : UIViewController

{
    IBOutlet UITextField *NombreCompletoPilotoCampo;
    IBOutlet UITextField *DniCifNifPilotoCampo;
    IBOutlet UITextField *TlfPilotoCampo;
    IBOutlet UITextField *MailPilotoCampo;
    IBOutlet UITextField *NombreCompletoOperadorCampo;
    IBOutlet UITextField *DniCifNifOperadorCampo;
    IBOutlet UITextField *TlfOperadorCampo;
    IBOutlet UITextField *MailOperadorCampo;
    IBOutlet UITextField *MarcaCampo;
    IBOutlet UITextField *ModeloCampo;
    IBOutlet UITextField *NumSerieCampo;
}



- (IBAction)OcultarTeclado:(id)sender;




@end
