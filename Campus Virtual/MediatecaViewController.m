//
//  MediatecaViewController.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 11/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "MediatecaViewController.h"
#import "Video.h"
#import "MediatecaTableViewCell.h"
#import "VideoDetailController.h"

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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
 
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
 {
     NSLog(@"%@", self.storyboard);
 
VideoDetailController *dvc = [self.storyboard instantiateViewControllerWithIdentifier:@"VideoDetailController"];
     Video *v = [self.videos objectAtIndex:indexPath.row];
     NSLog(@"%@", v.partes);
 dvc.video = [self.videos objectAtIndex:indexPath.row];
 [self.navigationController pushViewController:dvc animated:YES]; 
 
 }


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.videos count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"MediatecaTableViewCell";
    
    MediatecaTableViewCell *cell = (MediatecaTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MediatecaTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Video *a = [self.videos objectAtIndex:indexPath.row];
    cell.titulo.text = a.titulo;
    
    cell.descripcion.text = a.descripcion;
    if (!(cell.descripcion.text && cell.descripcion.text.length)){
        cell.descripcion.text = a.tipo;
    }
    
   // NSString *dateString = [NSDateFormatter localizedStringFromDate:a.fecha dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterNoStyle];
    cell.fecha.text = a.fecha;
    cell.imagenThumb.image = [UIImage imageNamed:a.tipo];
    cell.detailTextLabel.text = @"Aquí info extra: Tiempo restante o similares";
    return cell;
}

#pragma mark - Data

- (void)getData {
    @try {
        NSString *post =[[NSString alloc] initWithFormat:@""];
        //NSLog(@"PostData: %@",post);
        
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
        
        //NSLog(@"Response code: %d", [response statusCode]);
        if ([response statusCode] >=200 && [response statusCode] <300)
        {
            NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
            //NSLog(@"Response ==> %@", responseData);
            
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
            
           // NSDate *fecha = [j objectForKey:@"fecha"];
            
           // NSLog(@"%@", [j objectForKey:@"fecha"]);
            
            Video *v = [[Video alloc] initWithTitulo:[j objectForKey:@"titulo"] andDesc:[j objectForKey:@"descripcion"] andFecha:[j objectForKey:@"fecha"] andTipo: [j objectForKey:@"tipo"]];
            
            //NSLog(@"Contenido partes %@", [j objectForKey:@"partes"]);
            v.partes = [j objectForKey:@"partes"];
            [self.videos addObject: v];
            //NSLog(@"Video loop: %@", v);
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}




@end
