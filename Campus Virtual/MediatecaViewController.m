//
//  MediatecaViewController.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 11/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "MediatecaViewController.h"
#import "Video.h"

@interface MediatecaViewController ()

@property (nonatomic, strong) NSMutableArray *videos;
@property (nonatomic, strong) NSMutableArray * json;

@end

#define getDataURLVideos @"http://www.pmasters.es/ios/getvideos.php"

@implementation MediatecaViewController

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
    
    [self getData];
    [self parseJSON];
    
    //Getting objects and parsing JSON
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

#pragma mark - Data

- (void)getData {
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@""];
        NSLog(@"PostData: %@",post);
        
        NSURL *url=[NSURL URLWithString:getDataURLVideos];
        
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
            
            //NSLog(@"MEDIATECA JSON content %@", self.json);
        }
        
    }
    @catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    
}

- (void) parseJSON{
    self.videos = [[NSMutableArray alloc] init];
    for (NSDictionary* j in self.json){
        NSString *name = [j objectForKey:@"titulo"];
        if( !(name == (id)[NSNull null] || name.length == 0)){
            
            NSDate *fecha = [NSDate dateWithTimeIntervalSince1970: [[j objectForKey:@"fecha"] doubleValue]];
            
            Video *v = [[Video alloc] initWithTitulo:[j objectForKey:@"titulo"] andDesc:[j objectForKey:@"descripcion"] andFecha:fecha andTipo: 1];
            
            NSLog(@"Contenido partes %@", [j objectForKey:@"partes"]);
            
            [self.videos addObject: v];
            NSLog(@"Video loop: %@", v);
        }
    }
    NSLog(@"Videos: %@", self.videos);
}

@end
