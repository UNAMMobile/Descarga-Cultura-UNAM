//
//  CL.m
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Vista Tipo Informacion un solo Elemento

/*
 Descripción/Datos que utiliza
 
 Entrada:
 Se alimenta de los datos obtenidos en la VISTA ANTERIOR DE INFORMACION DEL TITULO
 
 
 Acción:
 Construye una vista con los Ligas para compartir y audios de un titulo particular
 
 Salida: 
 Al dar click en el boton de regresar ala informacion REGRESA A LA VISTA DE INFORMACIÓN DETALLADA DEL TITULO
 Al dar click en los botones cerca de la imagen para tw y fb nos lleva a una vista con opciones para compartir nos envia el url del titulo para que podamos compartirlo
 Al dar click en el boton de mail nos pregunta el remitente y el destinatario.
 Al dar click en los los botones de los tracs de audio podemos, dependiendo del boton:
 descargar el audio
 reproducir e audio
 detener el audio
 Al dar click en los botones inferiores nos lleva a la vista correcpondiente.
 
 */

#import "CL.h"
#import "WV.h"
#import "CFT.h"
#define IMAGEURL @"http://www.descargacultura.unam.mx/images/mp3Icons/"

@implementation CL

@synthesize dictionary ;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dictionary:(NSMutableDictionary *)dictionary1
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dictionary = dictionary1;
        //NSLog(@"DICTIONARY FACETWIT : %@", dictionary);
    }
    return self;
}

- (IBAction)facebook:(id)sender {
    
    WV *nextPage = [[WV alloc] initWithNibName:@"WV" bundle:nil  dictionary:dictionary];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

- (IBAction)twitter:(id)sender {
    
    CFT *nextPage = [[CFT alloc] initWithNibName:@"CFT" bundle:nil  dictionary:dictionary];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
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
    
    if (rep == nil) {
        rep = [[[Player alloc] initWithNibName:@"Player" bundle:nil] retain];
        rep.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
    
    /*if (stackSongs == nil) {
        stackSongs = [[[NSMutableArray alloc] init] retain];
    }*/
    
    tracks = [dictionary objectForKey:@"track"];
    
    autores = [dictionary objectForKey:@"autores"];
    
    [activityindicator startAnimating];
    
    [NSThread detachNewThreadSelector:@selector(parse) toTarget:self withObject:nil];

}

-(void)parse{

    
    //NSLog(@"DICTIONARY : %@", dictionary);

    //Titulo
    label.text = [dictionary objectForKey:@"titulo"];
    
    //Image
    
    [NSThread detachNewThreadSelector:@selector(setImage:) toTarget:image withObject:[UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:[IMAGEURL stringByAppendingString:[dictionary objectForKey:@"image"]]]]]];
    
    //Rating
    switch ([(NSString *)[dictionary objectForKey:@"rating"] intValue]) {
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
            break;
        case 2:
            [star3 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star4 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            break;
        case 3:
            [star4 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES]; 
            break;
        case 4:
            [star5 performSelectorOnMainThread:@selector(setHidden:) withObject:[NSNumber numberWithBool:YES] waitUntilDone:YES];
            break;
        default:
            break;
    }
    
    [activityindicator setHidesWhenStopped:YES];
    [activityindicator stopAnimating];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115/5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,tableView.contentSize.width ,125/5)];
    
    if (indexPath.row % 2 == 0) {
        background.image = [UIImage imageNamed:@"fondo-lista-A.png"];
    }
    else
    {
        background.image = [UIImage imageNamed:@"fondo-lista-B.png"];
    }
    
    [[cell contentView] addSubview:background];
    
    cell.textLabel.backgroundColor=[UIColor clearColor];
    
    cell.textLabel.textColor=[UIColor whiteColor];
    
    NSMutableDictionary *track = [tracks objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [track objectForKey:@"titulo"];
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Estados *state = [[Estados alloc] init];
    
    [state initWithDefaultValues];
    
    NSMutableDictionary *track = [tracks objectAtIndex:indexPath.row];
    
    NSMutableDictionary *autor;
    
    @try {
        autor = [autores objectAtIndex:0];
    }
    @catch (NSException *exception) {
        autor = [[NSMutableDictionary alloc] initWithObjects:[NSArray arrayWithObject:@""] forKeys:[NSArray arrayWithObject:@"nombre"]];
    }
        
    NSString *portada = [[NSString alloc] initWithString:[IMAGEURL stringByAppendingString:[dictionary objectForKey:@"image"]]];
    
    [state initWithTitle:[track objectForKey:@"titulo"] image:portada urlPath:/*@"http://nyanit.com/audio/nyanlooped.mp3"*/[track objectForKey:@"url"] raiting:[(NSString *)[dictionary objectForKey:@"rating"] intValue] length:[track objectForKey:@"duracion"] author:[autor objectForKey:@"nombre"]];
    
    [Player push:state];
    
    /*[stackSongs insertObject:state atIndex:0];
    
    
    NSLog(@"=======================================");
    for (int k = 0; k<stackSongs.count; k++) {
        NSLog(@"HEY HEY HEY : %@",[[stackSongs objectAtIndex:k] getTitle]);
    }*/
    
    [self.view addSubview:rep.view];
    [self presentModalViewController:rep animated:YES];
    

}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return tracks.count;
	
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

- (IBAction)reproductor {
    
    if (rep == nil) {
        rep = [[[Player alloc] initWithNibName:@"Player" bundle:nil] retain];
        rep.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
    [self.view addSubview:rep.view];
    [self presentModalViewController:rep animated:YES];
    
}

@end
