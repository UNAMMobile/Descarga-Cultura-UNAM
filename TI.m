//
//  TI.m
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Vista Tipo Información Un Solo Elemento

/*
 Descripción/Datos que utiliza
 
 Entrada:
 Se alimenta de los datos obtenidos por un servicio web
 
 
 Acción:
 Construye una vista con los Datos de un titulo particular
 
 Salida: 
 Al dar click en los botones cerca de la imagen nos lleva a una vista con opciones para compartir el titulo y con la lista de reproducción
 Al dar click en los botones inferiores nos lleva a la vista correcpondiente.
 
 */

#import "TI.h"
#import "SBJSON.h"
#import "CL.h"

#define IMAGEURL @"http://www.descargacultura.unam.mx/images/mp3Icons/"

@implementation TI

@synthesize ID = _ID;
@synthesize dictionary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil idNumber:(NSString *)idNumber
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ID = idNumber;
        //NSLog(@"TI _ID: %@",_ID);
    }
    return self;
}



-(IBAction)cl
{
    //NSLog(@"Dictionary : %@", dictionary);
    CL *nextPage = [[CL alloc] initWithNibName:@"CL" bundle:nil dictionary:dictionary];
   
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [activityindicator startAnimating];
    
    [NSThread detachNewThreadSelector:@selector(parse) toTarget:self withObject:nil];

}

-(void)parse{
    
    //Parsing
    
    @try {
   
        
    SBJSON *parser = [[SBJSON alloc] init];
    
    NSString *string = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.unam360.com/dcu/service/info?tipo=num&id=%@", _ID]] encoding:NSISOLatin1StringEncoding error:nil];
    
    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
    
    NSMutableDictionary *dictionary_ =[parser objectWithString:string error:nil];
    
    //NSLog(@"dictionary %@", dictionary_);
    
    NSArray *array =[dictionary_ objectForKey:@"datos"];
    
    NSMutableDictionary *dictionary1 =[array objectAtIndex:0] ;
    
    dictionary = [[NSMutableDictionary alloc] init] ;
    
    dictionary = [NSMutableDictionary dictionaryWithDictionary:dictionary1];
    
    [dictionary retain];
    
    //NSLog(@"Dictionary : %@", dictionary);
    
    //Titulo

    label.text = [dictionary1 objectForKey:@"titulo"];

    //Image
    
    [NSThread detachNewThreadSelector:@selector(setImage:) toTarget:image withObject:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:[IMAGEURL stringByAppendingString:[dictionary1 objectForKey:@"image"]]]]]];
    
    // [image setImage:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:[IMAGEURL stringByAppendingString:[dictionary1 objectForKey:@"image"]]]]]];
    
    
    
    //Autores
    
    NSArray *autores = [dictionary1 objectForKey:@"autores"];
     
    NSString *string1 = @"";
    
    for (int i = 0; i<[autores count]; i++) {
        
        NSMutableDictionary *autoresdictionary = [autores objectAtIndex:i];
        
        string1 = [string1 stringByAppendingFormat:@"%@\n", [autoresdictionary objectForKey:@"nombre"]];

    }
    
    string1 = [string1 stringByAppendingFormat:@"Editorial: %@\n", [dictionary1 objectForKey:@"Editorial"]];
    string1 = [string1 stringByAppendingFormat:@"Lectura a cargo de: %@\n", [dictionary1 objectForKey:@"Lectura a cargo de"]];
    string1 = [string1 stringByAppendingFormat:@"Estudio de grabación: %@\n", [dictionary1 objectForKey:@"Estudio de grabacion"]];
    string1 = [string1 stringByAppendingFormat:@"Dirección: %@\n", [dictionary1 objectForKey:@"Dirección"]];
    string1 = [string1 stringByAppendingFormat:@"Música: %@\n", [dictionary1 objectForKey:@"Música"]];
    string1 = [string1 stringByAppendingFormat:@"Año de grabación: %@\n", [dictionary1 objectForKey:@"Año de grabacion"]];
    string1 = [string1 stringByAppendingFormat:@"Operación y postproducción: %@", [dictionary1 objectForKey:@"Operación y postproducción"]];
    
    [textview performSelectorOnMainThread:@selector(setText:) withObject:string1 waitUntilDone:YES];
    
    //Descripcion
    [textviewdescripcion performSelectorOnMainThread:@selector(setText:) withObject:[dictionary1 objectForKey:@"Descripción"] waitUntilDone:YES];
    
    //Rating
    switch ([(NSString *)[dictionary1 objectForKey:@"rating"] intValue]) {
        case 0:
            [star1 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star2 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star3 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star4 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            break;
        case 1:
            [star2 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star3 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star4 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
        case 2:
            [star3 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star4 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
        case 3:
            [star4 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES]; 
        case 4:
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES]; 
        default:
            break;
    }
    
        
    }
    @catch (NSException *exception) {
        [self reachability];
    }
    [activityindicator setHidesWhenStopped:YES];
    [activityindicator stopAnimating];
    [button setHidden:NO];

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
