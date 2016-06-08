
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

NSArray *clasePickerViewArray;
NSArray *provinciaPickerViewArray;


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
    [ScrollVertical setContentSize:CGSizeMake(768, 3248)];
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(compruebalongitud) userInfo:nil repeats:YES];
    [FlotanteMuestraPdf setHidden:YES];
    [BotonCerrarFlotante setHidden:YES];
    [FlotanteSelectorFecha setHidden:YES];
    [_SelectorDatePicker setHidden:YES];
    [CierraFechaBoton setHidden:YES];
    
    [_CierraFlotanteClase setHidden:YES];
    [_CierraFlotanteProvincia setHidden:YES];
    
    [VentanaFlotanteClase setHidden:YES];
    [VentanaFlotanteProvincia setHidden:YES];
    [ProvinciaPickerView setHidden:YES];
    [ClasePickerView setHidden:YES];
    
    

    self.SelectorDatePicker.datePickerMode = UIDatePickerModeDate;
    [self.SelectorDatePicker setValue:[UIColor colorWithRed:226/255.0f green:204/255.0f blue:36/255.0f alpha:1.0f] forKey:@"textColor"];
    
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
    
    
    //Definición de Fecha Actual (incluido su formato)
    NSDate *FechaHoy = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd/MMM/YYY"];
    FechaActual.text= [dateFormat stringFromDate:FechaHoy];
    
    //Definición de Sonido de Boton1
    NSURL *Boton1Audio = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"click" ofType:@"m4a"] ];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)Boton1Audio, & BotonTipo1);
    
    //Definición de Sonido de Boton2
    NSURL *Boton2Audio = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"PulsaSonido" ofType:@"m4a"] ];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)Boton2Audio, & BotonTipo2);

    //Definición de Sonido de Boton3
    NSURL *Boton3Audio = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"SonidoCreaPdf" ofType:@"m4a"] ];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)Boton3Audio, & BotonTipo3);


    
    
    
    
    // Lista CLASE
    
    
    
    ClaseActual.text = @"Selecciona la Clase de tu Aeronave";
    
    
    
    ClasePickerView.delegate = self;
    
    ClasePickerView.dataSource = self;
    
    //Añadimos los elementos al Array
    
    clasePickerViewArray = @[@"Avión", @"Helicóptero", @"Multirrotor", @"Otros"];
    
    
    
    // Lista PROVINCIA
    
    
    
    ProvinciaActual.text = @"Selecciona tu Provincia";
    
    
    
    ProvinciaPickerView.delegate = self;
    
    ProvinciaPickerView.dataSource = self;
    
    
    
    provinciaPickerViewArray = @[@"A Coruña", @"Álava", @"Albacete", @"Alicante", @"Almería", @"Asturias", @"Ávila", @"Badajoz", @"Baleares", @"Barcelona", @"Burgos", @"Cáceres", @"Cádiz", @"Cantabria", @"Castellón", @"Ceuta", @"Ciudad Real", @"Córdoba", @"Cuenca", @"Girona", @"Granada", @"Guadalajara", @"Guipúzcoa", @"Huelva", @"Huesca", @"Jaén", @"La Rioja", @"Las Palmas", @"León", @"Lleida", @"Lugo", @"Madrid", @"Málaga", @"Melilla", @"Murcia", @"Navarra", @"Ourense", @"Palencia", @"Pontevedra", @"Salamanca", @"Santa Cruz de Tenerife", @"Segovia", @"Sevilla", @"Soria", @"Tarragona", @"Teruel", @"Toledo", @"Valencia", @"Valladolid", @"Vizcaya", @"Zamora", @"Zaragoza"];
    
    
    
    
    
    
    
    
    
    
    
 
   }

//AVISOS DE PROBLEMAS DE MEMORIA--------------------------------------------------------//

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//COMPROBADOR DE TAMAÑOS MÁXIMOS DE CAMPOS EN FORMULARIOS-------------------------------//

