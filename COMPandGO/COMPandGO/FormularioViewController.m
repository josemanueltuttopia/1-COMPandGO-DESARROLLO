//
//  FormularioViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 21/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import "FormularioViewController.h"

@interface FormularioViewController ()
{
    CGSize tamañoPagina; //Define el tamaño de página del PDF
}
@end

@implementation FormularioViewController

- (void) compruebalongitud
{
    if ([NombreCompletoPilotoCampo.text length] >=11)
    {NombreCompletoPilotoCampo.text = [NombreCompletoPilotoCampo.text substringWithRange:NSMakeRange(0, 10)];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [ScrollVertical setScrollEnabled:YES];
    [ScrollVertical setContentSize:CGSizeMake(768, 3584)];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(compruebalongitud) userInfo:nil repeats:YES];
    
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


- (IBAction)EnviarEmail:(id)sender {
    //Email Subject
    NSString *emailTitle = @"Plan de Vuelo Preliminar";
    // Email Content
    NSString *messageBody = @"Se adjunta archivo Pdf con documentación relativa al Plan de Vuelo Operacional programado en cumplimiento de la normativa legal vigente para la realización de vuelos con drones en espacio aéreo español y no controlado, según la especificaciones de la Agencia Estatal de Seguridad Aérea ";
    // To address
    
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
    
    // Present mail view controller on screen
    [mc addAttachmentData:dataToBeEncrypted mimeType:@"application/pdf" fileName:@"PlanVueloPreliminar.pdf"];
    [self presentViewController:mc animated:YES completion:NULL];
}


    


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
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}




- (IBAction)OcultarTeclado:(id)sender {
        [self resignFirstResponder];
}

- (IBAction)EstablecerFechaHora:(id)sender {
    SelectorFechaHora.datePickerMode = UIDatePickerModeDateAndTime;
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"dd-MM-yy hh:mm a "];
    MuestraFechaHora.text=[format stringFromDate:SelectorFechaHora.date];
}

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

- (IBAction)GenerarPdfBoton:(id)sender {
    tamañoPagina = CGSizeMake(2480, 3508);
    NSString *nombreArchivo = @"PlanVueloPreliminar.pdf";
    
    NSArray *ruta = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *directorioArchivo = [ruta objectAtIndex:0];
    NSString *rutaPdfConNombreArchivo = [directorioArchivo stringByAppendingPathComponent:nombreArchivo];
    [self CrearPdf:rutaPdfConNombreArchivo];
}


/*- (IBAction)CompruebaPdf:(id)sender {
    //NSArray *ruta = NSSearchPathForDirectoriesInDomains
    //(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentsDirectory = [ruta objectAtIndex:0];
    //NSString *fileName = [NSString stringWithFormat:@"%@/PlanVueloPreliminar.pdf",
    //                      documentsDirectory];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PdfFile" ofType:@"pdf"];
    NSURL *url = [NSURL fileURLWithPath:path];
    NSURLRequest  *solicita = [NSURLRequest requestWithURL:url];
    [PantallaPdf loadRequest:solicita];
    [PantallaPdf setScalesPageToFit:NO];
    

 
}*/
































- (void)CrearPdf:(NSString *)rutaArchivo
{
    UIGraphicsBeginPDFContextToFile(rutaArchivo, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 2480, 3508), nil);
    [self dibujaFondoPdf];
    [self imagenFondo];
    [self dibujaTexto];
    
    UIGraphicsEndPDFContext();
}

-(void)dibujaFondoPdf
{
    CGContextRef contexto = UIGraphicsGetCurrentContext();
    CGRect fondoPdf = CGRectMake(0, 0, tamañoPagina.width, tamañoPagina.height);
    CGContextSetFillColorWithColor(contexto, [[UIColor grayColor]CGColor]);//Comprobación de que hay fondo (GRIS)
    CGContextFillRect(contexto, fondoPdf);
    
}

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

-(void)imagenFondo
{
    CGRect areaImagen = CGRectMake(0, 0, 2480, 3508);
    UIImage *papel = [UIImage imageNamed:@"PlanVueloOperacional.jpg"];//Ojo con Mayúsculas/Minúsculas en el nombre de Archivo.
    [papel drawInRect:areaImagen];
}







@end

