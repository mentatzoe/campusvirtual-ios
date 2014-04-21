//
//  Video.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 11/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize titulo = _titulo, descripcion = _descripcion, fecha = _fecha, partes = _partes, tipo = _tipo, listaPartes = _listaPartes;

-(id) initWithTitulo: (NSString *) tit andDesc: (NSString *) desc andFecha: (NSString *) fe andTipo:(NSString *)t
{
    self = [[Video alloc] init];
    self.titulo = tit;
    self.descripcion = desc;
    self.fecha = fe;
    self.tipo = t;
    self.partes = [[NSMutableArray alloc] init];
    return self;
}

-(void) addParte: (NSString *) parte
{
    //[self.partes addObject:parte];
}

-(void) setPartes:(NSMutableArray *)p{
    _partes = p;
    _listaPartes = [[NSMutableArray alloc]init];
    for (NSMutableDictionary* p in _partes){
        [_listaPartes addObject:(NSString *)[p objectForKey:@"numero"]];
    }
}

@end
