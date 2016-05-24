//
//  Theater.h
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-24.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Theater : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) CLLocationCoordinate2D coord;
@property (nonatomic) double distance;

- (instancetype)initWithDictionary:(NSDictionary *)info andCurrentLocation:(CLLocationCoordinate2D)currentCoord;

@end
