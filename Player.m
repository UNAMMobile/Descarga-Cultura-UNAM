//
//  Player.m
//  Descarga Cultura UNAM
//
//  Created by Genaro Marmolejo on 21/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
//  Descargas
//

#import "Player.h"




@implementation Player

@synthesize player, avplayer, slider, espera;

+ (void) push : (Estados *)estado {
    
    if(stackSongs==nil){
    
        stackSongs = [[NSMutableArray alloc] init];
    
    }
    for(int items=0;items<stackSongs.count;items++){
        if([estado getTitle]==[[stackSongs objectAtIndex:items] getTitle] && [estado getUrlPath]==[[stackSongs objectAtIndex:items] getUrlPath])
            return;
    
    
    }
    [stackSongs addObject:estado];


}

- (IBAction)atras{
    
    [self dismissModalViewControllerAnimated:YES];

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 166/3;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
	return [stackSongs count];
	
}

- (UITableViewCell *)tableView:(UITableView *)aTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"Cell";
    
    
    
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    

    
    //if (cell == nil) {
       UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    //}
     
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,tableView.contentSize.width ,166/3)];
    
    if (indexPath.row % 2 == 0) {
        background.image = [UIImage imageNamed:@"fondo-lista-A.png"];
    }
    else
    {
        background.image = [UIImage imageNamed:@"fondo-lista-B.png"];
    }
    
    
    
    [[cell contentView] addSubview:background];

    
        
    cell.textLabel.backgroundColor=[UIColor clearColor];
    
    cell.textLabel.textColor=[UIColor whiteColor];
    NSRange rango;
    NSString *apen;
    if(([[[stackSongs objectAtIndex:indexPath.row] getTitle]length])<16){
        
        rango = NSMakeRange(0, [[[stackSongs objectAtIndex:indexPath.row] getTitle]length]);
        apen = @"";
        
    } else {
    
        rango = NSMakeRange(0, 13);
        apen = @"...";
    
    }
    cell.textLabel.text = [[[[stackSongs objectAtIndex:indexPath.row] getTitle]substringWithRange:rango] stringByAppendingString:apen];
    
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(153, 17, 60, 20)] ;
    NSString *dur;
    if([[[stackSongs objectAtIndex:indexPath.row] getLength] length]==5){
        dur = [[NSString alloc] initWithString:[NSString stringWithFormat:@"(%@)",[[stackSongs objectAtIndex:indexPath.row] getLength]]];
        
    } else {
        
        dur = [[NSString alloc] initWithString:[NSString stringWithFormat:@"(%@)",[[stackSongs objectAtIndex:indexPath.row] getLength]]];
    
    }
    
    
    label.text=dur;
    label.font = [UIFont systemFontOfSize:15];
    label.textColor=[UIColor lightGrayColor];
    label.backgroundColor=[UIColor clearColor];
    
    
    [[cell contentView] addSubview:label];
    
    ////STOP
    
    UIButton *stop=[UIButton buttonWithType:UIButtonTypeCustom];
    stop.frame= CGRectMake(220, 15, 20, 20);
    
    [stop setImage:[UIImage imageNamed:@"stop-streaming.png"] forState:UIControlStateNormal];
    
    [stop addTarget:self action:@selector(Stop:) forControlEvents:UIControlEventTouchUpInside];
    [stop setTag:indexPath.row];
    
    if ([[stackSongs objectAtIndex:indexPath.row] getPlaying]) {
        [cell.contentView addSubview:stop];
    }
        
    
    ////DOWNLOAD
    UIButton *dl=[UIButton buttonWithType:UIButtonTypeCustom];
    dl.frame= CGRectMake(252, 12, 28, 28);
    [dl setImage:[UIImage imageNamed:@"descarga.png"/*@"descarga.png"*/] forState:UIControlStateNormal];
    
    [dl addTarget:self action:@selector(Dl:) forControlEvents:UIControlEventTouchUpInside];
    [dl setTag:indexPath.row];
    
    if (![[stackSongs objectAtIndex:indexPath.row] getDownloading] && ![[stackSongs objectAtIndex:indexPath.row] getDownloaded]) {
        [cell.contentView addSubview:dl];
    }
        
    
    ////PHONIES
    UIButton *phonies=[UIButton buttonWithType:UIButtonTypeCustom];
    phonies.frame= CGRectMake(215,12, 30, 30);
    [phonies setImage:[UIImage imageNamed:@"escuchar-streaming.png"] forState:UIControlStateNormal];
    
    [phonies addTarget:self action:@selector(Prepare:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [phonies setTag:indexPath.row];
    
    if (![[stackSongs objectAtIndex:indexPath.row] getPlaying]) {
        [cell.contentView addSubview:phonies];
    }
    
    
    ////DOWNLOADING
    
    UIImageView *dling=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"descargando.png"]];
    dling.frame= CGRectMake(252, 12, 30, 30);
    
    [dling setTag:indexPath.row];
    
    if ([[stackSongs objectAtIndex:indexPath.row] getDownloading]) {
        [cell.contentView addSubview:dling];
    }
    
    ////DOWNLOADED
    UIImageView *dled=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"descargado.png"]];
    dled.frame= CGRectMake(252, 12, 30, 30);
    
    [dled setTag:indexPath.row];
    
    if ([[stackSongs objectAtIndex:indexPath.row] getDownloaded]) {
        [cell.contentView addSubview:dled];
    }
    
    ////DELETE
    UIButton *delete=[UIButton buttonWithType:UIButtonTypeCustom];
    delete.frame= CGRectMake(290, 16, 20, 20);
    [delete setImage:[UIImage imageNamed:@"eliminar_lista.png"] forState:UIControlStateNormal];
    [delete addTarget:self action:@selector(Delete:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [delete setTag:indexPath.row];
    
    if (![self checkDownloads]) {
    
        [cell.contentView addSubview:delete];
    
    }
    
    return cell;
    
}

-(IBAction) Delete: (id) sender {
    
    if ([[stackSongs objectAtIndex:[sender tag]] getPlaying]) {
        i=0;
        //[[stackSongs objectAtIndex:[sender tag]] setPlaying:NO];
        [tableView reloadData];
        CMTime tiempo = CMTimeMake(0, 1);
        [self.avplayer seekToTime:tiempo];
        [self.avplayer pause];
        self.avplayer = nil;
        slider.value=0;
        [self eraseAll];
    }
    
    if ([[stackSongs objectAtIndex:[sender tag]] getDownloaded]) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        //[elplist objectForKey:@"Musica"] removeObjectForKey:<#(id)#>
        [[elplist objectForKey:@"Musica"] removeObjectForKey:[[stackSongs objectAtIndex:[sender tag]] getUrlPath]];
        [elplist writeToFile:filePath atomically: YES];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:[[stackSongs objectAtIndex:[sender tag]]getUrlPath] error:NULL];
        [stackSongs removeObjectAtIndex:[sender tag]];
        [tableView reloadData];
        
    } else {
        
        [stackSongs removeObjectAtIndex:[sender tag]];
        [tableView reloadData];
        
    }
    
    
    
    
}

