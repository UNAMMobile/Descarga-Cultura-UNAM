//
//  Estados.h
//  Descarga Cultura UNAM
//
//  Created by Genaro Marmolejo on 02/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Estados : NSObject {
    
    BOOL repro;
    BOOL wait;
    BOOL descargando;
    BOOL descargado;
    
    NSString *urlPath;
    NSString *image;
    int raiting;
    NSString *title;
    NSString *duracion;
    NSString *author;

}



- (void) initWithDefaultValues;
- (void) initWithTitle: (NSString *)titulo image: (NSString *)imagen urlPath: (NSString *)
    url raiting: (int)puntaje length: (NSString *)tiempo author: (NSString *) autor;

- (void) setPlaying: (BOOL)playing;
- (void) setWaiting: (BOOL)waiting;
- (void) setDownloading: (BOOL)downloading;
- (void) setDownloaded: (BOOL)downloaded;
- (void) changeURL:(NSString *)miURL;

- (BOOL) getPlaying;
- (BOOL) getWaiting;
- (BOOL) getDownloading;
- (BOOL) getDownloaded;

- (NSString *) getUrlPath;
- (NSString *) getImage;
- (int) getRaiting;
- (NSString *) getTitle;
- (NSString *) getLength;
- (NSString *) getAuthor;



@end
