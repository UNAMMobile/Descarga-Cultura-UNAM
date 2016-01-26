//
//  CM.m
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Vista Tipo Grid Desplazable

/*
 Descripción/Datos que utiliza
 
 Entrada:
 Se alimenta de los datos obtenidos por un servicio web
 
 
 Acción:
 Construye la vista con las caterogias y genera una elemento para simular el recuadro de la imagen conteniendo el texto de la subcategoria.
 
 
 Salida: 
 Al dar click en un elemento nos lleva a la vista de la subcategoria
 Al dar click en los botones inferiores nos lleva a la vista correcpondiente.
 
 
 Subcategorias dispuestas por categorias e iconos generados a partir del texto
 Literatura
    Letras mexicanas en voz de sus autores
    Ensayo
    Cuento contemporáneo
    Narrativa mexicana
    Poesía
    Letras de Iberoamérica en voz de sus autores
    Voces de Punto de Partida
    Voces de la literatura universal
    Clásicos de la literatura francesa
    Lenguas de México
    Voz Viva
    Clásicos de la literatura en inglés
    En los Siglos de Oro
 Teatro
    Teatro en atril
    Radioteatros
    Regaladores de palabras
 Música
    OFUNAM
    OSM
En voz de la Academia
    Grandes Maestros.UNAM
    Conferencias
    ¿Cómo ves?... Ciencia para llevar
    Cultura prehispánica
    Charlas con...
    Debates en la ciencia
Voces para el bachillerato
    Biología
    Química
    Letras
    Formación artística
    Sistema político mexicano
    Filosofía
    Especiales
    Premio Príncipe de Asturias
    100 años UNAM
    Bicentenario de la Independencia
 
 */

#import "CM.h"
#import "StandardInputTableViewItem.h"
#import "SBJSON.h"
#import "UIImageString.h"
#import "LC.h"
#define IMAGEURL @"http://www.descargacultura.unam.mx/images/mp3Icons/"

@implementation CM

@synthesize _tableView, _activityIndicator, _searchBar;

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fondo.png"]];
    
    [_activityIndicator startAnimating];
    
    [NSThread detachNewThreadSelector:@selector(parse) toTarget:self withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShown:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)parse
{
    //CODIGO DE PRUEBA YES
    //if(    [self reachability])
    @try {
        
        SBJSON *parser = [[SBJSON alloc] init];
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.unam360.com/dcu/service/filtro?tipo=categorias"] encoding:NSISOLatin1StringEncoding error:nil];
        
        itemArray = [[NSMutableArray alloc] init];
        
        parseddictionary = [parser objectWithString:string error:nil];
        
        [parseddictionary retain];
        
        datos = [parseddictionary objectForKey:@"datos"];
        
        //Pasar cada uno de los items a un arreglo
        
        for (int i= 0; i<datos.count; i++) {
            
            NSArray *array = [[datos objectAtIndex:i] objectForKey:@"datos"];
            
            for (int j=0; j<array.count; j++) {
                
                [itemArray addObject:[array objectAtIndex:j]];

            }
            
        }

    }
    @catch (NSException *exception) {
        [self reachability];
    }
    @finally {
        
            if (![self internetreachability]) {
                [self reachability];
            }
        
        [self copyDictionary];
        [_tableView setDelegate:self];
        [_tableView setDataSource:self];
        [_tableView reloadData];
        
        [_activityIndicator setHidesWhenStopped:YES];
        [_activityIndicator stopAnimating];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return  ((NSMutableArray *)[dictionary objectForKey:@"datos"]).count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return ((NSString *)[[[dictionary objectForKey:@"datos"] objectAtIndex:section] objectForKey:@"nombre"]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = (NSArray *)([[((NSMutableArray *)[dictionary objectForKey:@"datos"]) objectAtIndex:section] objectForKey:@"datos"]);
    return array.count;
}

-(IBAction)reload:(id)sender
{
    [_tableView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
      UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    @try {
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.text = [[[[[dictionary objectForKey:@"datos"] objectAtIndex:indexPath.section] objectForKey:@"datos"] objectAtIndex:indexPath.row] objectForKey:@"titulo"] ;
           
    }
    @catch (NSException *exception) {}
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LC *nextPage = [[LC alloc] initWithNibName:@"LC" bundle:nil idNumber:[NSString stringWithFormat:@"%@", [[[[[dictionary objectForKey:@"datos"] objectAtIndex:indexPath.section] objectForKey:@"datos"] objectAtIndex:indexPath.row] objectForKey:@"id"]] categoryName: [[[[[dictionary objectForKey:@"datos"] objectAtIndex:indexPath.section] objectForKey:@"datos"] objectAtIndex:indexPath.row] objectForKey:@"titulo"]];
    
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText 
{

    [self copyDictionary];
    
    //NSLog(@">>>>>>>>>>>>>>>>>>>>>>>>>searchText: %@", searchText);

    cosa:
    
    [_tableView reloadData];
    
    for (int i=0; i<((NSArray *)[dictionary objectForKey:@"datos"]).count; i++) {
      
        for (int j=0; j<((NSArray *)[[[dictionary objectForKey:@"datos"] objectAtIndex:i] objectForKey:@"datos"]).count; j++) {
            
            @try {
                
                NSRange r = [[[[[[dictionary objectForKey:@"datos"] objectAtIndex:i] objectForKey:@"datos"] objectAtIndex:j] objectForKey:@"titulo"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
                
                if (r.location == NSNotFound) {
                    
                    [[[[dictionary objectForKey:@"datos"] objectAtIndex:i] objectForKey:@"datos"] removeObjectAtIndex:j]; 
                    goto cosa;
                }
            }
            @catch (NSException *exception) {}
            
        }
        
    }
    
    [_tableView reloadData];
    [_tableView setContentOffset:CGPointMake(0, 0)];

}

-(void)copyDictionary
{
    dictionary = [[NSMutableDictionary alloc] init];
    
    NSMutableArray *datos_ = [[NSMutableArray alloc] init];
    
    for (NSMutableDictionary *dictionary_ in [parseddictionary objectForKey:@"datos"]) {
    
        //Toma info de datos 2
        NSMutableArray *datos2 = [dictionary_ objectForKey:@"datos"];
        NSMutableArray *seconddatos = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *dictionary_2 in datos2) {
            
            NSMutableDictionary *seconddictionary =  [dictionary_2 mutableCopy];
            [seconddatos addObject:seconddictionary]; 
        }
        NSMutableDictionary *adict =[[NSMutableDictionary alloc] init];
        [adict setValue:seconddatos forKey:@"datos"];
        [adict setValue:[dictionary_ objectForKey:@"id"] forKey:@"id"];
        [adict setValue:[dictionary_ objectForKey:@"nombre"] forKey:@"nombre"];
        [datos_ addObject:adict];
    }
    
    [dictionary setValue:datos_ forKey:@"datos"];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar{
	[_searchBar resignFirstResponder];
    
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar{
    [self copyDictionary];
    [_tableView reloadData];
	[_searchBar resignFirstResponder];
}

- (void)keyboardShown:(NSNotification *)note {
    [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, _tableView.frame.size.height-170 )];
}

- (void)keyboardHidden:(NSNotification *)note {
    [_tableView setFrame:CGRectMake(_tableView.frame.origin.x, _tableView.frame.origin.y, _tableView.frame.size.width, 328 )];
}



@end
