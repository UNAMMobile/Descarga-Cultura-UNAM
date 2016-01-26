//
//  CFT.h
//  Esqueleto DCU
//
//  Created by Genaro Marmolejo on 11/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"


@interface CFT : SuperViewController {
    
    NSMutableDictionary *dictionary;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dictionary:(NSMutableDictionary *)dictionary1;



@end
