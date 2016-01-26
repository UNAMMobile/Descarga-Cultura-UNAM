//
//  AM.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJSON.h"
#import "SuperViewController.h"

@class SuperViewController;

@interface AM : SuperViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>{
    IBOutlet UITableView *tableView;
	IBOutlet UISearchBar *searchBar;
	
    BOOL searching;
    
    NSMutableArray *songs;
    NSMutableDictionary *sections;
    
	NSMutableArray *totalItems;
    NSMutableArray *totalItemsOrdenados;
    NSMutableArray *totalItemsOrdenadosX;
	NSMutableArray *displayItems;
    NSMutableArray *listOfItems;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
}

- (IBAction) goBack;

- (NSString *) documentsPath;

@property (nonatomic, retain) NSMutableArray *songs;
@property (nonatomic, retain) NSMutableDictionary *sections;

@end
