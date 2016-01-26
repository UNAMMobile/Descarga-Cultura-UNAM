//
//  LC.m
//  Esqueleto DCU
//
//  Created by julio.guzman on 18/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

//Vista Tipo Grid a 3 Columnas

/*
 Descripción/Datos que utiliza
 
 Entrada:
 Se alimenta de los datos obtenidos por un servicio web
 
 
 Acción:
 Construye la vista con  las imágenes para cada subcategoria en un grid a 3 columans por N filas
 
 Salida: 
 Al dar click en un elemento nos lleva a la descripción del mismo
 Al dar click en los botones inferiores nos lleva a la vista correcpondiente.
 */

#import "LC.h"
#import "StandardInputTableViewItem.h"
#import "SBJSON.h"
#import "UIImageString.h"

#define IMAGEURL @"http://www.descargacultura.unam.mx/images/mp3Icons/"

@implementation LC

@synthesize ID = _ID;
@synthesize categoryName = _categoryName;
@synthesize label1;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil idNumber:(NSString *)idNumber categoryName:(NSString *)name
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ID = idNumber;
        _categoryName = name;
        [categoryName retain];
        [_ID retain];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    scrollable = false;
    numberofbuttonsperrow = 3;
    buttonheight = 80;
    yspacebetweenbuttons = 15;
    
    ///
    labelx= 15 ;
    labely = 10;
    labelheight = 25;
    
    tableViewOutlet.showsHorizontalScrollIndicator = NO;
    
    [activityIndicator startAnimating];
    
    [NSThread detachNewThreadSelector:@selector(parse) toTarget:self withObject:nil];
    
}

//Aun no funciona :/
-(void)parse{
    //CODIGO DE PRUEBA YES
    //if(    [self reachability])
    //HARD CODE
    @try 
    {
        
        standardinputtableviewarray = [[NSMutableArray alloc] init];
        
        StandardInputTableViewItem *siftitem = [[StandardInputTableViewItem alloc] init];
        
        siftitem.imagedictionary = [[NSMutableDictionary alloc] init];
        
        siftitem.stringdictionary =[[NSMutableDictionary alloc] init];
        
        [label1 setText:_categoryName];
        
        //[siftitem.stringdictionary setObject:_categoryName forKey:@"title"];
        
        // LA PARTE DEL PASER
        
        SBJSON *parser = [[SBJSON alloc] init];

        //NSLog(@"_ID : : %@", _ID);
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.unam360.com/dcu/service/lista?tipo=categorias&id=%@", _ID]] encoding:NSISOLatin1StringEncoding error:nil];
    
        //NSLog(@"string ::%@",string);
        
        NSMutableDictionary *arra = [parser objectWithString:string error:nil];
        
        NSMutableArray *temp = (NSMutableArray *) [arra objectForKey:@"datos"];
        
        //NSLog(@"temp: %@",temp );
        
        for(int i=0 ; i<[temp count]-1;i++){
            
            //Usar herencia para tagear las imagenes.
            
            UIImageString *imagestring = [[UIImageString alloc] init];
            
            imagestring.image = [UIImage imageNamed:@"Cultura-UNAM-38.png"]; 
            
            imagestring.string = [[NSString alloc] initWithString:[[temp objectAtIndex:i] objectForKey:@"id"]];
            
            if (imagestring.string != nil) 
                //NSLog(@"id : %@",imagestring.string);
            
            [siftitem.imagedictionary setObject:imagestring forKey:[IMAGEURL stringByAppendingString:[[temp objectAtIndex:i] objectForKey:@"image"]]];
            
        }
        
        [standardinputtableviewarray addObject:siftitem];
        
    }
    @catch (NSException *exception) {
         //[self reachability];
    }
    
    [tableViewOutlet reloadData];
    
    [activityIndicator setHidesWhenStopped:YES];
    [activityIndicator stopAnimating];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //NSLog(@"standardinputtableviewarray %@", standardinputtableviewarray);
    return 1;
}


@end
