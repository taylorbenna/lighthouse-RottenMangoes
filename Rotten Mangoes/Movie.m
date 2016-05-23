//
//  Movie.m
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (instancetype)initWithDictionary:(NSDictionary *)info
{
    self = [super init];
    if (self) {
        
        _title = info[@"title"];
        
        NSDictionary *posters = info[@"posters"];
        NSString *urlString = posters[@"original"];
        NSURL *photoURL = [NSURL URLWithString:urlString];
        NSData *data = [[NSData alloc] initWithContentsOfURL:photoURL];
        _image = [UIImage imageWithData:data];
        
        _rating = info[@"mpaa_rating"];
        _runtime = info[@"runtime"];
        _desc = info[@"synopsis"];
        
        NSDictionary *links = info[@"links"];
        
        
        _reviewsURL = [links[@"reviews"] stringByAppendingString:@"?apikey=55gey28y6ygcr8fjy4ty87ek"];
    }
    return self;
}

@end
