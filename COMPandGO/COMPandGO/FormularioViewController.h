//
//  FormularioViewController.h
//  COMPandGO
//
//  Created by Jose Braña on 21/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//v1

#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface FormularioViewController : UIViewController <MFMailComposeViewControllerDelegate>
{
    
    //IBOutlet UIImageView *Lafoto;
    //UIImage *imagen;
    
    IBOutlet UIScrollView *ScrollVertical;
    __weak IBOutlet UIDatePicker *SelectorFechaHora;
    
    __weak IBOutlet UILabel *MuestraFechaHora;

 
    __weak IBOutlet UIWebView *FlotanteMuestraPdf;

//Cuadros de texto Formulario 1
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
    
//Cuadros de texto Formulario 2
    
//Cuadros de texto Formulario 3
    
    IBOutlet UITextField *TipoOperacionSeleccionada;
    IBOutlet UISegmentedControl *SelectorTipoOperacion;
    IBOutlet UITextField *DescripcionObjetivoCampo;
    IBOutlet UITextField *LocalidadCampo;
    IBOutlet UITextField *MunicipioCampo;
    IBOutlet UITextField *DiasProhibidosCampo;
    IBOutlet UITextField *HorarioProhibidoCampo;
    IBOutlet UITextField *AltitudMaximaCampo;
    IBOutlet UITextField *AlcanceVisualMaximoCampo;
    __weak IBOutlet UIButton *BotonCerrarFlotante;

//Cuadros de texto Formulario 4

    IBOutlet UITextField *FechaCampo;


    
    
     
    
}
- (IBAction)EnviarEmail:(id)sender;
- (IBAction)OcultaFlotantePdf:(id)sender;

- (IBAction)MuestraFlotantePdf:(id)sender;


- (IBAction)OcultarTeclado:(id)sender;

- (IBAction)EstablecerFechaHora:(id)sender;

//Selector de Tipo de Operación de la Página 3 del Formulario
- (IBAction)BotonTipoOperacion:(id)sender;
- (IBAction)GenerarPdfBoton:(id)sender;












@end
