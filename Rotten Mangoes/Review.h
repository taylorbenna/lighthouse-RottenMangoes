//
//  Review.h
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject

@property (nonatomic) NSString *criticName;
@property (nonatomic) NSString *reviewText;

- (instancetype)initWithDictionary:(NSDictionary *)info;

@end