- (BOOL) checkDownloads {
    
    for (int k = 0; k<[stackSongs count]; k++) {
        if([[stackSongs objectAtIndex:k] getDownloading])
            return YES;
    }
    return NO;
}

-(IBAction) Prepare: (id) sender {
    //NSLog(<#NSString *format, ...#>)
    i=0;
    for (int k=0; k<[stackSongs count]; k++) {
        if ([sender tag] == k) {
            [[stackSongs objectAtIndex:k] setPlaying:YES];
            
        } else {
            [[stackSongs objectAtIndex:k] setPlaying:NO];
        }
    }
    [tableView reloadData];
    [pausa setAlpha:1];
    [rw setAlpha:1];
    [fw setAlpha:1];
    [slider setAlpha:1];
    [pausa setEnabled:YES];
    [rw setEnabled:YES];
    [fw setEnabled:YES];
    [slider setEnabled:YES];
    [pausa setImage:[UIImage imageNamed:@"pausa1.png"] forState:UIControlStateNormal];
    
    [NSThread detachNewThreadSelector:@selector(Info:) 
                             toTarget:self 
                           withObject:sender];
    
    [NSThread detachNewThreadSelector:@selector(HiloPrepare:) 
                             toTarget:self 
                           withObject:sender];
    sliderTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateSlider) userInfo:nil repeats:YES];
  
}

