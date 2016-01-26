//
//  E1.h
//  Esqueleto DCU
//
//  Created by Julio César on 1/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface E1 : SuperViewController {

    IBOutlet UILabel *label1; 
    IBOutlet UIButton *conf;
    IBOutlet UIButton *salir;
    NSString *labelString;
    
}

@property(nonatomic, retain) IBOutlet UILabel *label1; 

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil label1String:(NSString *)string;

@end
