
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//
//  FormularioViewController.m
//  COMPandGO
//
//  Creado por Jose Braña on 21/5/16.
//  Copyright © 2016 Jose Braña. TFG. Universidad Internacional de la Rioja
//
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//--------------------------------------------------------------------------------------//

#import "FormularioViewController.h"

@interface FormularioViewController ()
{
    CGSize tamañoPagina; //Define el tamaño de página del PDF
}
@end

@implementation FormularioViewController


//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//MÉTODOS PRINCIPALES-------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////


//ACCIONES ADICIONALES DESPUÉS DE CARGAR LA VISTA---------------------------------------//

- (void)viewDidLoad {
    [super viewDidLoad];
    [ScrollVertical setScrollEnabled:YES];
    [ScrollVertical setContentSize:CGSizeMake(768, 3058)];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(compruebalongitud) userInfo:nil repeats:YES];
    [FlotanteMuestraPdf setHidden:YES];
    [BotonCerrarFlotante setHidden:YES];
    NombreCompletoPilotoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    DniCifNifPilotoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;


   }

//AVISOS DE PROBLEMAS DE MEMORIA--------------------------------------------------------//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//COMPROBADOR DE TAMAÑOS MÁXIMOS DE CAMPOS EN FORMULARIOS-------------------------------//

- (void) compruebalongitud
{
    if ([NombreCompletoPilotoCampo.text length] >=11)
    {NombreCompletoPilotoCampo.text = [NombreCompletoPilotoCampo.text substringWithRange:NSMakeRange(0, 10)];
    }
}

//COMTROLADOR DE EMAIL------------------------------------------------------------------//

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    
    // Cierra el Interface de Email
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//CREAR PDF-----------------------------------------------------------------------------//

- (void)CrearPdf:(NSString *)rutaArchivo
{
    UIGraphicsBeginPDFContextToFile(rutaArchivo, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 2480, 3508), nil);
    [self dibujaFondoPdf];
    [self imagenFondo];
    [self dibujaTexto];
    UIGraphicsEndPDFContext();
}

//DIBUJA FONDO PDF----------------------------------------------------------------------//

-(void)dibujaFondoPdf
{
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    CGRect fondoPdf = CGRectMake(0, 0, tamañoPagina.width, tamañoPagina.height);
    CGContextSetFillColorWithColor(contexto, [[UIColor grayColor]CGColor]);
    CGContextFillRect(contexto, fondoPdf);
}

//DEFINE IMAGEN DE FONDO DEL PDF---------------------------------------------------------//

-(void)imagenFondo
{
    CGRect areaImagen = CGRectMake(0, 0, 2480, 3508);
    UIImage *papel = [UIImage imageNamed:@"PlanVueloOperacional.jpg"];//Ojo con Mayúsculas/Minúsculas en el nombre de Archivo.
    [papel drawInRect:areaImagen];
}

//DIBUJA TEXTO--------------------------------------------------------------------------//

-(void)dibujaTexto
{
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(contexto, [UIColor blackColor].CGColor);
    CGRect areaTextoNombreCompletoPiloto = CGRectMake(132, 165, 850, 1100);
    CGRect areaTextoFecha = CGRectMake(132, 800, 850, 1100);
    UIFont *tipografiaPdf = [UIFont fontWithName:@"AmericanTypewriter" size:20.f];
    NSString *NombreCompletoPilotoPdf = NombreCompletoPilotoCampo.text;
    NSString *FechaPdf = FechaCampo.text;
    NSDictionary *misAtributos = @{ NSFontAttributeName:tipografiaPdf};
    
    [NombreCompletoPilotoPdf drawInRect:areaTextoNombreCompletoPiloto withAttributes:misAtributos];
    [FechaPdf drawInRect:areaTextoFecha withAttributes:misAtributos];
}



//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////
//ACCIONES PRINCIPALES------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////

//GENERAR PDF---------------------------------------------------------------------------//

