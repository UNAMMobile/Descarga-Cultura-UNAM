//
//  SuperViewController.m
//  Esqueleto DCU
//
//  Created by Julio César on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SuperViewController.h"

#import "SP.h"
#import "CO.h"
#import "CM.h"
#import "LC.h"
#import "LA.h"
#import "AM.h"
#import "TM.h"
#import "TI.h"
#import "CL.h"
#import "IN.h"
#import "RE.h"
#import "E1.h"
#import "E2.h"

#import "Reachability.h"

@implementation SuperViewController



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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
   // [self reachability];
    
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

-(Boolean)reachability{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    NSMutableDictionary* plistDict = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    NSString *valuewifi; 
    valuewifi = [plistDict valueForKey:@"Wifi"];
    NSString *valuedatos;
    valuedatos = [plistDict valueForKey:@"Datos"];
    NSLog(@"Wifi: %@",valuewifi);
    NSLog(@"Datos: %@",valuedatos);
    
    Boolean status = true;
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"http://132.248.204.131:8080/podcast/service/top?tipo=fav"]
                               retain];
   
   /* Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"]
                               retain]; */
    
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
    if(netStatus == NotReachable)
    {
        // no connection
        @try {
             [self e1];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        status = false;
      
        NSLog(@"Internet not reachable");
        
    } else if(netStatus == ReachableViaWiFi && valuewifi == NO)
    {
        [self e2];
        // WiFi connection
    } else if(netStatus == ReachableViaWWAN && valuedatos == NO)
    {
        [self e2];
        // 3G connection
    }
    
    return status;
       
}

-(Boolean)internetreachability{
    Reachability* wifiReach = [[Reachability reachabilityWithHostName: @"www.apple.com"] retain];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];    
    if(netStatus == NotReachable)
    {
        // no connection
        @try {
            //[self e1];
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
        return NO;
        
        
    } else if(netStatus == ReachableViaWiFi)
    {
        // WiFi connection
    } else if(netStatus == ReachableViaWWAN)
    {
        // 3G connection
    }
    return YES;
}

#pragma mark - IBAction

-(IBAction)sp
{
    SP *nextPage = [[SP alloc] initWithNibName:@"SP" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

-(IBAction)co
{
    CO *nextPage = [[CO alloc] initWithNibName:@"CO" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
}

-(IBAction)cm
{
    CM *nextPage = [[CM alloc] initWithNibName:@"CM" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

-(IBAction)lc
{
    LC *nextPage = [[LC alloc] initWithNibName:@"LC" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

-(IBAction)la
{
    LA *nextPage = [[LA alloc] initWithNibName:@"LA" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

-(IBAction)am
{
    AM *nextPage = [[AM alloc] initWithNibName:@"AM" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

-(IBAction)tm
{
    TM *nextPage = [[TM alloc] initWithNibName:@"TM" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

-(IBAction)ti
{
    TI *nextPage = [[TI alloc] initWithNibName:@"TI" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}


-(IBAction)cl
{
    CL *nextPage = [[CL alloc] initWithNibName:@"CL" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}


-(IBAction)in 
{
    IN *nextPage = [[IN alloc] initWithNibName:@"IN" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}


-(IBAction)re
{
    RE *nextPage = [[RE alloc] initWithNibName:@"RE" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

-(IBAction)e1
{
        E1 *nextPage = [[E1 alloc] initWithNibName:@"E1" bundle:nil label1String:@"La aplicación no puede conectarse a internet para obtener los datos que necesita.Revise su conexión o las configuraciones de la aplicación."];
        nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view addSubview:nextPage.view];
        [self presentModalViewController:nextPage animated:YES];
   
}

-(IBAction)e2
{
    E2 *nextPage = [[E2 alloc] initWithNibName:@"E2" bundle:nil];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
}


-(IBAction)dissmiss {
    
    [self dismissModalViewControllerAnimated:YES];
    
}

-(IBAction)exit:(id)sender
{
    exit(0);
}

-(IBAction)alertComingSoon:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Proximamente..." 
                                                   delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



@end
