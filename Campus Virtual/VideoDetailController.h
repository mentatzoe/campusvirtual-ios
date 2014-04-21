//
//  VideoDetailController.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 18/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Video.h"

@interface VideoDetailController : UIViewController
@property (strong, nonatomic) IBOutlet UISegmentedControl *partesSegmented;
@property (weak, nonatomic) IBOutlet UILabel *tituloLabel;
@property (weak, nonatomic) IBOutlet UILabel *descripcionLabel;
@property (nonatomic, strong) Video *video;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;
-(IBAction) playMovie;

@end
