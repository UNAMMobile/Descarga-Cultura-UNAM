//
//  CFT.m
//  Esqueleto DCU
//
//  Created by Genaro Marmolejo on 11/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CFT.h"

@implementation CFT


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dictionary:(NSMutableDictionary *)dictionary1
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dictionary = dictionary1;
        //NSLog(@"DICTIONARY FACETWIT : %@", dictionary);
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
    
    CGRect webFrame = CGRectMake(0.0, 44.0, 320.0, 372.0);
    UIWebView *webView = [[UIWebView alloc] initWithFrame:webFrame];
    [webView setBackgroundColor:[UIColor whiteColor]];
    NSString *urlAddress = [[[dictionary objectForKey:@"compartir"] objectAtIndex:1] objectForKey:@"twitter"];
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [webView loadRequest:requestObj];
    [self.view addSubview:webView]; 
    [webView release];
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
