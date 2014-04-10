//
//  LoginViewController.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 09/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface LoginViewController : UIViewController<NSURLConnectionDelegate>

@property (nonatomic) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray * json;

@end