- (void) Info: (id) sender {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //NSLog(@"HOLA!!!!: %@", [[stackSongs objectAtIndex:[sender tag]] getImage] );
    autor.topItem.title = [[stackSongs objectAtIndex:[sender tag]] getAuthor];
    titulo.text = [[stackSongs objectAtIndex:[sender tag]] getTitle];
    NSURL *urlImagen = [[NSURL alloc] initWithString:[[stackSongs objectAtIndex:[sender tag]]getImage]];
    [portada setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:urlImagen]]];
    
    switch ([[stackSongs objectAtIndex:[sender tag]] getRaiting]) {
        case 1:
            [rate1 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate2 setImage:nil];
            [rate3 setImage:nil];
            [rate4 setImage:nil];
            [rate5 setImage:nil];
            break;
        case 2:
            [rate1 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate2 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate3 setImage:nil];
            [rate4 setImage:nil];
            [rate5 setImage:nil];
            break;
        case 3:
            [rate1 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate2 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate3 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate4 setImage:nil];
            [rate5 setImage:nil];
            break;
        case 4:
            [rate1 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate2 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate3 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate4 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate5 setImage:nil];
            break;
        case 5:
            [rate1 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate2 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate3 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate4 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            [rate5 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
            break;
        default:
            break;
    }
    
    [pool release];
    
}

- (void) HiloPrepare: (id) sender {
    
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    //[espera setAlpha:1];
    if(self.avplayer!=nil){
        CMTime tiempo = CMTimeMake(0, 1);
        [self.avplayer seekToTime:tiempo];
        [self.avplayer pause];
    }
    
    self.avplayer = nil;
    
    NSString *urlstr=[[NSString alloc] initWithString:[[stackSongs objectAtIndex:[sender tag]] getUrlPath]];
    //NSString *urlstr=[[NSString alloc] initWithString:[[stackSongs objectAtIndex:[sender tag]] getUrlPath]];
    NSURL *url;
    //NSLog(@"A repro: %@",urlstr);
    if ([[stackSongs objectAtIndex:[sender tag]] getDownloaded]) {
        url = [[[NSURL alloc] initFileURLWithPath:urlstr]autorelease];
        
    } else {
        url=[NSURL URLWithString:urlstr];
    }
    
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithURL:url];
    self.avplayer = [[AVPlayer playerWithPlayerItem:playerItem] retain];
    [self play];
    
    
    [pool release];
    
}

- (IBAction) Dl: (id) sender {
    
    [espera setAlpha:1];
    
    [[stackSongs objectAtIndex:[sender tag]] setDownloading:YES];
    
    [tableView reloadData];
    
    [NSThread detachNewThreadSelector:@selector(HiloDL:) 
                             toTarget:self 
                           withObject:sender];
       
    
}

