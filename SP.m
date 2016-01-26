//
//  SP.m
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
 Construye la vista con las categorias y las imágenes para cada contenido.
 
 
 Salida: 
 Al dar click en un elemento nos lleva a la descripción del mismo
 Al dar click en los botones inferiores nos lleva a la vista correcpondiente.
 
 
 Títulos filtrados por los 9 mas de 3 categorias
 Novedades
 Recomendaciones
 Favoritos
 
 */

#import "SP.h"
#import "TI.h"
#import "StandardInputTableViewItem.h"
#import "SBJSON.h"
#import <Foundation/NSException.h>
#import "UIImageString.h"

#define IMAGEURL @"http://www.descargacultura.unam.mx/images/mp3Icons/"



@implementation SP

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle



- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
       
    scrollable = true;
    numberofbuttonsperrow = 3;
    buttonheight = /*80*/ 70;
    yspacebetweenbuttons = /*15*/ 8;
    
    ///
    labelx= 15 ;
    labely = 10;
    labelheight = 25;
    
    tableViewOutlet.showsHorizontalScrollIndicator = NO;
    
    [activityIndicator startAnimating];
    
    [NSThread detachNewThreadSelector:@selector(parse) toTarget:self withObject:nil];

    
}

-(void)parse{
    //CODIGO DE PRUEBA YES
    //if(    //[self reachability])
    //HARD CODE
    
    @try 
    {
        
        
        
   

        
        
        standardinputtableviewarray = [[NSMutableArray alloc] init];
        
        ////////////////////////////////////////////////////////
        //////////////////FAVORITOS/////////////////////////////
        ////////////////////////////////////////////////////////
        
        StandardInputTableViewItem *siftitem = [[StandardInputTableViewItem alloc] init];
        
        siftitem.imagedictionary = [[NSMutableDictionary alloc] init];
        
        siftitem.stringdictionary =[[NSMutableDictionary alloc] init];
        
        [siftitem.stringdictionary setObject:@"Novedades" forKey:@"title"];
        
        
        // LA PARTE DEL PASER
        
        
        
        SBJSON *parser = [[SBJSON alloc] init];
        
        
        
        
        NSString *string = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:/*@"http://132.248.204.131:8080/podcast/service/top?tipo=fav"*/@"http://www.unam360.com/dcu/service/top?tipo=nov"] encoding:NSISOLatin1StringEncoding error:nil];
        
        
     
        
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
        
        ////////////////////////////////////////////////////////
        //////////////////RECOMENDADOS//////////////////////////
        ////////////////////////////////////////////////////////
        
        StandardInputTableViewItem *siftitem1 = [[StandardInputTableViewItem alloc] init];
        
        siftitem1.imagedictionary = [[NSMutableDictionary alloc] init];
        
        siftitem1.stringdictionary =[[NSMutableDictionary alloc] init];
        
        [siftitem1.stringdictionary setObject:@"Recomendaciones" forKey:@"title"];
        
        // LA PARTE DEL PASER
        
        SBJSON *parser1 = [[SBJSON alloc] init];
        
        NSString *string1 = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.unam360.com/dcu/service/top?tipo=reco"] encoding:NSISOLatin1StringEncoding error:nil];
        
        NSMutableDictionary *arra1 = [parser1 objectWithString:string1 error:nil];
        
        NSMutableArray *temp1 = (NSMutableArray *) [arra1 objectForKey:@"datos"];
        
        //NSLog(@"temp: %@",temp );
        
        for(int i=0 ; i<[temp1 count]-1;i++){
            
            //Usar herencia para tagear las imagenes.
            
            UIImageString *imagestring1 = [[UIImageString alloc] init];
            
            imagestring1.image = [UIImage imageNamed:@"Cultura-UNAM-38.png"]; 
            
            imagestring1.string = [[NSString alloc] initWithString:[[temp1 objectAtIndex:i] objectForKey:@"id"]];
            
            if (imagestring1.string != nil) 
                //NSLog(@"id1 : %@",imagestring1.string);
            
            
            [siftitem1.imagedictionary setObject:imagestring1 forKey:[IMAGEURL stringByAppendingString:[[temp1 objectAtIndex:i] objectForKey:@"image"]]];
            
            
            
        }
        
        [standardinputtableviewarray addObject:siftitem1];
        
        
        ////////////////////////////////////////////////////////
        //////////////////NOVEDADES/////////////////////////////
        ////////////////////////////////////////////////////////
        
        StandardInputTableViewItem *siftitem2 = [[StandardInputTableViewItem alloc] init];
        
        siftitem2.imagedictionary = [[NSMutableDictionary alloc] init];
        
        siftitem2.stringdictionary =[[NSMutableDictionary alloc] init];
        
        [siftitem2.stringdictionary setObject:@"Favoritos" forKey:@"title"];
        
        // LA PARTE DEL PASER
        
        SBJSON *parser2 = [[SBJSON alloc] init];
        
        NSString *string2 = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.unam360.com/dcu/service/top?tipo=fav"] encoding:NSISOLatin1StringEncoding error:nil];
        
        NSMutableDictionary *arra2 = [parser2 objectWithString:string2 error:nil];
        
        NSMutableArray *temp2 = (NSMutableArray *) [arra2 objectForKey:@"datos"];
        
        //NSLog(@"temp: %@",temp );
        
        for(int i=0 ; i<[temp2 count]-1;i++){
            
            //Usar herencia para tagear las imagenes.
            
            UIImageString *imagestring2 = [[UIImageString alloc] init];
            
            imagestring2.image = [UIImage imageNamed:@"Cultura-UNAM-38.png"]; 
            
            imagestring2.string = [[NSString alloc] initWithString:[[temp2 objectAtIndex:i] objectForKey:@"id"]];
            
            if (imagestring2.string != nil) 
                //NSLog(@"id1 : %@",imagestring2.string);
            
            
            [siftitem2.imagedictionary setObject:imagestring2 forKey:[IMAGEURL stringByAppendingString:[[temp2 objectAtIndex:i] objectForKey:@"image"]]];
            
            
            
        }
        
        [standardinputtableviewarray addObject:siftitem2];
        
        ////////////////////////////////////////////////////////
        //////////////////ALEATORIO/////////////////////////////
        ////////////////////////////////////////////////////////
        
        StandardInputTableViewItem *siftitem3 = [[StandardInputTableViewItem alloc] init];
        
        siftitem3.imagedictionary = [[NSMutableDictionary alloc] init];
        
        siftitem3.stringdictionary =[[NSMutableDictionary alloc] init];
        
        [siftitem3.stringdictionary setObject:@"Y muchos más..." forKey:@"title"];
        
        // LA PARTE DEL PASER
        
        SBJSON *parser3 = [[SBJSON alloc] init];
        
        NSString *string3 = [[NSString alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://www.unam360.com/dcu/service/top?tipo=muchos"] encoding:NSISOLatin1StringEncoding error:nil];
        
        NSMutableDictionary *arra3 = [parser3 objectWithString:string1 error:nil];
        
        NSMutableArray *temp3 = (NSMutableArray *) [arra3 objectForKey:@"datos"];
        
        //NSLog(@"temp: %@",temp );
        
        for(int i=0 ; i<[temp3 count]-1;i++){
            
            //Usar herencia para tagear las imagenes.
            
            UIImageString *imagestring3 = [[UIImageString alloc] init];
            
            imagestring3.image = [UIImage imageNamed:@"Cultura-UNAM-38.png"]; 
            
            imagestring3.string = [[NSString alloc] initWithString:[[temp3 objectAtIndex:i] objectForKey:@"id"]];
            
            if (imagestring3.string != nil) 
                //NSLog(@"id1 : %@",imagestring1.string);
                
                
                [siftitem3.imagedictionary setObject:imagestring3 forKey:[IMAGEURL stringByAppendingString:[[temp3 objectAtIndex:i] objectForKey:@"image"]]];
            
            
            
        }
        
        [standardinputtableviewarray addObject:siftitem3];
        

        
    }
    @catch (NSException *exception) {
        [self reachability];
    }
    
    [tableViewOutlet reloadData];
    
    [activityIndicator setHidesWhenStopped:YES];
    [activityIndicator stopAnimating];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TableViewDataSource Methods

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Creacion de celda +
    
    static NSString *kvcPreviewRowIdentifier = @"Cell";
    UITableViewCell *cell;
    
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kvcPreviewRowIdentifier] autorelease];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //Variables
    
    //// PRUEBA
    
    numberfbuttonsinrow = 0;
    buttonwidth = buttonheight;
    initialx = (tableView.contentSize.width - (buttonwidth * numberofbuttonsperrow))/(numberofbuttonsperrow + 1 );
    initialy = labelheight + labely + yspacebetweenbuttons;
    x=initialx;
    y=initialy;
    xspacebetweenbuttons = (tableView.contentSize.width - (buttonwidth * numberofbuttonsperrow))/(numberofbuttonsperrow + 1 );
    labelwidth = tableView.contentSize.width;
    
    @try {
        
        //Current Item
        
        StandardInputTableViewItem *currentitem = [standardinputtableviewarray objectAtIndex:indexPath.row];
        
        //Background
        UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, tableView.contentSize.width,[self tableView:tableView heightForRowAtIndexPath:indexPath])];
        if(indexPath.row%2==0){
            [background setImage:[UIImage imageNamed:@"Untitled-1_03 a.png"]];
        }
        else{
            [background setImage:[UIImage imageNamed:@"Untitled-1_02 a.png"]];
        }
        [[cell contentView] addSubview:background];
        
        //Label
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelx, labely, labelwidth, labelheight)] ; 
        label.text = [currentitem.stringdictionary objectForKey:@"title"];
        label.backgroundColor = [UIColor clearColor];;
        [[cell contentView] addSubview:label];
        
        //ScrollView
        
        UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, tableView.contentSize.width, buttonheight+initialy)];
        scroll.contentSize = CGSizeMake( [currentitem.imagedictionary count] * (buttonwidth + xspacebetweenbuttons) + xspacebetweenbuttons      , buttonheight + initialy);
        scroll.showsHorizontalScrollIndicator = NO ;
        [scroll setContentOffset:CGPointMake(20, 0)];
        //Si se utiliza el scroll
        if (scrollable) {
            [[cell contentView] addSubview:scroll];
        }
        
        //Botones
        
        for (NSString *key in currentitem.imagedictionary) {
            
            numberfbuttonsinrow++;
            
            UIButton *button = [[UIButton alloc] init];
            
            /// Posicionar botones
            
            if ( numberfbuttonsinrow % (numberofbuttonsperrow  + 1) == 0 && !scrollable)
            {   
                x = initialx;
                
                y = y + buttonheight + yspacebetweenbuttons;
                
                button.frame = CGRectMake(x, y, buttonwidth, buttonheight);
                
                x = x + buttonwidth + xspacebetweenbuttons;
                
                numberfbuttonsinrow = 1;
                
            }
            else{
                
                button.frame = CGRectMake(x, y, buttonwidth, buttonheight);
                
                x = x + buttonwidth + xspacebetweenbuttons;
                
            }
            
            /// Primero posicionar imagen que no proviene de internet
            
            UIImageString *auximagestring = [currentitem.imagedictionary objectForKey:key];
            
            [button setImage:auximagestring.image forState:UIControlStateNormal];
            
            // Añadir Tag y Accion al boton.
            
            button.tag = [auximagestring.string intValue];
            
            [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            /// Lanzar hilo para obtener imagen desde internet
            
            NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
            
            [dictionary setObject:key forKey:@"key"];
            
            [dictionary setObject:button forKey:@"button"];
            
            [NSThread detachNewThreadSelector:@selector(setImageOnButton:) 
                                     toTarget:self 
                                   withObject:dictionary];
            
            
            if (scrollable) {
                [scroll addSubview:button];
            }
            else{
                [[cell contentView] addSubview:button];
            }
            
            
        }
        
    }
    @catch (NSException *exception) {
        [tableView reloadData];
    }
    
    return cell;
    
} 