- (void) compruebalongitud
{
    if ([NombreCompletoPilotoCampo.text length] >=33)
    {NombreCompletoPilotoCampo.text = [NombreCompletoPilotoCampo.text substringWithRange:NSMakeRange(0, 32)];}
    if ([DniCifNifPilotoCampo.text length] >=13)
    {DniCifNifPilotoCampo.text = [DniCifNifPilotoCampo.text substringWithRange:NSMakeRange(0, 12)];}
    
    if ([TlfPilotoCampo.text length] >=14)
    {TlfPilotoCampo.text = [TlfPilotoCampo.text substringWithRange:NSMakeRange(0, 13)];}

    if ([MailPilotoCampo.text length] >=22)
    {MailPilotoCampo.text = [MailPilotoCampo.text substringWithRange:NSMakeRange(0, 21)];}
    
    if ([NombreCompletoOperadorCampo.text length] >=33)
    {NombreCompletoOperadorCampo.text = [NombreCompletoOperadorCampo.text substringWithRange:NSMakeRange(0, 32)];}
    
    if ([DniCifNifOperadorCampo.text length] >=15)
    {DniCifNifOperadorCampo.text = [DniCifNifOperadorCampo.text substringWithRange:NSMakeRange(0, 14)];}
    
    if ([DniCifNifOperadorCampo.text length] >=13)
    {DniCifNifOperadorCampo.text = [DniCifNifOperadorCampo.text substringWithRange:NSMakeRange(0, 12)];}
    
    if ([TlfOperadorCampo.text length] >=14)
    {TlfOperadorCampo.text = [TlfOperadorCampo.text substringWithRange:NSMakeRange(0, 13)];}
    
    if ([MailOperadorCampo.text length] >=22)
    {MailOperadorCampo.text = [MailOperadorCampo.text substringWithRange:NSMakeRange(0, 21)];}
    
    if ([MarcaCampo.text length] >=22)
    {MarcaCampo.text = [MarcaCampo.text substringWithRange:NSMakeRange(0, 21)];}


    
    if ([ModeloCampo.text length] >=15)
    {ModeloCampo.text = [ModeloCampo.text substringWithRange:NSMakeRange(0, 14)];}
    
    if ([NumSerieCampo.text length] >=20)
    {NumSerieCampo.text = [NumSerieCampo.text substringWithRange:NSMakeRange(0, 19)];}
    
    if ([DescripcionObjetivoCampo.text length] >=45)
    {DescripcionObjetivoCampo.text = [DescripcionObjetivoCampo.text substringWithRange:NSMakeRange(0, 44)];}

    if ([LocalidadCampo.text length] >=15)
    {LocalidadCampo.text = [LocalidadCampo.text substringWithRange:NSMakeRange(0, 14)];}

    
    if ([MunicipioCampo.text length] >=11)
    {MunicipioCampo.text = [MunicipioCampo.text substringWithRange:NSMakeRange(0, 10)];}
    
    if ([DiasProhibidosCampo.text length] >=8)
    {DiasProhibidosCampo.text = [DiasProhibidosCampo.text substringWithRange:NSMakeRange(0, 7)];}
    if ([HorasProhibidas.text length] >=8)
    {HorasProhibidas.text = [HorasProhibidas.text substringWithRange:NSMakeRange(0, 7)];}
    
    
    if ([AltitudMaximaCampo.text length] >=6)
    {AltitudMaximaCampo.text = [AltitudMaximaCampo.text substringWithRange:NSMakeRange(0, 5)];}
    
    if ([AlcanceVisualMaximoCampo.text length] >=7)
    {AlcanceVisualMaximoCampo.text = [AlcanceVisualMaximoCampo.text substringWithRange:NSMakeRange(0, 6)];}
}

