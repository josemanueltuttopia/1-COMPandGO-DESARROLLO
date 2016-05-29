
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
    
    //Alineaciónes verticales de contenidos de TexFields de los formularios
    NombreCompletoPilotoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    DniCifNifPilotoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    TlfPilotoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    MailPilotoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NombreCompletoOperadorCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    DniCifNifOperadorCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    TlfOperadorCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    MailOperadorCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    MarcaCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ModeloCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    NumSerieCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    DescripcionObjetivoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    LocalidadCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    ProvinciaCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    MunicipioCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
       LocalidadCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    AltitudMaximaCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    AlcanceVisualMaximoCampo.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
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
    UIFont *tipografiaPdf = [UIFont fontWithName:@"AmericanTypewriter" size:46.f];
    NSDictionary *misAtributos = @{ NSFontAttributeName:tipografiaPdf};
    
    UIFont *tipografiafecha = [UIFont fontWithName:@"AmericanTypewriter" size:55.f];
    NSDictionary *misAtributosFecha = @{ NSFontAttributeName:tipografiafecha};
    
    
    UIFont *tipografiapunto = [UIFont fontWithName:@"AmericanTypewriter" size:200.f];
    NSDictionary *misAtributospunto = @{ NSFontAttributeName:tipografiapunto};
    
    UIFont *tipografiapuntogordo = [UIFont fontWithName:@"AmericanTypewriter" size:400.f];
    NSDictionary * misAtributospuntogordo = @{ NSFontAttributeName:tipografiapuntogordo};
    
    
    

    

    
    
    
    //INFORMACION DEL PILOTO-----------------------------------------------------------//
    
        //NombreCompletoPiloto
        CGRect areaTextoNombreCompletoPiloto = CGRectMake(750, 350, 2480, 3508);
        //NSString *NombreCompletoPilotoPdf = NombreCompletoPilotoCampo.text;
        NSString *NombreCompletoPilotoPdf = @"AASSDggggkkjdfsfgaòrwv1";
        //DniCifNifPiloto
        CGRect areaTextoDniCifNifPilotoCampo = CGRectMake(581, 416, 2480, 3508);
        NSString *DniCifNifPilotoPdf = @"AASSDggggkkjdfsfgaòrwv1";
        //TlfPilotoCampo
        CGRect areaTlfPilotoCampo = CGRectMake(1706, 416, 2480, 3508);
        NSString *TlfPilotoCampoPdf = @"AASSDggggkkjdfsfgaòrwv1";
        //MailPilotoCampo
        CGRect areaMailPilotoCampo = CGRectMake(364, 481, 2480, 3508);
        NSString *MailPilotoCampoPdf = @"AASSDggggkkjdfsfgaòrwv1";

    
    //INFORMACION DEL OPERADOR--------------------------------------------------------//
    
        //NombreCompletoOperador
        CGRect areaNombreCompletoOperadorCampo = CGRectMake(758, 677, 2480, 3508);
        NSString *NombreCompletoOperadorPdf =  @"AASSDggggkkjdfsfgaòrwv1";

        //DniCifNifOperador
        CGRect areaDniCifNifOperadorCampo = CGRectMake(585, 745, 2480, 3508);
        NSString *DniCifNifOperadorPdf =  @"AASSDggggkkjdfsfgaòrwv1";

        //TlfPilotoOeprador
        CGRect areaTlfOperadorCampo = CGRectMake(1680, 745, 2480, 3508);
        NSString *TlfOperadorPdf =  @"AASSDggggkkjdfsfgaòrwv1";
        //MailOperadorCampo
        CGRect areaMailOperadorCampo = CGRectMake(362, 810, 2480, 3508);
        NSString *MailOperadorPdf =  @"AASSDggggkkjdfsfgaòrwv121341234";
    
    //INFORMACION DE LA AERONAVE------------------------------------------------------//
    
        //CLASE
        CGRect areaClaseCampo = CGRectMake(400, 1006, 2478, 3508);
        NSString *ClasePdf =  @"AASSDggggkkjdfsfgaò";
    
        //MarcaCampo
        CGRect areaMarcaCampo = CGRectMake(1756, 1006, 2478, 3508);
        NSString *MarcaPdf =  @"AASSDggggkkjdfsfgaò";
    
        //NumSerieCampo
        CGRect areaNumSerieCampo = CGRectMake(1833, 1073, 2480, 3508);
        NSString *NumSeriePdf =  @"AASSDggggkkjdfsf";
    
        //ModeloCampo
        CGRect areaModeloCampo = CGRectMake(446, 1073, 2480, 3508);
        NSString *ModeloPdf =  @"AASSDggggkkjdfsfgaòrwv";

    
    
    
    //TIPO DE VUELO-------------------------------------------------------------------//
    
        //Operacion Normal
        CGRect areaActividadesDeInvestigacionCampo = CGRectMake(205, 1247, 2480, 3508);
        NSString *ActividadesDeInvestigacionPdf =   @"·";
        CGRect areaTratamientosCampo = CGRectMake(205, 1293, 2480, 3508);
        NSString *TratamientosPdf =   @"·";
        CGRect areaFotografiaCampo = CGRectMake(205, 1339, 2480, 3508);
        NSString *FotografiaPdf =   @"·";
        CGRect areaInvestigacionCampo = CGRectMake(205, 1385, 2480, 3508);
        NSString *InvestigacionPdf =   @"·";
        CGRect areaObservacionCampo = CGRectMake(205, 1431, 2480, 3508);
        NSString *ObservacionPdf =   @"·";
        CGRect areaPublicidadCampo = CGRectMake(205, 1477, 2480, 3508);
        NSString *PublicidadPdf =   @"·";
        CGRect areaOperacionesCampo = CGRectMake(205, 1526, 2480, 3508);
        NSString *OperacionesPdf =   @"·";
        CGRect areaOtrosCampo = CGRectMake(205, 1572, 2480, 3508);
        NSString *OtrosPdf =   @"·";
        //Operacion Especial
        CGRect areaVueloPrueba = CGRectMake(205, 1699, 2480, 3508);
        NSString *VueloPruebaPdf =   @"·";
        CGRect areaVueloProgramas = CGRectMake(205, 1747, 2480, 3508);
        NSString *VueloProgramasPdf =   @"·";
        CGRect areaVueloDemostracion = CGRectMake(205, 1795, 2480, 3508);
        NSString *VueloDemostracioPdf =   @"·";
        CGRect areaVueloDesarrollo = CGRectMake(205, 1843, 2480, 3508);
        NSString *VueloDesarrolloPdf =   @"·";
        CGRect areaVueloID = CGRectMake(205, 1889, 2480, 3508);
        NSString *VueloIDPdf =   @"·";
        CGRect areaVueloPruebaNecesarios = CGRectMake(205, 1937, 2480, 3508);
        NSString *VueloPruebaNecesariosPdf =   @"·";
        CGRect areaNoSujeto = CGRectMake(205, 1982, 2480, 3508);
        NSString *NoSujetoPdf =   @"·";
    
    



    
    //INFORMACION DE LA AERONAVE------------------------------------------------------//
    
    
    //TIPO DE OPERACION Y DESCRIPCIÓN Y LOCALIZACION----------------------------------//
    
     

        //TIPO DE VUELO
        CGRect areaVLO = CGRectMake(1582, 2052, 2480, 3508);
        NSString *VLOPdf =   @"·";
        CGRect areaEVLO = CGRectMake(1813, 2052, 2480, 3508);
        NSString *EVLOPdf =   @"·";
        CGRect areaBVLOS = CGRectMake(2089, 2052, 2480, 3508);
        NSString *EVLOSPdf =   @"·";

    
    
        //DescripcionObjetivoCampo
        CGRect areaDescripcionObjetivoCampo = CGRectMake(601, 2316, 2480, 3508);
        NSString *DescripcionObjetivoPdf =   @"AASSDggggkkjdfsfgaò";

        //MunicipioCampo
        CGRect areaMunicipioCampo = CGRectMake(1332, 2387, 2480, 3508);
        NSString *MunicipioPdf =   @"AASSDggggkkj";

    
        //LocalidadCampo
        CGRect areaLocalidadCampo = CGRectMake(535, 2387, 2480, 3508);
        NSString *LocalidadPdf =   @"AASSDggggkk";

 
        //ProvinciaCampo
        CGRect areaProvinciaCampo = CGRectMake(2063, 2387, 2480, 3508);
        NSString *ProvinciaPdf =   @"AASSDggg";

    
    //RESTRICCIONES DE LA OPERACIÓN--------------------------------------------------//
    
    
    CGRect areaRequiereCoordinacion = CGRectMake(205, 2492, 2480, 3508);
    NSString *RequiereCoordinacionPdf =   @"·";
    CGRect areaNecesariaPublicacion = CGRectMake(205, 2536, 2480, 3508);
    NSString *NecesariaPublicacionPdf =   @"·";
    CGRect areaProhibidoDias = CGRectMake(205, 2578, 2480, 3508);
    NSString *ProhibidoDiasPdf =   @"·";
    CGRect areaProhibidoHoras = CGRectMake(205, 2620, 2480, 3508);
    NSString *ProhibidoHorasPdf =   @"·";
    
    
        //DiasProhibidosCampo
        CGRect areaDiasProhibidosCampo = CGRectMake(1113, 2649, 2480, 3508);
        NSString *DiasProhibidosPdf =  @"AASSDggg";
    
        //AlcanceVisualMaximoCampo
        CGRect areaAlcanceVisualMaximoCampo = CGRectMake(2128, 2649, 2480, 3508);
        NSString *AlcanceVisualMaximoPdf =  @"AASgSD";


        //HorarioProhibidoCampo
        CGRect areaHorarioProhibidoCampo = CGRectMake(1113, 2706, 2480, 3508);
        NSString *HorarioProhibidoPdf =  @"AASSDg";

        //AltitudMaximaCampo
        CGRect areaAltitudMaximaCampo = CGRectMake(1926,2706, 2480, 3508);
        NSString *AltitudMaximaPdf =  @"ADggg";


  
    
    //METEOROLOGÍA-------------------------------------------------------------//
    
    //Puntos gordos
    CGRect areaCondicionVMC = CGRectMake(1760, 2715, 2480, 3508);
    NSString *CondicionVMCPdf =   @"·";
    CGRect areaCondicionIMC = CGRectMake(2008, 2715, 2680, 3508);
    NSString *CondicionIMCPdf =   @"·";

    
    //Puntos
    CGRect areaPerfil = CGRectMake(205, 2942, 2480, 3508);
    NSString *PerfilPdf =   @"·";
    CGRect areaPuntosPerfil = CGRectMake(205, 2988, 2480, 3508);
    NSString *PuntosPerfilPdf =   @"·";
    CGRect areaZonasDespegue = CGRectMake(205, 3031, 2480, 3508);
    NSString *areaZonasDespeguePdf =   @"·";
    CGRect areaRevisiones = CGRectMake(205, 3081, 2480, 3508);
    NSString *RevisionesPdf =   @"·";
    CGRect areaVMC = CGRectMake(205, 3123, 2480, 3508);
    NSString *VMCPdf =   @"·";
    
    

    
    
    
    

      //FECHA DE LA OPERACIÓN--------------------------------------------------//
    
        //FechaCampo
        CGRect areaFechaCampo = CGRectMake(2022, 3295, 2480, 3508);
        NSString *FechaCampoPdf =  @"12-12-2016";



        //SelectorTipoOperacion
        CGRect areaSelectorTipoOperacion = CGRectMake(0, 0, 2480, 3508);//SELECTOR
        NSString *SelectorTipoPdf =  NombreCompletoPilotoCampo.text;

    
 
    //INFORMACION DEL PILOTO-----------------------------------------------------------//
    [NombreCompletoPilotoPdf drawInRect:areaTextoNombreCompletoPiloto withAttributes:misAtributos];
    [DniCifNifPilotoPdf drawInRect:areaTextoDniCifNifPilotoCampo withAttributes:misAtributos];
    [TlfPilotoCampoPdf drawInRect:areaTlfPilotoCampo withAttributes:misAtributos];
    [MailPilotoCampoPdf drawInRect:areaMailPilotoCampo withAttributes:misAtributos];
    
    //INFORMACION DEL OPERADOR--------------------------------------------------------//
    [NombreCompletoOperadorPdf drawInRect:areaNombreCompletoOperadorCampo  withAttributes:misAtributos];
    [DniCifNifOperadorPdf drawInRect:areaDniCifNifOperadorCampo withAttributes:misAtributos];
    [TlfOperadorPdf drawInRect:areaTlfOperadorCampo withAttributes:misAtributos];
    [MailOperadorPdf drawInRect:areaMailOperadorCampo withAttributes:misAtributos];
    
    //INFORMACION DE LA AERONAVE------------------------------------------------------//
    
    [ClasePdf drawInRect:areaClaseCampo withAttributes:misAtributos];
    [MarcaPdf drawInRect:areaMarcaCampo withAttributes:misAtributos];
    [ModeloPdf drawInRect:areaModeloCampo withAttributes:misAtributos];
    [NumSeriePdf drawInRect:areaNumSerieCampo withAttributes:misAtributos];
    
    //TIPO DE VUELO-------------------------------------------------------------------//
        //NORMAL
    if (ActividadesDeInvestigacion.on) {
         [ActividadesDeInvestigacionPdf drawInRect:areaActividadesDeInvestigacionCampo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (TratamientosAereos.on) {
       [TratamientosPdf drawInRect:areaTratamientosCampo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (Fotografia.on) {
        [FotografiaPdf drawInRect:areaFotografiaCampo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (InvestigacionReconocimiento.on) {
        [InvestigacionPdf drawInRect:areaInvestigacionCampo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (ObservacionVigilancia.on) {
        [ObservacionPdf drawInRect:areaObservacionCampo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (PublicidadAerea.on) {
        [PublicidadPdf drawInRect:areaPublicidadCampo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (OperacionesEmergencia.on) {
           [OperacionesPdf drawInRect:areaOperacionesCampo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (OtrosTrabajos.on) {
         [OtrosPdf drawInRect:areaOtrosCampo withAttributes:misAtributospunto];}
    else{Nil;}

        //ESPECIAL
    
    if (VueloPrueba.on) {
        [VueloPruebaPdf drawInRect:areaVueloPrueba withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (VueloDemostracion.on) {
        [VueloDemostracioPdf drawInRect:areaVueloDemostracion withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (VueloProgramasInvestigacion.on) {
         [VueloProgramasPdf drawInRect:areaVueloProgramas withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (VueloDesarrollo.on) {
       [VueloDesarrolloPdf drawInRect:areaVueloDesarrollo withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (VuelosID.on) {
        [VueloIDPdf drawInRect:areaVueloID withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (VuelosPruebaNecesarios.on) {
        [VueloPruebaNecesariosPdf drawInRect:areaVueloPruebaNecesarios withAttributes:misAtributospunto];}
    else{Nil;}
    
    if (NoSujeto.on) {
            [NoSujetoPdf drawInRect:areaNoSujeto withAttributes:misAtributospunto];}
    else{Nil;}
 
    
    //TIPO DE OPERACION, DESCRIPCIÓN Y LOCALIZADOS------------------------------------//
  
    if (SelectorTipoOperacion.selectedSegmentIndex == 0) {
         [VLOPdf drawInRect:areaVLO withAttributes:misAtributospuntogordo];
    }
    if (SelectorTipoOperacion.selectedSegmentIndex == 1) {
        [EVLOPdf drawInRect:areaEVLO withAttributes:misAtributospuntogordo];
    }
    
    if (SelectorTipoOperacion.selectedSegmentIndex == 2) {
            [EVLOSPdf drawInRect:areaBVLOS withAttributes:misAtributospuntogordo];
    
    

    
   
    

    
    
    
    //[TipoOperacionSeleccionadaPdf drawInRect:areaTipoOperacionSeleccionadaCampo withAttributes:misAtributos];
    [DescripcionObjetivoPdf drawInRect:areaDescripcionObjetivoCampo withAttributes:misAtributos];
    [LocalidadPdf drawInRect:areaLocalidadCampo withAttributes:misAtributos];
    [MunicipioPdf drawInRect:areaMunicipioCampo withAttributes:misAtributos];
    [ProvinciaPdf drawInRect:areaProvinciaCampo withAttributes:misAtributos];
    
    //RESTRICCIONES DE LA OPERACIÓN--------------------------------------------------//
    
    //Puntos
    
    if (RequiereCoordinacion.on) {
       [RequiereCoordinacionPdf drawInRect:areaRequiereCoordinacion withAttributes:misAtributospunto];}
    else{Nil;}
    if (NecesarioNOTAM.on) {
        [NecesariaPublicacionPdf  drawInRect:areaNecesariaPublicacion withAttributes:misAtributospunto];
       }
    else{Nil;}
    if (NecesarioNOTAM.on) {
        [NecesariaPublicacionPdf  drawInRect:areaNecesariaPublicacion withAttributes:misAtributospunto];
    }
    else{Nil;}
    
    
    
    
    /*
    // PENDIENTES DE UN IF
    [ProhibidoDiasPdf drawInRect:areaProhibidoDias withAttributes:misAtributospunto];
    [ProhibidoHorasPdf drawInRect:areaProhibidoHoras withAttributes:misAtributospunto];
    */

    //Campos
    [DiasProhibidosPdf drawInRect:areaDiasProhibidosCampo withAttributes:misAtributos];
    [HorarioProhibidoPdf drawInRect:areaHorarioProhibidoCampo withAttributes:misAtributos];
    [AltitudMaximaPdf drawInRect:areaAltitudMaximaCampo withAttributes:misAtributos];
    [AlcanceVisualMaximoPdf drawInRect:areaAlcanceVisualMaximoCampo withAttributes:misAtributos];
    
    
    
    //METEOROLOGÍA--------------------------------------------------------------------//
    
    //Puntos gordos
        if (SelectorCondicionesMeteorologicas.selectedSegmentIndex == 0) {
            [CondicionVMCPdf drawInRect:areaCondicionVMC withAttributes:misAtributospuntogordo];
        }
        if (SelectorCondicionesMeteorologicas.selectedSegmentIndex == 1) {
            [CondicionIMCPdf drawInRect:areaCondicionIMC withAttributes:misAtributospuntogordo];
        }
      

    //Puntos
    
    if (PerfilTodo.on) {
        [PerfilPdf drawInRect:areaPerfil withAttributes:misAtributospunto];
    }
    else{Nil;}
    if (TodosPuntosPerfil.on) {
       [PuntosPerfilPdf drawInRect:areaPuntosPerfil withAttributes:misAtributospunto];
    }
    else{Nil;}
    if (ZonasDespegue.on) {
        [areaZonasDespeguePdf drawInRect:areaZonasDespegue withAttributes:misAtributospunto];
    }
    else{Nil;}
    if (Revisiones.on) {
        [RevisionesPdf drawInRect:areaRevisiones withAttributes:misAtributospunto];
    }
    else{Nil;}
    
    if (CondicionesMeteorologicasVMC.on) {
        [VMCPdf drawInRect:areaVMC withAttributes:misAtributospunto];
    }
    else{Nil;}
    

    
    



    
    
    //FECHA DE LA OPERACIÓN---------------------------------------------------------//
    [FechaCampoPdf drawInRect:areaFechaCampo withAttributes:misAtributosFecha];
    
    //[SelectorTipoPdf drawInRect:areaSelectorTipoOperacion withAttributes:misAtributos];
    

}

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

//SELECTOR TIPO DE OPERACION-----------------------------------------------------------//




@end

//////////////////////////////////////////////////////////////////////////////////////////
//COMPandGO-----------------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////