- (void) HiloDL: (id) sender {
    

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    //[sender setImage:[UIImage imageNamed:@"descargando.png"] forState:UIControlStateNormal];
    NSURL *url = [[NSURL alloc] initWithString:[[stackSongs objectAtIndex:[sender tag]] getUrlPath]];
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    //NSLog(@"%@",docDir);
	
	NSString *cadenaSinTildes = [[[stackSongs objectAtIndex:[sender tag]] getTitle] stringByFoldingWithOptions: 
                                 NSDiacriticInsensitiveSearch locale: [NSLocale currentLocale]];
	NSString *mp3FilePath = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@.mp3",docDir, [cadenaSinTildes stringByReplacingOccurrencesOfString:@" " withString:@"_"]]];
    //NSString *mp3FilePath =[[NSString alloc] initWithString:[docDir stringByAppendingFormat:[NSString stringWithFormat:@"%@.mp3",[[[stackSongs objectAtIndex:[sender tag]] getTitle] stringByReplacingOccurrencesOfString:@" " withString:@"_"]]]];
    
    //NSLog(@"URL: %@",mp3FilePath);
    NSData *data = [NSData dataWithData:[NSData dataWithContentsOfURL:url]];
    
	[data writeToFile:mp3FilePath atomically:YES];
    
    
    
    
    //[sender setImage:[UIImage imageNamed:@"descargado.png"] forState:UIControlStateNormal];
    [[stackSongs objectAtIndex:[sender tag]] setDownloading:NO];
    [[stackSongs objectAtIndex:[sender tag]] setDownloaded:YES];
    [[stackSongs objectAtIndex:[sender tag]] changeURL:mp3FilePath];
    
    NSMutableArray *arraydl = [[NSMutableArray alloc] init];
    [arraydl addObject:[[stackSongs objectAtIndex:[sender tag]] getTitle]];
    [arraydl addObject:[[stackSongs objectAtIndex:[sender tag]] getImage]];
    //[arraydl addObject:[[stackSongs objectAtIndex:[sender tag]] getRaiting]];
    [arraydl addObject:[[stackSongs objectAtIndex:[sender tag]] getLength]];
    [arraydl addObject:[[stackSongs objectAtIndex:[sender tag]] getAuthor]];
     
    [[elplist objectForKey:@"Musica"] setObject:arraydl forKey:[[stackSongs objectAtIndex:[sender tag]] getUrlPath]];
    //NSLog(@"MIS DESCARGAS EN DICCIONARIO: %@",descargas);
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
        
    [elplist writeToFile:filePath atomically: YES];
    
    [espera setAlpha:0];
    [tableView reloadData];
    //[espera setAlpha:0];
    [pool release];

}

- (IBAction) Stop: (id) sender {
    [slider setValue:0];
    i=0;
    [pausa setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self eraseAll];
    [[stackSongs objectAtIndex:[sender tag]] setPlaying:NO];
    [tableView reloadData];
    CMTime tiempo = CMTimeMake(0, 1);
    [self.avplayer seekToTime:tiempo];
    [self.avplayer pause];
    self.avplayer = nil;
    
}