//COMTROLADOR DE EMAIL------------------------------------------------------------------//

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:NSLog(@"Mail cancelled");break;
        case MFMailComposeResultSaved:NSLog(@"Mail saved");break;
        case MFMailComposeResultSent:NSLog(@"Mail sent");break;
        case MFMailComposeResultFailed:NSLog(@"Mail sent failure: %@", [error localizedDescription]);break;
        default:break;
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
    //DEFINICIÓN DE CONTEXTO
            CGContextRef contexto = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(contexto, [UIColor blackColor].CGColor);
    //DEFINICIÓN DE TIPOGRAFÍA BASE DEL PDF GENERADO
            UIFont *tipografiaPdf = [UIFont fontWithName:@"AmericanTypewriter" size:46.f];
            NSDictionary *misAtributos = @{ NSFontAttributeName:tipografiaPdf};
    //DEFINICIÓN DE TIPOGRAFÍA DE LA FECHA DEL PDF GENERADO
            UIFont *tipografiafecha = [UIFont fontWithName:@"AmericanTypewriter" size:55.f];
            NSDictionary *misAtributosFecha = @{ NSFontAttributeName:tipografiafecha};
    //DEFINICIÓN DE TIPOGRAFÍA DE LOS PUNTOS DE LOS CHECKS (PEQUEÑOS)
            UIFont *tipografiapunto = [UIFont fontWithName:@"AmericanTypewriter" size:200.f];
            NSDictionary *misAtributospunto = @{ NSFontAttributeName:tipografiapunto};
    //DEFINICIÓN DE TIPOGRAFÍA DE LOS PUNTOS DE LOS CHECKS (GRANDES)
            UIFont *tipografiapuntogordo = [UIFont fontWithName:@"AmericanTypewriter" size:400.f];
            NSDictionary * misAtributospuntogordo = @{ NSFontAttributeName:tipografiapuntogordo};
    
    //INFORMACION DEL PILOTO-----------------------------------------------------------//
    
        //NombreCompletoPiloto
            CGRect areaTextoNombreCompletoPiloto = CGRectMake(750, 350, 2480, 3508);
            NSString *NombreCompletoPilotoPdf = NombreCompletoPilotoCampo.text;
        //DniCifNifPiloto
            CGRect areaTextoDniCifNifPilotoCampo = CGRectMake(581, 416, 2480, 3508);
            NSString *DniCifNifPilotoPdf = DniCifNifPilotoCampo.text;
        //TlfPilotoCampo
            CGRect areaTlfPilotoCampo = CGRectMake(1706, 416, 2480, 3508);
            NSString *TlfPilotoCampoPdf = TlfPilotoCampo.text;
        //MailPilotoCampo
            CGRect areaMailPilotoCampo = CGRectMake(364, 481, 2480, 3508);
            NSString *MailPilotoCampoPdf = MailPilotoCampo.text;

    //INFORMACION DEL OPERADOR--------------------------------------------------------//
    
        //NombreCompletoOperador
            CGRect areaNombreCompletoOperadorCampo = CGRectMake(758, 677, 2480, 3508);
            NSString *NombreCompletoOperadorPdf =  NombreCompletoOperadorCampo.text;
        //DniCifNifOperador
            CGRect areaDniCifNifOperadorCampo = CGRectMake(585, 745, 2480, 3508);
            NSString *DniCifNifOperadorPdf =  DniCifNifOperadorCampo.text;
        //TlfPilotoOeprador
            CGRect areaTlfOperadorCampo = CGRectMake(1680, 745, 2480, 3508);
            NSString *TlfOperadorPdf =  TlfOperadorCampo.text;
        //MailOperadorCampo
            CGRect areaMailOperadorCampo = CGRectMake(362, 810, 2480, 3508);
            NSString *MailOperadorPdf = MailOperadorCampo.text;
    
    //INFORMACION DE LA AERONAVE------------------------------------------------------//
    
        //CLASE
            CGRect areaClaseCampo = CGRectMake(400, 1006, 2478, 3508);
            NSString *ClasePdf =  @"AASSDggggkkjdfsfgaò";
        //MarcaCampo
            CGRect areaMarcaCampo = CGRectMake(1756, 1006, 2478, 3508);
            NSString *MarcaPdf =  MarcaCampo.text;
        //NumSerieCampo
            CGRect areaNumSerieCampo = CGRectMake(1833, 1073, 2480, 3508);
            NSString *NumSeriePdf =  NumSerieCampo.text;
        //ModeloCampo
            CGRect areaModeloCampo = CGRectMake(446, 1073, 2480, 3508);
            NSString *ModeloPdf =  ModeloCampo.text;
    
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
            NSString *DescripcionObjetivoPdf =   DescripcionObjetivoCampo.text;
        //MunicipioCampo
            CGRect areaMunicipioCampo = CGRectMake(1332, 2387, 2480, 3508);
            NSString *MunicipioPdf =   MunicipioCampo.text;
        //LocalidadCampo
            CGRect areaLocalidadCampo = CGRectMake(535, 2387, 2480, 3508);
            NSString *LocalidadPdf =   LocalidadCampo.text;
        //ProvinciaCampo
            CGRect areaProvinciaCampo = CGRectMake(2063, 2387, 2480, 3508);
            NSString *ProvinciaPdf =   ProvinciaCampo.text;

    
    //RESTRICCIONES DE LA OPERACIÓN--------------------------------------------------//
    
        //Requiere Coordinación
            CGRect areaRequiereCoordinacion = CGRectMake(205, 2492, 2480, 3508);
            NSString *RequiereCoordinacionPdf =   @"·";
        //Necesaria Publicación
            CGRect areaNecesariaPublicacion = CGRectMake(205, 2536, 2480, 3508);
            NSString *NecesariaPublicacionPdf =   @"·";
        //Días Prohibidos
        //    CGRect areaProhibidoDias = CGRectMake(205, 2578, 2480, 3508); -----SIN USAR
        //    NSString *ProhibidoDiasPdf =   @"·"; -----SIN USAR
        //Horas Prohibidas
            //CGRect areaProhibidoHoras = CGRectMake(205, 2620, 2480, 3508); -----SIN USAR
            //NSString *ProhibidoHorasPdf =   @"·"; -----SIN USAR
        //DiasProhibidosCampo
            CGRect areaDiasProhibidosCampo = CGRectMake(1113, 2649, 2480, 3508);
            NSString *DiasProhibidosPdf =  DiasProhibidosCampo.text;
        //AlcanceVisualMaximoCampo
            CGRect areaAlcanceVisualMaximoCampo = CGRectMake(2128, 2649, 2480, 3508);
            NSString *AlcanceVisualMaximoPdf =  AlcanceVisualMaximoCampo.text;
        //HorarioProhibidoCampo
            CGRect areaHorarioProhibidoCampo = CGRectMake(1113, 2706, 2480, 3508);
            NSString *HorarioProhibidoPdf = HorasProhibidas.text;
        //AltitudMaximaCampo
            CGRect areaAltitudMaximaCampo = CGRectMake(1926,2706, 2480, 3508);
            NSString *AltitudMaximaPdf =  AltitudMaximaCampo.text;
    
    //METEOROLOGÍA-------------------------------------------------------------//
    
        //Condiciones VMC (PUNTOS GORDOS)
            CGRect areaCondicionVMC = CGRectMake(1760, 2718, 2480, 3508);
            NSString *CondicionVMCPdf =   @"·";
        //Condiciones VMC (PUNTOS GORDOS)
            CGRect areaCondicionIMC = CGRectMake(2008, 2718, 2480, 3508);
            NSString *CondicionIMCPdf =   @"·";
        //Área Perfil (PUNTOS FINOS)
            CGRect areaPerfil = CGRectMake(205, 2942, 2480, 3508);
            NSString *PerfilPdf =   @"·";
        //Área PuntosPerfil (PUNTOS FINOS)
            CGRect areaPuntosPerfil = CGRectMake(205, 2988, 2480, 3508);
            NSString *PuntosPerfilPdf =   @"·";
        //Área PuntosPerfil (PUNTOS FINOS)
            CGRect areaZonasDespegue = CGRectMake(205, 3031, 2480, 3508);
            NSString *areaZonasDespeguePdf =   @"·";
    
            CGRect areaRevisiones = CGRectMake(205, 3081, 2480, 3508);
            NSString *RevisionesPdf =   @"·";
    
            CGRect areaVMC = CGRectMake(205, 3123, 2480, 3508);
            NSString *VMCPdf =   @"·";


    //FECHA DE LA OPERACIÓN--------------------------------------------------//
    
        //FechaCampo
       CGRect areaFechaCampo = CGRectMake(2022, 3295, 2480, 3508);
       NSString *FechaCampoPdf = @"·";
    //FechaActual.text;

        //SelectorTipoOperacion
        //CGRect areaSelectorTipoOperacion = CGRectMake(0, 0, 2480, 3508);//
       // NSString *SelectorTipoPdf =  NombreCompletoPilotoCampo.text;

    
 
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
         [VLOPdf drawInRect:areaVLO withAttributes:misAtributospuntogordo];}
    if (SelectorTipoOperacion.selectedSegmentIndex == 1) {
        [EVLOPdf drawInRect:areaEVLO withAttributes:misAtributospuntogordo];}
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
        [NecesariaPublicacionPdf  drawInRect:areaNecesariaPublicacion withAttributes:misAtributospunto];}
    else{Nil;}
    if (NecesarioNOTAM.on) {
        [NecesariaPublicacionPdf  drawInRect:areaNecesariaPublicacion withAttributes:misAtributospunto];}
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
            [CondicionVMCPdf drawInRect:areaCondicionVMC withAttributes:misAtributospuntogordo];}
        if (SelectorCondicionesMeteorologicas.selectedSegmentIndex == 1) {
            [CondicionIMCPdf drawInRect:areaCondicionIMC withAttributes:misAtributospuntogordo];}
  
    //Puntos
    
    if (PerfilTodo.on) {
        [PerfilPdf drawInRect:areaPerfil withAttributes:misAtributospunto];}else{Nil;}
    if (TodosPuntosPerfil.on) {[PuntosPerfilPdf drawInRect:areaPuntosPerfil withAttributes:misAtributospunto];}
    else{Nil;}
    if (ZonasDespegue.on) {[areaZonasDespeguePdf drawInRect:areaZonasDespegue withAttributes:misAtributospunto];}
    else{Nil;}
    if (Revisiones.on) {[RevisionesPdf drawInRect:areaRevisiones withAttributes:misAtributospunto];}
    else{Nil;}
    if (CondicionesMeteorologicasVMC.on) {[VMCPdf drawInRect:areaVMC withAttributes:misAtributospunto];}
    else{Nil;}
    

    
    //FECHA DE LA OPERACIÓN---------------------------------------------------------//
        [FechaCampoPdf drawInRect:areaFechaCampo withAttributes:misAtributosFecha];
    
    //[SelectorTipoPdf drawInRect:areaSelectorTipoOperacion withAttributes:misAtributos];
}
}

