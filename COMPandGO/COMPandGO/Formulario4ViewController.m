//
//  Formulario4ViewController.m
//  COMPandGO
//
//  Created by Jose Braña on 19/5/16.
//  Copyright © 2016 Jose Braña. All rights reserved.
//

#import "Formulario4ViewController.h"
#import "Formulario1ViewController.h"

@interface Formulario4ViewController ()
{
    CGSize tamañoPagina;
}
@end

@implementation Formulario4ViewController

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

- (IBAction)OcultarTeclado:(id)sender {
    [self resignFirstResponder];
}

- (IBAction)GenerarPdfBoton:(id)sender {
    tamañoPagina = CGSizeMake(850, 1100);
    NSString *nombreArchivo = @"PlanVueloPreliminar.pdf";
    NSArray *ruta = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *directorioArchivo = [ruta objectAtIndex:0];
    NSString *rutaPdfConNombreArchivo = [directorioArchivo stringByAppendingPathComponent:nombreArchivo];
    [self CrearPdf:rutaPdfConNombreArchivo];
}

- (void)CrearPdf:(NSString *)rutaArchivo
{
    UIGraphicsBeginPDFContextToFile(rutaArchivo, CGRectZero, nil);
    UIGraphicsBeginPDFPageWithInfo(CGRectMake(0, 0, 850, 1100), nil);
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
    CGRect areaTexto = CGRectMake(132, 165, 400, 400);
    UIFont *tipografiaPdf = [UIFont fontWithName:@"AmericanTypewriter" size:20.f];
    NSString *FechaPdf =  Fechacampo.text;

    NSDictionary *misAtributos = @{ NSFontAttributeName:tipografiaPdf};
 [FechaPdf drawInRect:areaTexto withAttributes:misAtributos];
   
}

-(void)imagenFondo
{
    CGRect areaImagen = CGRectMake(0, 0, 850, 1100);
    UIImage *papel = [UIImage imageNamed:@"pv.png"];
    [papel drawInRect:areaImagen];
}




@end
