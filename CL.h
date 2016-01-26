//
//  CL.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "Player.h"
#import "Estados.h"
#import "Esqueleto_DCUViewController.h"

@class SuperViewController;

@interface CL : SuperViewController <UITableViewDataSource, UITableViewDelegate> {
    
    IBOutlet UILabel *label;
    
    IBOutlet UIImageView *star1;
    IBOutlet UIImageView *star2;
    IBOutlet UIImageView *star3;
    IBOutlet UIImageView *star4;
    IBOutlet UIImageView *star5;
    
    IBOutlet UIImageView *image;
    
    IBOutlet UIActivityIndicatorView *activityindicator;
    
    NSMutableDictionary *dictionary;
    
    NSMutableArray *tracks;
    
    NSMutableArray *autores;
}

@property(nonatomic,retain)  NSMutableDictionary *dictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dictionary:(NSMutableDictionary *)dictionary1;
- (IBAction)facebook:(id)sender;
- (IBAction)reproductor;

@end
