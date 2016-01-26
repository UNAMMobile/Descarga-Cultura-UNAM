//
//  CO.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SuperViewController.h"
#import "Reachability.h"
#import "Player.h"
#import "Esqueleto_DCUViewController.h"

@class SuperViewController;

@interface CO : SuperViewController <UIAlertViewDelegate, UIActionSheetDelegate>{

    NSString *wifi;
    NSString *datos;
    UIImage *checked;
    UIImage *unchecked;
    UIAlertView *confirm;
    IBOutlet UISwitch *swifi;
    IBOutlet UISwitch *sdatos;
    IBOutlet UIButton *enviarDatos;
    IBOutlet UIButton *borrarDatos;
    
}

- (IBAction) wifi;
- (IBAction) datos;
- (IBAction) enviar;
- (IBAction) obtieneplist;
- (IBAction) borrarTodo;
- (IBAction)reproductor;

- (void) writeToPlist;


@property(nonatomic,retain) IBOutlet UISwitch *swifi;
@property(nonatomic,retain) IBOutlet UISwitch *sdatos;

@end
