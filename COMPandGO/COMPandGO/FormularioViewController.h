
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//
//  FormularioViewController.h
//  COMPandGO. v.5.0.7
//
//  Creado por Jose Braña on 21/5/16.
//  Copyright © 2016 Jose Braña. TFG. Universidad Internacional de la Rioja
//
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------------//


#import <UIKit/UIKit.h>
#import <MessageUI/MFMailComposeViewController.h>


@interface FormularioViewController : UIViewController <MFMailComposeViewControllerDelegate>
{

    
    IBOutlet UIScrollView *ScrollVertical;//-----------------SCROLL DEL FORMULARIO
    __weak IBOutlet UIDatePicker *SelectorFechaHora;
    __weak IBOutlet UILabel *MuestraFechaHora;
    __weak IBOutlet UIWebView *FlotanteMuestraPdf;//---------VISTA DE VENTANA FLOTANTE

//CAMPOS DEL FORMULARIO a RELLENAR------------------------------------------------------//
    
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
    IBOutlet UITextField *TipoOperacionSeleccionada;
    IBOutlet UITextField *DescripcionObjetivoCampo;
    IBOutlet UITextField *LocalidadCampo;
    IBOutlet UITextField *MunicipioCampo;
    IBOutlet UITextField *DiasProhibidosCampo;
    IBOutlet UITextField *HorarioProhibidoCampo;
    IBOutlet UITextField *AltitudMaximaCampo;
    IBOutlet UITextField *AlcanceVisualMaximoCampo;
    IBOutlet UITextField *FechaCampo;
    IBOutlet UISegmentedControl *SelectorTipoOperacion;
    
//BOTONES VENTANA FLOTANTE PARA ABRIR Y CERRAR------------------------------------------//
     __weak IBOutlet UIButton *BotonCerrarFlotante;
}


//////////////////////////////////////////////////////////////////////////////////////////
//ACCIONES------------------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)GenerarPdfBoton:(id)sender;//--------------GENERAR PDF
- (IBAction)MuestraFlotantePdf:(id)sender;//-----------MUESTRA PDF FLOTANTE
- (IBAction)EnviarEmail:(id)sender; //-----------------ENVÍA EMAIL

- (IBAction)OcultaFlotantePdf:(id)sender;//------------OCULTA PDF FLOTANTE
- (IBAction)OcultarTeclado:(id)sender;//---------------OCULTA TECLADO
- (IBAction)EstablecerFechaHora:(id)sender;//----------ESTABLECE FECHA Y HORA
- (IBAction)BotonTipoOperacion:(id)sender;//-----------TIPO DE OPERACION


@end

//////////////////////////////////////////////////////////////////////////////////////////
//COMPandGO-----------------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////


