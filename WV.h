//
//  WV.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 29/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@interface WV : SuperViewController
{
    NSMutableDictionary *dictionary;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dictionary:(NSMutableDictionary *)dictionary1;
@end
