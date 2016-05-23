//
//  Review.m
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "Review.h"

@implementation Review

- (instancetype)initWithDictionary:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        _criticName = info[@"critic"];
        _reviewText = info[@"quote"];
    }
    return self;
}

@end
