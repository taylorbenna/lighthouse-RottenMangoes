//
//  Theater.m
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-24.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "Theater.h"

@implementation Theater

- (instancetype)initWithDictionary:(NSDictionary *)info andCurrentLocation:(CLLocationCoordinate2D)currentCoord
{
    self = [super init];
    if (self) {
        _name = info[@"name"];
        _address = info[@"address"];
        _coord = CLLocationCoordinate2DMake([info[@"lat"] doubleValue], [info[@"lng"] doubleValue]);
        
        CLLocation *first = [[CLLocation alloc] initWithLatitude:self.coord.latitude longitude:self.coord.longitude];
        CLLocation *second = [[CLLocation alloc] initWithLatitude:currentCoord.latitude longitude:currentCoord.longitude];
        _distance = [first distanceFromLocation:second];
    }
    return self;
}

@end
