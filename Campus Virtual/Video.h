//
//  Video.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 11/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Video : NSObject
    @property (nonatomic, strong) NSString *titulo;
    @property (nonatomic, strong) NSString *descripcion;
    @property (nonatomic, strong) NSString *fecha;
    @property (nonatomic, strong) NSMutableArray *partes;
    @property (nonatomic, strong) NSString *tipo;
    @property (nonatomic, strong) NSMutableArray *listaPartes;

-(id) initWithTitulo: (NSString *) tit andDesc: (NSString *) desc andFecha: (NSString *) fe andTipo: (NSString *) t;
-(void) addParte: (NSString *) parte;

@end
