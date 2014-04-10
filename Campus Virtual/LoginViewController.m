//
//  LoginViewController.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 09/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "LoginViewController.h"
#import "CustomTabBarController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

- (IBAction)startLogin:(id)sender;

@end

#define getDataURL @"http://www.pmasters.es/campusvirtualMMCD2012/ios/login.php"

@implementation LoginViewController

@synthesize responseData = _responseData;
@synthesize json = _json;

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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    
    [alertView show];
}

#pragma mark - Login

- (IBAction)startLogin:(id)sender {
        @try {
            
            if([self.username.text isEqualToString:@""] || [self.password.text isEqualToString:@""] ) {
                 NSLog(@"It's empty!");
            } else {
                NSString *post =[[NSString alloc] initWithFormat:@"user=%@&password=%@",self.username.text,self.password.text];
                NSLog(@"PostData: %@",post);
                
                NSURL *url=[NSURL URLWithString:getDataURL];
                
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
                
                NSLog(@"Response code: %d", [response statusCode]);
                if ([response statusCode] >=200 && [response statusCode] <300)
                {
                    NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
                    NSLog(@"Response ==> %@", responseData);
                    
                    NSData* dataAfter = [responseData dataUsingEncoding:NSUTF8StringEncoding];
                     self.json = [NSJSONSerialization JSONObjectWithData:dataAfter options:kNilOptions error:nil];
                     
                    NSLog(@"JSON content %@", self.json);
                    
                    NSInteger success = [(NSNumber *) [(NSDictionary *)self.json objectForKey:@"success"] integerValue];
                    NSLog(@"%d",success);
                    if(success == 1)
                    {
                        [self performSegueWithIdentifier:@"loginSegue" sender:self];
                        
                    } else {
                        
                        NSString *error_msg = (NSString *) [(NSDictionary *)self.json objectForKey:@"error_message"];
                        [self alertStatus:error_msg :@"Login Failed!"];
                    }
                    
                } else {
                    if (error) NSLog(@"Error: %@", error);
                    [self alertStatus:@"Connection Failed" :@"Login Failed!"];
                }
            }
        }
        @catch (NSException * e) {
            NSLog(@"Exception: %@", e);
            [self alertStatus:@"Login Failed." :@"Login Failed!"];
        }
    
}


#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    self.responseData = [[NSMutableData alloc] init];
    NSLog(@"%s: %@", __FUNCTION__, self.responseData);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.responseData appendData:data];

}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
}

@end
