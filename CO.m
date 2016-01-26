//
//  CO.m
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Vista Tipo Menu Configuracion

/*
 Descripción/Datos que utiliza
 
 Ninguno
 
 */

#import "CO.h"


@implementation CO

@synthesize swifi,sdatos;


- (IBAction) wifi {
    
    if (wifi==@"NO"){
        wifi=@"YES";
           
    }
    else {
        wifi=@"NO";
        
    }
    
}

- (IBAction) datos {
    
    if (datos==@"NO") {
        datos=@"YES";
         
    }
    else {
        datos=@"NO";
         
    }
    
}

- (IBAction) enviar {
    UIAlertView *elegirOpcion = [[UIAlertView alloc] initWithTitle:@"Oops!" message:@"Necesitas elegir una opción" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    if (datos == @"NO" && wifi == @"NO") {
        //NSLog(@"No se envia a plist");
        [elegirOpcion show];
    }
    else {
        //NSLog(@"Se envia a plist");
        [self writeToPlist];
		NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
		NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
		NSString *valuewifi; 
		valuewifi = [plistDict valueForKey:@"Wifi"];
		NSString *valuedatos;
		valuedatos = [plistDict valueForKey:@"Datos"];
		NSLog(@"Wifi: %@",valuewifi);
		NSLog(@"Datos: %@",valuedatos);
		[self dismissModalViewControllerAnimated:YES];
        
    }
    
}

- (IBAction) obtieneplist {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSString *valuewifi; 
    valuewifi = [plistDict valueForKey:@"Wifi"];
    NSString *valuedatos;
    valuedatos = [plistDict valueForKey:@"Datos"];
    //NSLog(@"Wifi: %@",valuewifi);
    //NSLog(@"Datos: %@",valuedatos);
    
    
}

- (IBAction) borrarTodo {
    
    
    UIActionSheet *actionBorra =  [[UIActionSheet alloc] initWithTitle:@"¿Estás Seguro?" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:@"Borrar Todo" otherButtonTitles: nil];   
    [actionBorra showInView:self.view];
	[actionBorra release];
    
    
    


}

- (void)actionSheet:(UIActionSheet *)actionSheet
didDismissWithButtonIndex:(NSInteger)buttonIndex{
	if(!(buttonIndex == [actionSheet cancelButtonIndex]))
	{
		NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
        NSString *documentsDirectoryPath = [paths objectAtIndex:0];
        //NSLog(@"PATH: %@", documentsDirectoryPath);
        NSFileManager *file = [NSFileManager defaultManager];
        //NSMutableArray *arreglo= [[NSMutableArray alloc] init];
        NSArray *arreglo = [[NSArray alloc] initWithArray:[file contentsOfDirectoryAtPath:documentsDirectoryPath error:nil]];
        //NSLog(@"%@",arreglo);
        for (int i=0; i<[arreglo count]; i++) {
            NSString *myFilePath = [documentsDirectoryPath stringByAppendingPathComponent:[arreglo objectAtIndex:i]];
            [file removeItemAtPath:myFilePath error:nil];
        }
        NSArray *arreglo2 = [[NSArray alloc] initWithArray:[file contentsOfDirectoryAtPath:documentsDirectoryPath error:nil]];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        
        
        NSMutableDictionary *elplist = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
        [[elplist objectForKey:@"Musica"] removeAllObjects];
        [elplist writeToFile:filePath atomically:YES];
        //NSLog(@"Arreglo borrado: %@",arreglo2);
	}
    
}

- (void)writeToPlist
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    
    if (wifi== @"YES" && datos == @"YES") {
        [plistDict setValue:@"YES" forKey:@"Wifi"];
        [plistDict setValue:@"YES" forKey:@"Datos"];
    } else {
        if (wifi == @"YES") {
            [plistDict setValue:@"YES" forKey:@"Wifi"];
            [plistDict setValue:@"NO" forKey:@"Datos"];
        } else {
            [plistDict setValue:@"NO" forKey:@"Wifi"];
            [plistDict setValue:@"YES" forKey:@"Datos"];
            
        }
        
    }
    
    [plistDict writeToFile:filePath atomically: YES];
    /* This would change the firmware version in the plist to 1.1.1 by initing the NSDictionary with the plist, then changing the value of the string in the key “ProductVersion” to what you specified */
}

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

#pragma mark UIAlertView


- (void)viewDidLoad
{
    
    
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSString *valuewifi; 
    valuewifi = [plistDict valueForKey:@"Wifi"];
    NSString *valuedatos;
    valuedatos = [plistDict valueForKey:@"Datos"];
    //NSLog(@"Wifi: %@",valuewifi);
    //NSLog(@"Datos: %@",valuedatos);
    //wifi=valuewifi;
    //datos=valuedatos;
    if ([valuewifi isEqualToString:@"YES"]) {
        //swifi.on=YES;
        [swifi setOn:YES];
        wifi=@"YES";
    }
    if ([valuedatos isEqualToString:@"YES"]) {
        //sdatos.on=YES;
        [sdatos setOn:YES];
        datos=@"YES";
    }
    if ([valuewifi isEqualToString:@"NO"]) {
        //swifi.on=YES;
        [swifi setOn:NO];
        wifi=@"NO";
    }
    if ([valuedatos isEqualToString:@"NO"]) {
        //sdatos.on=YES;
        [sdatos setOn:NO];
        datos=@"NO";
    }
    
    
    
    
    
    
    
    
    confirm = [[UIAlertView alloc] initWithTitle:@"¿Estás Seguro?" message:@"" delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Enviar", nil];
    
    
    
    
    UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[enviarDatos setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	UIImage *buttonImagePressed = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[enviarDatos setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
    
    UIImage *buttonImageNormal1 = [UIImage imageNamed:@"redButton.png"];
	UIImage *stretchableButtonImageNormal1 = [buttonImageNormal1 stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[borrarDatos setBackgroundImage:stretchableButtonImageNormal1 forState:UIControlStateNormal];
	UIImage *buttonImagePressed1 = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImagePressed1 = [buttonImagePressed1 stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[borrarDatos setBackgroundImage:stretchableButtonImagePressed1 forState:UIControlStateHighlighted];
    
    
    
    
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

- (IBAction)reproductor {
    
    if (rep == nil) {
        rep = [[[Player alloc] initWithNibName:@"Player" bundle:nil] retain];
        rep.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
    [self.view addSubview:rep.view];
    [self presentModalViewController:rep animated:YES];
    
}


@end
