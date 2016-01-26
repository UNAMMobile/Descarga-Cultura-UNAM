//
//  SP.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"
#import "Player.h"
#import "Esqueleto_DCUViewController.h"
#import "CL.h"

@interface SP : SuperViewController {

#pragma mark - Table View Atributes
    
    NSMutableArray *standardinputtableviewarray;
    
    BOOL scrollable;
    
    int numberfbuttonsinrow;
    int numberofbuttonsperrow;
    int buttonwidth;
    int buttonheight;
    int initialx ;
    int initialy;
    int x;
    int y;
    int xspacebetweenbuttons;
    int yspacebetweenbuttons;
    
    int labelx;
    int labely;
    int labelheight;
    int labelwidth;
    
    IBOutlet UITableView *tableViewOutlet;
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)buttonAction:(UIButton *)button;

-(IBAction)reproductor;



@end
