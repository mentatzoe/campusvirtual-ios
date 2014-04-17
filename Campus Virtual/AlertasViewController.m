//
//  AlertasViewController.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 10/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "AlertasViewController.h"
#import "AlertaDetailController.h"
#import "Alerta.h"
#import "EventTableViewCell.h"

@interface AlertasViewController ()

@property (nonatomic, strong) NSMutableArray *alertas;
@property (nonatomic, weak) Alerta *selected;

@end

#define getDataURL2 @"http://www.pmasters.es/ios/getalerts.php"

@implementation AlertasViewController

@synthesize userID = _userID;
@synthesize json = _json;
@synthesize alertas = _alertas;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    NSLog(@"User view ID %d", self.userID);
    [self getData];
    [self parseJSON];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:TRUE];
    [self.alertas sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.alertas count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"EventTableViewCell";
    
    EventTableViewCell *cell = (EventTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"EventTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Alerta *a = [self.alertas objectAtIndex:indexPath.row];
    cell.name.text = a.name;
    NSString *dateString = [NSDateFormatter localizedStringFromDate:a.dueDate
                                                        dateStyle:NSDateFormatterShortStyle
                                                          timeStyle:NSDateFormatterShortStyle];
    cell.date.text = dateString;
    cell.course.text = a.coursename;
    cell.typeThumb.image = [UIImage imageNamed:a.type];
    cell.detailTextLabel.text = @"Aquí info extra: Tiempo restante o similares";
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


#pragma mark - Data

- (void)getData {
    @try {
            NSString *post =[[NSString alloc] initWithFormat:@"user=%d",self.userID];
            NSLog(@"PostData: %@",post);
            
            NSURL *url=[NSURL URLWithString:getDataURL2];
            
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            
            NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            //[NSURLRequest setAllowsAnyHTTPSCertificate:YES forHost:[url host]];
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
        //    NSLog(@"Response code: %d", [response statusCode]);
            if ([response statusCode] >=200 && [response statusCode] <300)
            {
                NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                NSLog(@"Response ==> %@", responseData);
                
                NSData* dataAfter = [responseData dataUsingEncoding:NSUTF8StringEncoding];
                self.json = [NSJSONSerialization JSONObjectWithData:dataAfter options:kNilOptions error:nil];
                
              //  NSLog(@"JSON content %@", self.json);
                
               /* NSInteger success = [(NSNumber *) [(NSDictionary *)self.json objectForKey:@"success"] integerValue];
                NSLog(@"%d",success);ç*/
            }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    
}

- (void) parseJSON{
    self.alertas = [[NSMutableArray alloc] init];
    for (NSDictionary* j in self.json){
        NSString *name = [j objectForKey:@"name"];
        if( !(name == (id)[NSNull null] || name.length == 0)){
            
            NSString *desc= [j objectForKey:@"description"];
            
            int unixtime = [[NSNumber numberWithDouble: [[NSDate date] timeIntervalSince1970]] integerValue];
            NSDate *dueDate = [NSDate dateWithTimeIntervalSince1970: [[j objectForKey:@"dueDate"] doubleValue]];
            
            Alerta* a = [[Alerta alloc] initWithName:[j objectForKey:@"name"] andType:[j objectForKey:@"type"] andTime: unixtime andDescription:desc andDueDate:dueDate andCourseName:[j objectForKey:@"course_name"]];
            
            [self.alertas addObject: a];
            NSLog(@"Alerta loop: %@", a);
        }
    }
    NSLog(@"Alertas: %@", self.alertas);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AlertaDetailController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"AlertaDetailController"];
    dvc.alertaDet = [self.alertas objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];    // Display Alert Message
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

@end
