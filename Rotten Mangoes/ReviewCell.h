//
//  ReviewCell.h
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *reviewNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *quoteText;


@end
