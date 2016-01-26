//
//  TM.m
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Vista Tipo Lista

/*
 Descripción/Datos que utiliza
 
 Entrada:
 Se alimenta de los datos obtenidos por un servicio web
 
 
 Acción:
 Construye una lista con los titulos ordenados alfabeticamente y con separadores en cada letra.
 
 Salida: 
 Al dar click en un elemento nos lleva a la descripción del mismo
 Al dar click en los botones inferiores nos lleva a la vista correcpondiente.
 
 */

#import "TM.h"
#import "SBJSON.h"
#import "TI.h"

#define LLAVE @"titulo"

@implementation TM

@synthesize songs, sections;

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    if (searching) {
        return 1;
    }
	return [[self.sections allKeys] count];
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (searching) {
        return nil;
    }
    return [[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (searching) {
        return [displayItems count];
    }
	return [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:section]] count];
	
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    if (searching) {
        return nil;
    }
    return [[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray; 
    
    
    
    
    if (searching) {
        cell.textLabel.text = [[displayItems objectAtIndex:indexPath.row] objectForKey:LLAVE];
        //cell.detailTextLabel.text = [[displayItems objectAtIndex:indexPath.row] objectForKey:@"id"];
        return cell;
    }
    
    NSDictionary *song = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
    cell.textLabel.text = [song objectForKey:LLAVE];
    //cell.detailTextLabel.text = [song objectForKey:@"id"];
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TI *nextPage;
    if (searching) {
        nextPage = [[TI alloc] initWithNibName:@"TI" bundle:nil idNumber:[NSString stringWithFormat:@"%@", [[displayItems objectAtIndex:indexPath.row] objectForKey:@"id"]]];
        nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view addSubview:nextPage.view];
        [self presentModalViewController:nextPage animated:YES];
    } else {
        NSDictionary *song = [[self.sections valueForKey:[[[self.sections allKeys] sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)] objectAtIndex:indexPath.section]] objectAtIndex:indexPath.row];
        nextPage = [[TI alloc] initWithNibName:@"TI" bundle:nil idNumber:[NSString stringWithFormat:@"%@", [song objectForKey:@"id"]]];
        nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self.view addSubview:nextPage.view];
        [self presentModalViewController:nextPage animated:YES];

    
    }
   
}


- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
	if ([searchText length]==0) {
		[displayItems removeAllObjects];
		[displayItems addObjectsFromArray:totalItemsOrdenados];
        
	} else {
		[displayItems removeAllObjects];
        
        //for (int i=0; i<[totalItemsOrdenados count]; i++) {
        int i=0;
        for(NSString *string in totalItemsOrdenadosX){
            
            NSRange r = [string rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (r.location != NSNotFound) {
                [displayItems addObject:[totalItemsOrdenados objectAtIndex:i]];
            }
            i++;
        }            
        
        //}
		
	}
    searching=YES;
	[tableView reloadData];
	
	
}



-(void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar{
    searching=YES;
	[searchBar resignFirstResponder];
    
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar{
    searchBar.text =@"";
    searching=NO;
	[searchBar resignFirstResponder];
    [tableView reloadData];
    
}

- (IBAction) goBack {
	
	
	[self dismissModalViewControllerAnimated:YES];
	
	
	
	
}

- (NSString *) documentsPath {
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [paths objectAtIndex:0];
	return documentsDir;
	
}





// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization.
 }
 return self;
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
	tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    
    [activityIndicator startAnimating];
    //CODIGO DE PRUEBA YES
    //if(    [self reachability])
    [NSThread detachNewThreadSelector:@selector(viewDidThread) toTarget:self withObject:nil];
    
    
    
}

-(void) viewDidThread {
    
    @try {
        //////////////////////////////////////
        
        SBJSON *parser = [[SBJSON alloc] init];
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.unam360.com/dcu/service/filtro?tipo=titulos"] encoding:NSISOLatin1StringEncoding error:nil];
        
        NSMutableDictionary *arra = [parser objectWithString:string error:nil];
       
        NSMutableDictionary *temp = (NSMutableDictionary *) [arra objectForKey:@"datos"];
        
        self.songs = [[NSMutableArray alloc] init];
        
        for(NSDictionary *x in temp){
            [self.songs addObject:[x objectForKey:@"datos"]];
        }
        /*for(int i=0;i<[self.songs count];i++){
            NSLog(@"%@",[self.songs objectAtIndex:i]);    
        }*/
        
               
        self.sections = [[NSMutableDictionary alloc] init];
        
        BOOL found;
        
        // Loop through the books and create our keys
        for (int i=0; i<[self.songs count]; i++) {
            for (NSDictionary *song in [self.songs objectAtIndex:i])
            {   
                
                NSString *c = [[song objectForKey:LLAVE] substringToIndex:1];
                
                found = NO;
                
                for (NSString *str in [self.sections allKeys])
                {
                    if ([str isEqualToString:c])
                    {
                        found = YES;
                    }
                }
                
                if (!found)
                {     
                    [self.sections setValue:[[NSMutableArray alloc] init] forKey:c];
                }
            }
            
            for (NSDictionary *song in [self.songs objectAtIndex:i])
            {
                [[self.sections objectForKey:[[song objectForKey:LLAVE] substringToIndex:1]] addObject:song];
            }      
        }
        
        
        
        for (NSString *key in [self.sections allKeys])
        {
            [[self.sections objectForKey:key] sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:LLAVE ascending:YES]]];
        }
        
        searching=NO;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
        totalItemsOrdenados = [[NSMutableArray alloc] init];
        totalItemsOrdenadosX = [[NSMutableArray alloc] init];
        for (int i=0; i<[self.songs count]; i++) {
            for (NSDictionary *song in [self.songs objectAtIndex:i]) {
                NSString *s = [song objectForKey:LLAVE];
                [totalItemsOrdenados addObject:song];
                [totalItemsOrdenadosX addObject:s];
            }
        }
        
        
        displayItems = [[NSMutableArray alloc] initWithArray:totalItemsOrdenados];
    }
    @catch (NSException *exception) {
        [self reachability];
    }
    @finally {
        if (![self internetreachability]) {
            [self reachability];
        }
    }
    
    [tableView reloadData];
    [activityIndicator setHidesWhenStopped:YES];
    [activityIndicator stopAnimating];
    
}

- (void)keyboardShown:(NSNotification *)note {
	searching = YES;
	CGRect keyboardFrame;
	[[[note userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardFrame];
	CGRect tableViewFrame = tableView.frame;
    CGRect searchBarFrame = searchBar.frame;
	tableViewFrame.size.height = tableViewFrame.size.height-keyboardFrame.size.height+searchBarFrame.size.height;
	[tableView setFrame:tableViewFrame];
    //searching = YES;
    [tableView reloadData];
    
    
}

- (void)keyboardHidden:(NSNotification *)note {
	
    
    
	[tableView setFrame:self.view.bounds];
    CGRect tableViewFrame = tableView.frame;
    tableViewFrame.size.height = tableViewFrame.size.height -88-44;
    tableViewFrame.origin.y=88;
    [tableView setFrame:tableViewFrame];
    
}





/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
	
    [super viewDidUnload];
	
	
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	
    [super dealloc];
}


@end