// Lista CLASE y Lista PROVINCIA



- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == ClasePickerView){
        NSString *claseSeleccionada = [clasePickerViewArray objectAtIndex:row];
        ClaseActual.text = claseSeleccionada;
    }
    else if (pickerView == ProvinciaPickerView){
   
        NSString *provinciaSeleccionada = [provinciaPickerViewArray objectAtIndex:row];
    
        ProvinciaActual.text = provinciaSeleccionada;
    }
    
}



// Lista CLASE y Lista PROVINCIA: el número de filas de nuestro PickerView. Queremos que sea el número de elementos de nuestro Array (clasePickerViewArray y provinciaPickerViewArray, respectivamente). No hace falta poner el número exacto, si no que usamos el .count



-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component



{
    
    
    
    if (pickerView == ClasePickerView){
        
        
        
        return clasePickerViewArray.count;
        
        
        
    }
    
    
    
    if
        
        (pickerView == ProvinciaPickerView){
            
            
            
            return provinciaPickerViewArray.count;
            
            
            
        }
    
    
    
    else
        
        return 0;
    
    
    
}



// Lista CLASE y Lista PROVINCIA: aquí definimos el número de columnas de los PickerView. Los nuestros solamente tienen una columna.



-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView



{
    
    
    
    if (pickerView == ClasePickerView){
        
        
        
        return 1;
        
        
        
    }
    
    
    
    else if (pickerView == ProvinciaPickerView){
        
        
        
        return 1;
        
        
        
    }
    
    
    
    else
        
        return 0;
    
    
    
}



