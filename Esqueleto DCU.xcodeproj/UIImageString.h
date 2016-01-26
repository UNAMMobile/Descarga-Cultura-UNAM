//
//  UIImageString.h
//  Esqueleto DCU
//
//  Created by Julio César on 1/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface UIImageString : NSObject {
    UIImage *image;
    NSString *string;
}

@property(nonatomic, retain) NSString *string;

@property(nonatomic, retain)  UIImage *image;

@end
