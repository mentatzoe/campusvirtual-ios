//
//  AlertaDetailController.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 10/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

@implementation UILabel (Html)

- (void) setHtml: (NSString*) html
{
    NSError *err = nil;
    self.attributedText =
    [[NSAttributedString alloc]
     initWithData: [html dataUsingEncoding:NSUTF32StringEncoding allowLossyConversion:YES]
     options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
     documentAttributes: nil
     error: &err];
    if(err)
        NSLog(@"Unable to parse label text: %@", err);
}

@end

#import "AlertaDetailController.h"

@interface AlertaDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *labelOutlet;
@property (weak, nonatomic) IBOutlet UILabel *typeOutlet;
@property (weak, nonatomic) IBOutlet UILabel *descOutlet;
@property (weak, nonatomic) IBOutlet UILabel *dateOutlet;

@end

@implementation AlertaDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"desc: %@", self.alertaDet.description);
    
    [self.labelOutlet setText:self.alertaDet.name];
    [self.typeOutlet setText:self.alertaDet.type];
    [self.descOutlet setHtml:self.alertaDet.description];
    [self.dateOutlet setText:[self formatDate]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSString *) formatDate{
    NSString *dateString =
    [NSDateFormatter localizedStringFromDate:self.alertaDet.dueDate
                    dateStyle:NSDateFormatterShortStyle
                        timeStyle:NSDateFormatterShortStyle];
    NSLog(@"%@",dateString);
    
    return dateString;
}

- (IBAction)unwindToDetail:(UIStoryboardSegue *)unwindSegueAlertaDetail
{
    NSLog(@"YAY");
}


@end