- (IBAction) stop {
    [pausa setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
    [self eraseAll];
    CMTime tiempo = CMTimeMake(0, 1);
    [self.avplayer seekToTime:tiempo];
    [self.avplayer pause];
    
    
}


- (IBAction) play {
    
    
    if (self.avplayer==nil) {
        return;
    }
    CMTime duration = self.avplayer.currentItem.asset.duration;
    float seconds = CMTimeGetSeconds(duration);
    //NSLog(@"duration: %.2f", seconds);
    slider.maximumValue = seconds;
    
    if (i==0) {
        i++;
        [pausa setImage:[UIImage imageNamed:@"pausa1.png"] forState:UIControlStateNormal];
        [self.avplayer play];
    }
    else
        if (i==1) {
            i--;
            [pausa setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
            [self.avplayer pause];
        }
    
    
    self.avplayer.actionAtItemEnd = AVPlayerActionAtItemEndNone; 
	

}

- (void) updateSlider {
    if (self.avplayer == nil) {
        return;
    }
    //NSLog(@"ENTRO!!!!");
	CMTime duration = avplayer.currentTime;
    float seconds = CMTimeGetSeconds(duration);
    //NSLog(@"duration: %.2f", seconds);
    slider.value = seconds;
	//slider.value = slider.value+1;
	
	
}

- (IBAction) sliderChanged : (UISlider *)sender {

	[self.avplayer pause];
	//[self.player setCurrentTime:slider.value];
	//[self.player prepareToPlay];
	//[self.player play];*/
    CMTime tiempo = CMTimeMakeWithSeconds(slider.value, 1);
    [self.avplayer play];
    [self.avplayer seekToTime:tiempo];
    

}

- (IBAction) re {

    CMTime tiempo = CMTimeMakeWithSeconds(15, 1);
    CMTime duration = avplayer.currentTime;
    float seconds = CMTimeGetSeconds(duration);
    float seconds1 = CMTimeGetSeconds(tiempo);
    float x=seconds-seconds1;
    CMTime tiempoFinal = CMTimeMakeWithSeconds(x, 1);
    [self.avplayer seekToTime:tiempoFinal];

}

- (IBAction) fo {
    
    CMTime tiempo = CMTimeMakeWithSeconds(15, 1);
    CMTime duration = avplayer.currentTime;
    float seconds = CMTimeGetSeconds(duration);
    float seconds1 = CMTimeGetSeconds(tiempo);
    float x=seconds+seconds1;
    CMTime tiempoFinal = CMTimeMakeWithSeconds(x, 1);
    [self.avplayer seekToTime:tiempoFinal];
    
}

- (IBAction) download {
   
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
   // NSLog(@"%@",docDir);
	
	
	NSString *mp3FilePath = [NSString stringWithFormat:@"%@/nyan.mp3",docDir];
	
    NSURL *url = [[NSURL alloc] initWithString:@"http://nyanit.com/audio/nyanlooped.mp3"];
    NSData *data = [NSData dataWithData:[NSData dataWithContentsOfURL:url]];
	[data writeToFile:mp3FilePath atomically:YES];
	
	//[url release];
    //[data release];
    
    

}

-(IBAction) show {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSFileManager *file = [NSFileManager defaultManager];
    //NSMutableArray *arreglo= [[NSMutableArray alloc] init];
    NSArray *arreglo = [[NSArray alloc] initWithArray:[file contentsOfDirectoryAtPath:documentsDirectoryPath error:nil]];
    //NSLog(@"%@",arreglo);


}

/*- (void) audioPlayerDidFinishPlaying : (AVPlayer *)player successfully : (BOOL)flag {
	
	if (flag) {
		[sliderTimer invalidate];
	}
	
}*/





- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Info" ofType:@"plist"];
    
    
    elplist = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    descargas = [[NSMutableDictionary alloc] initWithDictionary:[elplist objectForKey:@"Musica"]];
    
    //NSLog(@"MIS DESCARGAS EN DICCIONARIO: %@",descargas);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSFileManager *file = [NSFileManager defaultManager];
    
    //NSMutableArray *arreglo= [[NSMutableArray alloc] init];
    
    NSMutableArray *arreglo = [[NSMutableArray alloc] initWithArray:[file contentsOfDirectoryAtPath:documentsDirectoryPath error:nil]];
    //NSLog(@"MUAJAJAJAJJAAJJAAJAJJAJAJAJJAJAJAAJJAAAJAJASASFASGDAGADG? %@",arreglo);
    NSString *docDir = [[NSString alloc] initWithString:[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]];
    
    for (int des=0; des<arreglo.count; des++) {
        NSString *pa = [[NSString alloc] initWithString:[NSString stringWithFormat:@"%@/%@",docDir, [arreglo objectAtIndex:des]]];
        Estados *mystate = [[Estados alloc] init];
        [mystate initWithDefaultValues];
        [mystate initWithTitle:[[[elplist objectForKey:@"Musica"] objectForKey:pa] objectAtIndex:0]image:[[[elplist objectForKey:@"Musica"] objectForKey: pa] objectAtIndex:1] urlPath:pa raiting:5 length:[[[elplist objectForKey:@"Musica"] objectForKey: pa] objectAtIndex:2] author:[[[elplist objectForKey:@"Musica"] objectForKey: pa] objectAtIndex:3]];
        [mystate changeURL:pa];
        [mystate setDownloaded:YES];
        if(stackSongs==nil){
            
            stackSongs = [[NSMutableArray alloc] init];
            
        }
        
        [stackSongs addObject:mystate];
        
    }
    
    
    
      
        
    
    //NSLog(@"STACK DE CANCIONES: %@", [[stackSongs objectAtIndex:0] getLength]);
    
    
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    
    
    tableView.backgroundColor=[UIColor clearColor];
    
    
    
	
    i=0;
    j=0;
    [self eraseAll];
    [espera setAlpha:0];
    //[self.player prepareToPlay];
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void) viewDidAppear:(BOOL)animated {
    
    if(stackSongs == nil)
        stackSongs = [[NSMutableArray alloc] init];
    //NSLog(@"=======================================");
    for (int k = 0; k<stackSongs.count; k++) {
        //NSLog(@"HEY HEY HEY : %@",[[stackSongs objectAtIndex:k] getTitle]);
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSFileManager *file = [NSFileManager defaultManager];
    
    //NSMutableArray *arreglo= [[NSMutableArray alloc] init];
    if(stackSongs==nil){
        
        stackSongs = [[NSMutableArray alloc] init];
        
    }
    
    
    
    NSMutableArray *arreglo = [[NSMutableArray alloc] initWithArray:[file contentsOfDirectoryAtPath:documentsDirectoryPath error:nil]];
    NSMutableIndexSet *indices = [[NSMutableIndexSet alloc] init];
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    
    ////////////////////////////////////////////////////////////////////////////////////
    
    if(arreglo.count == 0){
        
        for (int el=0; el<stackSongs.count; el++) {
            if ([[stackSongs objectAtIndex:el] getDownloaded]) {
                [indices addIndex:el];
            }
        }
        descargas = [[NSMutableDictionary alloc] init];
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"music" ofType:@"plist"];
        [descargas writeToFile:filePath atomically:YES];
        [stackSongs removeObjectsAtIndexes:indices];
   
    }
    
    [tableView reloadData];
    

}

- (void) eraseAll {
    
    autor.topItem.title = @"";
    titulo.text = @"Descarga Cultura UNAM";
    [portada setImage:[UIImage imageNamed:@"Cultura-UNAM-38.png"]];
    [pausa setAlpha:.7];
    [rw setAlpha:.7];
    [fw setAlpha:.7];
    [slider setAlpha:.7];
    [pausa setEnabled:NO];
    [rw setEnabled:NO];
    [fw setEnabled:NO];
    [slider setEnabled:NO];
    [rate1 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
    [rate2 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
    [rate3 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
    [rate4 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
    [rate5 setImage:[UIImage imageNamed:@"Cultura-UNAM-Estrella.png"]];
    
}

- (void)viewDidUnload
{
	//NSString *path = [[NSString alloc] initWithContentsOfURL:@""];
	//NSURL *file = [[NSURL alloc] initFileURLWithPath:path];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    //if it is a remote control event handle it correctly
    if (event.type == UIEventTypeRemoteControl) {
        if (event.subtype == UIEventSubtypeRemoteControlTogglePlayPause) {
            [self play];
        } else if (event.subtype == UIEventSubtypeRemoteControlPreviousTrack) {
            [self re];
        }   else if (event.subtype == UIEventSubtypeRemoteControlNextTrack) {
            [self fo];
        }
    }
}

- (IBAction) goBack: (id) sender {
    
    //[self removeFromParentViewController];
    /*switch ([sender tag]) {
        case 1:
            [self sp];
            
            break;
        case 2:
            [self co];
            break;
        case 3:
            [self cm];
            break;
        case 4:
            [self am];
            break;
        case 5:
            [self tm];
            break;
            
        default:
            break;
    }*/
    //[self removeFromParentViewController];
    [self dismissModalViewControllerAnimated:YES];
    
   
    
    
}

@end
