//
//  Alerta.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 10/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Alerta : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic) int timeFetched;

-(id) initWithName: (NSString *) name
           andType: (NSString *) type
           andTime: (int) time;

@end