-(void)buttonAction:(UIButton *)button{
    //NSLog(@"Button tag = %d", button.tag);
    
    TI *nextPage = [[TI alloc] initWithNibName:@"TI" bundle:nil idNumber:[NSString stringWithFormat:@"%d", button.tag]];
    nextPage.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self.view addSubview:nextPage.view];
    [self presentModalViewController:nextPage animated:YES];
    
    return;
}

- (void)setImageOnButton:(NSMutableDictionary *)dictionary {
	
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    @try {
        
        NSString *key = [dictionary objectForKey:@"key"];
        
        UIButton *button =[dictionary objectForKey:@"button"];
        
        UIImage *image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:key]]];
        
        [button setImage:image forState:UIControlStateNormal];
        
    }
    
    @catch (NSException *exception) {
        
        UIButton *button =[dictionary objectForKey:@"button"];
        
        UIImage *image = [UIImage imageNamed:@"star.png"];
        
        [button setImage:image forState:UIControlStateNormal];
        
    }
	
    [pool release];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [standardinputtableviewarray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    @try {
        if (!scrollable) {
            
            //NSLog(@"INDEX PATH.row %@", indexPath.row);
            StandardInputTableViewItem *currentitem = [standardinputtableviewarray objectAtIndex:indexPath.row];
            [currentitem.imagedictionary count];
            
            int height = labelheight+labely; 
            
            if ([currentitem.imagedictionary count]%numberofbuttonsperrow == 0) {
                
                height = height + [currentitem.imagedictionary count]/numberofbuttonsperrow * (buttonheight + yspacebetweenbuttons);
                return height + yspacebetweenbuttons;
                
            }
            
            height = height +  (round([currentitem.imagedictionary count]/numberofbuttonsperrow)+1) * (buttonheight + yspacebetweenbuttons);
            return height + yspacebetweenbuttons;
            
        }
        
        return buttonheight + labelheight + labely + yspacebetweenbuttons * 2;
    }
    @catch (NSException *exception) {
        return 0;
    }
  
}

- (IBAction)reproductor {
    
    if (rep == nil) {
        rep = [[[Player alloc] initWithNibName:@"Player" bundle:nil] retain];
        rep.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
    [self.view addSubview:rep.view];
    [self presentModalViewController:rep animated:YES];
    
}

@end
