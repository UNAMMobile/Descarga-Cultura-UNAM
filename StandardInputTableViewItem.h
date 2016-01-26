//
//  StandardInputTableViewItem.h
//  Descarga Cultura UNAM
//
//  Created by julio.guzman on 04/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StandardInputTableViewItem : NSObject {
    NSMutableDictionary *imagedictionary;
    NSMutableDictionary *stringdictionary;
}
@property(nonatomic,retain)  NSMutableDictionary *imagedictionary;
@property(nonatomic,retain) NSMutableDictionary *stringdictionary;

@end
