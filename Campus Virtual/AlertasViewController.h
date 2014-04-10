//
//  AlertasViewController.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 10/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlertasViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) int userID;

@property (nonatomic, strong) NSMutableArray * json;


@end
