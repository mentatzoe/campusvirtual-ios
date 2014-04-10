//
//  CustomTabBarController.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 09/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "CustomTabBarController.h"
#import "AlertasViewController.h"

@interface CustomTabBarController ()

@end

@implementation CustomTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.navigationItem.hidesBackButton = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    AlertasViewController *a =  [[self viewControllers] objectAtIndex:0];
    a.userID = self.userID;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToTabs:(UIStoryboardSegue *) unwindSegue
{
     NSLog(@"I'm working. Kinda");
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
     NSLog(@"prepareForSegue: %@", segue.identifier);
    AlertasViewController *controller = (AlertasViewController *) segue.destinationViewController;
    controller.userID = self.userID;
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


@end
