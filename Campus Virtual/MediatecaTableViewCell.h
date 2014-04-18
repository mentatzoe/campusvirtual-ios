//
//  MediatecaTableViewCell.h
//  Campus Virtual
//
//  Created by Maria Lopez Latorre on 18/04/14.
//  Copyright (c) 2014 Masters en Marketing, Comercio y Distribucion. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MediatecaTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *titulo;
@property (nonatomic, weak) IBOutlet UILabel *descripcion;
@property (nonatomic, weak) IBOutlet UILabel *fecha;
@property (nonatomic, weak) IBOutlet UIImageView *imagen;


@end
