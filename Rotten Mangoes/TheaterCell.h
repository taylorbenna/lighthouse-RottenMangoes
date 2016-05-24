//
//  TheaterCell.h
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-24.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TheaterCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;

@end
