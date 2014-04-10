//
//  Alerta.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 10/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "Alerta.h"

@implementation Alerta

@synthesize name = _name, type = _type, timeFetched = _timeFetched, description = _description, dueDate = _dueDate;

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


-(id) initWithName: (NSString *) name
           andType: (NSString *) type
           andTime: (int) time
    andDescription: (NSString *) desc
        andDueDate: (NSDate *) date
{
    self = [[Alerta alloc] init];
    self.name = name;
    self.type = type;
    self.timeFetched = time;
    self.description = desc;
    self.dueDate = date;
    if (self) {
    }
    return self;
}

@end