- (IBAction)GenerarPdfBoton:(id)sender {
    tamañoPagina = CGSizeMake(2480, 3508);
    NSString *nombreArchivo = @"PlanVueloPreliminar.pdf";
    
    NSArray *ruta = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *directorioArchivo = [ruta objectAtIndex:0];
    NSString *rutaPdfConNombreArchivo = [directorioArchivo stringByAppendingPathComponent:nombreArchivo];
    [self CrearPdf:rutaPdfConNombreArchivo];
}

//MUESTRA VENTANA FLOTANTE DEL PDF-------------------------------------------------------//

- (IBAction)MuestraFlotantePdf:(id)sender {
    
    NSArray *ruta = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [ruta objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/PlanVueloPreliminar.pdf",
                          documentsDirectory];
    
    
    NSURL *url = [NSURL fileURLWithPath:fileName];
    NSURLRequest  *solicita = [NSURLRequest requestWithURL:url];
    [FlotanteMuestraPdf loadRequest:solicita];
    [FlotanteMuestraPdf setScalesPageToFit:YES];
    
    [FlotanteMuestraPdf setHidden:NO];
    [BotonCerrarFlotante setHidden:NO];
}

//ENVIA EMAIL----------------------------------------------------------------------------//

- (IBAction)EnviarEmail:(id)sender {
    //Asunto del eMail
    NSString *emailTitle = @"Plan de Vuelo Preliminar";
    
    //Contenido del eMail
    NSString *messageBody = @"Se adjunta archivo Pdf con documentación relativa al Plan de Vuelo Operacional programado en cumplimiento de la normativa legal vigente para la realización de vuelos con drones en espacio aéreo español y no controlado, según la especificaciones de la Agencia Estatal de Seguridad Aérea ";
    
    //Archivo Adjunto
    NSArray *ruta = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [ruta objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/PlanVueloPreliminar.pdf",
                          documentsDirectory];
    
    //NSString *Destinatario = MailPilotoCampo.text;
    NSData *dataToBeEncrypted = [NSData dataWithContentsOfFile:fileName];
    NSArray *toRecipents = [NSArray arrayWithObject:@"destinatario@dominio.com"];
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:toRecipents];
    
    //Muestra el Controlador del Email por la pantalla
    [mc addAttachmentData:dataToBeEncrypted mimeType:@"application/pdf" fileName:@"PlanVueloPreliminar.pdf"];
    [self presentViewController:mc animated:YES completion:NULL];
}

//OCULTA VENTANA FLOTANTE DEL PDF-------------------------------------------------------//

- (IBAction)OcultaFlotantePdf:(id)sender {
     [FlotanteMuestraPdf setHidden:YES];
    [BotonCerrarFlotante setHidden:YES];
}


//OCULTA TECLADO------------------------------------------------------------------------//

- (IBAction)OcultarTeclado:(id)sender {
        [self resignFirstResponder];
}

//ESTABLECE FECHA Y HORA---------------------------------------------------------------//

- (IBAction)EstablecerFechaHora:(id)sender {
    SelectorFechaHora.datePickerMode = UIDatePickerModeDateAndTime;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-yy hh:mm a "];
    MuestraFechaHora.text=[format stringFromDate:SelectorFechaHora.date];
}

//SELECTOR TIPO DE OPERACION-----------------------------------------------------------//

- (IBAction)BotonTipoOperacion:(id)sender {
    if (SelectorTipoOperacion.selectedSegmentIndex == 0) {
        TipoOperacionSeleccionada.text = @"VLOS";
    }
    if (SelectorTipoOperacion.selectedSegmentIndex == 1) {
        TipoOperacionSeleccionada.text = @"EVLOS";
    }
    if (SelectorTipoOperacion.selectedSegmentIndex == 2) {
        TipoOperacionSeleccionada.text = @"BVLOS";
    }
}



@end

//////////////////////////////////////////////////////////////////////////////////////////
//COMPandGO-----------------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////