// Lista CLASE y Lista PROVINCIA



-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component



{
    
    if (pickerView == ClasePickerView){
        
        
        
        return clasePickerViewArray[row];
        
        
        
    }
    
    
    
    else if (pickerView == ProvinciaPickerView){
        
        
        
        return provinciaPickerViewArray[row];
        
        
        
    }
    
    
    
    else
        
        return nil;
    
    
    
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
     UIAlertView *pdfCreadoCorrectamente = [[UIAlertView alloc] initWithTitle:@"Plan de Vuelo Preliminar generado correctamente." message:@"Antes de proceder a su envío se recomienda verificar todos sus campos (COMPRUEBA PDF)." delegate:self cancelButtonTitle:@"ENTENDIDO" otherButtonTitles:nil];
    
     [pdfCreadoCorrectamente show];
    
    
    
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
    NSString *messageBody = @"Se adjunta archivo Pdf con documentación relativa al Plan de Vuelo Operacional programado, en cumplimiento de la normativa legal vigente para la realización de vuelos no tripulados pilotados a distacia en un espacio aéreo no controlado y dentro del territorio español, según la especificaciones de la Agencia Estatal de Seguridad Aérea (AESA).";
    
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
    [self presentViewController:mc animated:YES completion:NULL];}

//OCULTA VENTANA FLOTANTE DEL PDF-------------------------------------------------------//

