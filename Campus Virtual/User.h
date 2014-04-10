//
//  User.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 09/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *password;
@property (nonatomic) int userId;

@end
