//
//  AlertaDetailController.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 10/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Alerta.h"

@interface AlertaDetailController : UIViewController

@property (nonatomic, strong) Alerta *alertaDet;
@property (nonatomic, strong) NSString *stuff;

- (IBAction)unwindToDetail:(UIStoryboardSegue *) unwindSegueAlertaDetail;

@end
