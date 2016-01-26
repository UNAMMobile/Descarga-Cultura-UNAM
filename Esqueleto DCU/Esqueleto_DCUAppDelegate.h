//
//  Esqueleto_DCUAppDelegate.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Esqueleto_DCUViewController;


@interface Esqueleto_DCUAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    Esqueleto_DCUViewController *viewController;
	UIImageView *splashViewTop;
	UIImageView *splashViewLeft;
	UIImageView *splashViewRight;
    

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet Esqueleto_DCUViewController *viewController;

@end
