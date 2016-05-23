//
//  MovieCell.h
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;

@end
