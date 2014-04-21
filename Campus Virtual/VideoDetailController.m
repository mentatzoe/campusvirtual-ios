//
//  VideoDetailController.m
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 18/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import "VideoDetailController.h"

@interface VideoDetailController ()

@property (nonatomic, strong) NSString* videoURL;
@property int indexVideo;

@end

@implementation VideoDetailController

@synthesize video = _video, videoURL = _videoURL, moviePlayer = _moviePlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.indexVideo = 0;
        // Custom initialization

    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSArray *statusItems = [[NSArray alloc] initWithObjects:@"one", @"two", nil];
//    self.partesSegmented = [[UISegmentedControl alloc] initWithItems: statusItems];
    //Create the segmented control
    self.partesSegmented = [[UISegmentedControl alloc] initWithItems:self.video.listaPartes];
    int i = 60 * self.video.listaPartes.count;
    NSLog(@"%@", self.video.listaPartes);
    self.partesSegmented.frame = CGRectMake(160, 442, i, 29);
    self.partesSegmented.selectedSegmentIndex = self.indexVideo;
    [self.partesSegmented addTarget:self
                         action:@selector(pickOne:)
               forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:self.partesSegmented];
    
    self.tituloLabel.text = self.video.titulo;
    self.descripcionLabel.text = self.video.descripcion;
    NSLog(@"%@", [self.video.partes objectAtIndex:self.indexVideo]);
//Action method executes when user touches the button

    // Do any additional setup after loading the view.
}

-(void) pickOne:(id)sender{
    UISegmentedControl *segmentedControl = (UISegmentedControl *)sender;
    self.indexVideo = [segmentedControl selectedSegmentIndex];
    NSMutableDictionary *parte = [self.video.partes objectAtIndex:self.indexVideo];
    self.videoURL = [NSURL URLWithString: [parte objectForKey:@"url"]];
}

-(void)playMovie
{
    
    
    NSMutableDictionary *parte = [self.video.partes objectAtIndex:self.indexVideo];
    NSURL *videoURL = [NSURL URLWithString: [parte objectForKey:@"video"]];

    self.moviePlayer =  [[MPMoviePlayerController alloc]
                    initWithContentURL:videoURL];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(moviePlayBackDidFinish:)
                                                 name:MPMoviePlayerPlaybackDidFinishNotification
                                               object:self.moviePlayer];
    
    self.moviePlayer.controlStyle = MPMovieControlStyleDefault;
    [self.view addSubview:self.moviePlayer.view];
    [self.moviePlayer setFullscreen:YES animated:YES];
}

- (void) moviePlayBackDidFinish:(NSNotification*)notification {
    MPMoviePlayerController *player = [notification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
    
    if ([player
         respondsToSelector:@selector(setFullscreen:animated:)])
    {
        [player.view removeFromSuperview];
    }
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

@end
