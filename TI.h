//
//  TI.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@class SuperViewController;

@interface TI : SuperViewController /*<UITableViewDelegate, UITableViewDataSource>*/{
    
    IBOutlet UILabel *label;
    
    IBOutlet UIImageView *star1;
    IBOutlet UIImageView *star2;
    IBOutlet UIImageView *star3;
    IBOutlet UIImageView *star4;
    IBOutlet UIImageView *star5;
    
    IBOutlet UIImageView *image;
    
    IBOutlet UITextView *textview;
    IBOutlet UITextView *textviewdescripcion;
    
    IBOutlet UIActivityIndicatorView *activityindicator;
    
    IBOutlet UIButton *button;
    
    NSString *ID;
    
    NSMutableDictionary *dictionary;
}

@property(nonatomic, retain) NSString *ID;
@property(nonatomic, retain) NSMutableDictionary *dictionary;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil idNumber:(NSString *)idNumber;

@end
