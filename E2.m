//
//  E2.m
//  Esqueleto DCU
//
//  Created by Genaro Marmolejo on 28/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "E2.h"

@implementation E2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
