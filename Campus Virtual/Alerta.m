//
//  Alerta.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 10/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "Alerta.h"

@implementation Alerta

@synthesize name = _name, type = _type, timeFetched = _timeFetched;

-(id) initWithName: (NSString *) name andType: (NSString *) type andTime: (int) time;
{
    self = [[Alerta alloc] init];
    self.name = name;
    self.type = type;
    self.timeFetched = time;
    if (self) {
    }
    return self;
}

@end
