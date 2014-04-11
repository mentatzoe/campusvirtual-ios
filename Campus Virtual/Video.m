//
//  Video.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 11/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "Video.h"

@implementation Video

@synthesize titulo = _titulo, descripcion = _descripcion, fecha = _fecha, partes = _partes, tipo = _tipo;

-(id) initWithTitulo: (NSString *) tit andDesc: (NSString *) desc andFecha: (NSDate *) fe andTipo:(int)t
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
    [self.partes addObject:parte];
}

@end
