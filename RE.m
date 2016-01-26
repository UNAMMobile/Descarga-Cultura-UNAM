//
//  RE.m
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Vista Tipo Reproductor de Audio

/*
 Descripción/Datos que utiliza
 
 Entrada:
 Se alimenta de los audios descargados desde el servidor
 
 
 Acción:
 Construye una vista para la Lista con las reproducciones del usuario, indicando cuales ya estan descargadas, cuales estan en proceso, cual esta reproduciendose y una interfaz para controlar los audios.
 EL REPRODUCTOR SIEMPRE REGRESA A LA VISTA DESDE LA CUAL FUE INVOCADO.
 
 Salida: 
 Al dar click en los botones inferiores nos llevan a la vista correspondiente
 Al dar click en los controles de reproduccion se ejecuta la accion seleccionada
 Al dar click en el icono de descarga se inicia el proceso para bajar al dispositivo el audio
 al dar click en la bocina dentro de la lista, se reproducirá el elemento.
 
 */

#import "RE.h"


@implementation RE

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
