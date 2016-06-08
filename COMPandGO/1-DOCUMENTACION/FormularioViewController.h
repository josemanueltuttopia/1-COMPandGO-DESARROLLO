
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
#import <AudioToolbox/AudioToolbox.h> //Para reproducir sonidos


@interface FormularioViewController : UIViewController <MFMailComposeViewControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
    SystemSoundID BotonTipo1;
    SystemSoundID BotonTipo2;
    SystemSoundID BotonTipo3;


  
//CAMPOS DEL FORMULARIO a RELLENAR------------------------------------------------------//
    
     //Views
    IBOutlet UIScrollView *ScrollVertical;//-----------------SCROLL DEL
    IBOutlet UIImageView *FlotanteSelectorFecha;
    __weak IBOutlet UIWebView *FlotanteMuestraPdf;//---------VISTA DE VENTANA FLOTANTE

    
    //TextFileds
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
    IBOutlet UITextField *DescripcionObjetivoCampo;
    IBOutlet UITextField *LocalidadCampo;
    IBOutlet UITextField *MunicipioCampo;
    IBOutlet UITextField *ProvinciaCampo;
    IBOutlet UITextField *DiasProhibidosCampo;
    
    IBOutlet UITextField *HorasProhibidas;
    
    
    IBOutlet UIImageView *VentanaFlotanteProvincia;
    
    IBOutlet UIImageView *VentanaFlotanteClase;
    IBOutlet UITextField *AltitudMaximaCampo;
    IBOutlet UITextField *AlcanceVisualMaximoCampo;
    IBOutlet UITextField *Fecha;
    
    //Selectores
    IBOutlet UISegmentedControl *SelectorTipoOperacion;
    IBOutlet UISegmentedControl *SelectorCondicionesMeteorologicas;
    IBOutlet UIButton *CierraFechaBoton;
    
    //Cehecks
    IBOutlet UISwitch *ActividadesDeInvestigacion;
    IBOutlet UISwitch *TratamientosAereos;
    IBOutlet UISwitch *Fotografia;
    IBOutlet UISwitch *InvestigacionReconocimiento;
    IBOutlet UISwitch *ObservacionVigilancia;
    IBOutlet UISwitch *PublicidadAerea;
    IBOutlet UISwitch *OperacionesEmergencia;
    IBOutlet UISwitch *OtrosTrabajos;
    IBOutlet UISwitch *VueloPrueba;
    IBOutlet UISwitch *VueloDemostracion;
    IBOutlet UISwitch *VueloProgramasInvestigacion;
    IBOutlet UISwitch *VueloDesarrollo;
    IBOutlet UISwitch *VuelosID;
    IBOutlet UISwitch *VuelosPruebaNecesarios;
    IBOutlet UISwitch *NoSujeto;
    IBOutlet UISwitch *RequiereCoordinacion;
    IBOutlet UISwitch *NecesarioNOTAM;
    IBOutlet UISwitch *PerfilTodo;
    IBOutlet UISwitch *TodosPuntosPerfil;
    IBOutlet UISwitch *ZonasDespegue;
    IBOutlet UISwitch *Revisiones;
    IBOutlet UISwitch *CondicionesMeteorologicasVMC;

    //Etiquetas
    IBOutlet UILabel *FechaActual;

    IBOutlet UILabel *ClaseActual;
    
    
    IBOutlet UILabel *ProvinciaActual;
    
    
    IBOutlet UIPickerView *ProvinciaPickerView;
    
    
    IBOutlet UIPickerView *ClasePickerView;
    
    

    
    
    
    
//BOTONES VENTANA FLOTANTE PARA ABRIR Y CERRAR------------------------------------------//
     __weak IBOutlet UIButton *BotonCerrarFlotante;
}
@property (strong, nonatomic) IBOutlet UIDatePicker *SelectorDatePicker;

//////////////////////////////////////////////////////////////////////////////////////////
//ACCIONES------------------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////

- (IBAction)GenerarPdfBoton:(id)sender;//--------------GENERAR PDF
- (IBAction)MuestraFlotantePdf:(id)sender;//-----------MUESTRA PDF FLOTANTE
- (IBAction)EnviarEmail:(id)sender; //-----------------ENVÍA EMAIL
- (IBAction)OcultaFlotantePdf:(id)sender;//------------OCULTA PDF FLOTANTE
- (IBAction)OcultarTeclado:(id)sender;//---------------OCULTA TECLADO
- (IBAction)CierraFechaBoton:(id)sender;//-------------OCULTA TFECHA
- (IBAction)IntroduceFechaBoton:(id)sender;//----------MUESTRA TFECHA
@property (strong, nonatomic) IBOutlet UIButton *CierraFlotanteProvincia;
@property (weak, nonatomic) IBOutlet UIButton *CierraFlotanteClase;

- (IBAction)AccionCierraFlotanteClase:(id)sender;

- (IBAction)AccionCierraFlotanteProvincia:(id)sender;


- (IBAction)cambiaClase:(id)sender;

- (IBAction)CambiaProvincia:(id)sender;


- (IBAction)SuenaClick:(id)sender;
- (IBAction)SuenaBoton:(id)sender;
- (IBAction)Suenapdf:(id)sender;

@end

//////////////////////////////////////////////////////////////////////////////////////////
//COMPandGO-----------------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////


