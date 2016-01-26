//
//  LC.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SP.h"

@class SP;

@interface LC : SP {
    
    NSString *ID;
    NSString *categoryName;
    
    IBOutlet UILabel *label1;
    
}

@property(nonatomic, retain) NSString *ID;

@property(nonatomic, retain) NSString *categoryName;

@property(nonatomic, retain) IBOutlet UILabel *label1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil idNumber:(NSString *)idNumber categoryName:(NSString *)name
;

@end