- (IBAction)OcultaFlotantePdf:(id)sender {
    [FlotanteMuestraPdf setHidden:YES];
    [BotonCerrarFlotante setHidden:YES];}

//OCULTA TECLADO------------------------------------------------------------------------//

- (IBAction)OcultarTeclado:(id)sender {
        [self resignFirstResponder];}

//OCULTA FECHA------------------------------------------------------------------------//
- (IBAction)CierraFechaBoton:(id)sender {
    NSDateFormatter *formato=[[NSDateFormatter alloc]init];
    [formato setDateFormat:@"dd/MMM/YYY"];
    FechaActual.text=[NSString stringWithFormat:@"%@",[formato stringFromDate:_SelectorDatePicker.date]];
    [FlotanteSelectorFecha setHidden:YES];
    [_SelectorDatePicker setHidden:YES];
    [CierraFechaBoton setHidden:YES];}

//MUESTRA FECHA------------------------------------------------------------------------//
- (IBAction)IntroduceFechaBoton:(id)sender{
    [FlotanteSelectorFecha setHidden:NO];
    [_SelectorDatePicker setHidden:NO];
    [CierraFechaBoton setHidden:NO];

}

- (IBAction)AccionCierraFlotanteClase:(id)sender {
  
    
    [_CierraFlotanteClase setHidden:YES];
    [VentanaFlotanteClase setHidden:YES];
    [ClasePickerView setHidden:YES];
    
}

- (IBAction)AccionCierraFlotanteProvincia:(id)sender {
    [_CierraFlotanteProvincia setHidden:YES];
    [VentanaFlotanteProvincia setHidden:YES];
    [ProvinciaPickerView setHidden:YES];
 
}

- (IBAction)cambiaClase:(id)sender {
    
    [_CierraFlotanteClase setHidden:NO];
    [VentanaFlotanteClase setHidden:NO];
        [ClasePickerView setHidden:NO];
    
    
    
    
    
    

}

- (IBAction)CambiaProvincia:(id)sender {
    [_CierraFlotanteProvincia setHidden:NO];
    [VentanaFlotanteProvincia setHidden:NO];
      [ProvinciaPickerView setHidden:NO];
}

- (IBAction)SuenaClick:(id)sender
{AudioServicesPlaySystemSound(BotonTipo2);}
- (IBAction)SuenaBoton:(id)sender
{AudioServicesPlaySystemSound(BotonTipo1);}

- (IBAction)Suenapdf:(id)sender
{AudioServicesPlaySystemSound(BotonTipo3);}


@end




//////////////////////////////////////////////////////////////////////////////////////////
//COMPandGO-----------------------------------------------------------------------------//
//////////////////////////////////////////////////////////////////////////////////////////

