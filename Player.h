//
//  Player.h
//  Descarga Cultura UNAM
//
//  Created by Genaro Marmolejo on 21/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "SuperViewController.h"
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVPlayer.h>
#import <AVFoundation/AVPlayerItem.h>
#import <AVFoundation/AVAsset.h>
#import <CoreMedia/CoreMedia.h>
#import "Estados.h"

@class SuperViewController;
@class AVAudioPlayer;
@class AVPlayer;

static NSMutableArray *stackSongs;

@interface Player : SuperViewController <UITableViewDelegate, UITableViewDataSource, AVAudioPlayerDelegate, UIActionSheetDelegate>{
    AVAudioPlayer *player;
    AVPlayer *avplayer;
	IBOutlet UISlider *slider;
	IBOutlet NSTimer *sliderTimer;
	IBOutlet UITableView *tableView;
	IBOutlet UILabel *titulo;
	IBOutlet UIImageView *portada;
	IBOutlet UIImageView *rate1;
    IBOutlet UIImageView *rate2;
    IBOutlet UIImageView *rate3;
    IBOutlet UIImageView *rate4;
    IBOutlet UIImageView *rate5;
	IBOutlet UINavigationBar *autor;
    IBOutlet UIButton *pausa;
    IBOutlet UIButton *rw;
    IBOutlet UIButton *fw;
    IBOutlet UIActivityIndicatorView *espera;
    //NSMutableArray *stackSongs;
    int i;
    int j;
    NSMutableDictionary *descargas;
    NSMutableDictionary *elplist;
    
    
    
    
}



- (IBAction) play;
- (IBAction) re;
- (IBAction) fo;
- (IBAction) stop;
- (IBAction) sliderChanged : (UISlider *)sender;
- (IBAction) download;
- (IBAction) show;
- (IBAction) atras;
- (IBAction) goBack: (id) sender;

- (void) eraseAll;

- (BOOL) checkDownloads;



+ (void) push : (Estados *)estado;

@property (nonatomic, retain) AVAudioPlayer *player;
@property (nonatomic, retain) UISlider *slider;
@property (nonatomic, retain) AVPlayer *avplayer;
@property (nonatomic, retain) UIActivityIndicatorView *espera;



@end
