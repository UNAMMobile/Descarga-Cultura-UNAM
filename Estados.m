//
//  Estados.m
//  Descarga Cultura UNAM
//
//  Created by Genaro Marmolejo on 02/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Estados.h"

@implementation Estados

- (void) initWithDefaultValues {
    
    repro = NO;
    wait = YES;
    descargando = NO;
    descargado = NO;
    
}

- (void) initWithTitle: (NSString *)titulo image: (NSString *)imagen urlPath: (NSString *)
        url raiting: (int)puntaje length: (NSString *)tiempo author:(NSString *)autor{
    
    title = titulo;
    image = imagen;
    urlPath = url;
    raiting = puntaje;
    duracion = tiempo;
    author = autor;
    
}

- (void) setPlaying:(BOOL)playing {
    
    repro = playing;
    
}

- (void) setWaiting:(BOOL)waiting {
    
    wait = waiting;
    
}

- (void) setDownloading:(BOOL)downloading {
    
    descargando = downloading;
    
}

- (void) setDownloaded:(BOOL)downloaded {
    
    descargado = downloaded;
    
}

- (void) changeURL:(NSString *)miURL {
    
    urlPath = miURL;
    
}

- (BOOL) getPlaying {
    
    return repro;
    
}

- (BOOL) getWaiting {
    
    return wait;
    
}

- (BOOL) getDownloading {
    
    return descargando;
    
}

- (BOOL) getDownloaded {
    
    return descargado;
    
}

- (NSString *) getUrlPath {
    
    return urlPath;
    
}

- (NSString *) getImage {
    
    return image;
    
}

- (int) getRaiting {
    
    return raiting;
    
}

- (NSString *) getTitle {
    
    return title;
    
}

- (NSString *) getLength {
    
    return duracion;
    
}

- (NSString *) getAuthor {
    
    return author;
    
}

@end
