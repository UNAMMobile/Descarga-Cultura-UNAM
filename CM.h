//
//  CM.h
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SuperViewController.h"

@class SuperViewController;

@interface CM : SuperViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>{
    IBOutlet UITableView *_tableView;
    IBOutlet UIActivityIndicatorView *_activityIndicator;
    IBOutlet UISearchBar *_searchBar;
    
    NSMutableArray *datos;
    NSMutableArray *itemArray;
    NSMutableDictionary *dictionary;
    NSMutableDictionary *parseddictionary;
    /////
    //NSMutableDictionary *auxdictionary;
}

@property(nonatomic, retain)    IBOutlet UITableView *_tableView;
@property(nonatomic, retain)    IBOutlet UIActivityIndicatorView *_activityIndicator;
@property(nonatomic, retain)    IBOutlet UISearchBar *_searchBar;

-(void)copyDictionary;
@end
