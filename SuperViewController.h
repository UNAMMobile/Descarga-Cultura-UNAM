//
//  SuperViewController.h
//  Esqueleto DCU
//
//  Created by Julio César on 12/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoView.h"


@interface SuperViewController : UIViewController {
    InfoView *infoView;
  
}

-(IBAction)sp;
-(IBAction)co;
-(IBAction)cm;
-(IBAction)lc;
-(IBAction)la;
-(IBAction)am;
-(IBAction)tm;
-(IBAction)ti;
-(IBAction)cl;
-(IBAction)in; 
-(IBAction)re;
-(IBAction)e1;
-(IBAction)e2;
-(IBAction)dissmiss;
-(IBAction)exit:(id)sender;
-(IBAction)alertComingSoon:(id)sender;


-(Boolean)reachability;
-(Boolean)internetreachability;


@end
