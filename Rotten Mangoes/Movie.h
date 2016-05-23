//
//  Movie.h
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Movie : NSObject

@property (nonatomic) NSString *title;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *rating;
@property (nonatomic) NSString *runtime;
@property (nonatomic) NSString *desc;
@property (nonatomic) NSString *reviewsURL;

- (instancetype)initWithDictionary:(NSDictionary *)info;

@end
