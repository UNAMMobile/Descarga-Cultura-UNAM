//
//  E1.m
//  Esqueleto DCU
//
//  Created by Julio César on 1/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "E1.h"


@implementation E1

@synthesize label1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil label1String:(NSString *)string
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        labelString = [[NSString alloc] initWithString:string];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    UIImage *buttonImageNormal = [UIImage imageNamed:@"blueButton.png"];
	UIImage *stretchableButtonImageNormal = [buttonImageNormal stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[conf setBackgroundImage:stretchableButtonImageNormal forState:UIControlStateNormal];
	UIImage *buttonImagePressed = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImagePressed = [buttonImagePressed stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[conf setBackgroundImage:stretchableButtonImagePressed forState:UIControlStateHighlighted];
    
    UIImage *buttonImageNormal1 = [UIImage imageNamed:@"redButton.png"];
	UIImage *stretchableButtonImageNormal1 = [buttonImageNormal1 stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[salir setBackgroundImage:stretchableButtonImageNormal1 forState:UIControlStateNormal];
	UIImage *buttonImagePressed1 = [UIImage imageNamed:@"whiteButton.png"];
	UIImage *stretchableButtonImagePressed1 = [buttonImagePressed1 stretchableImageWithLeftCapWidth:12 topCapHeight:0];
	[salir setBackgroundImage:stretchableButtonImagePressed1 forState:UIControlStateHighlighted];
    [label1 setText:labelString];
}

@end
