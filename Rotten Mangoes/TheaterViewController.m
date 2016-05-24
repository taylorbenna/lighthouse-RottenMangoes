//
//  TheaterViewController.m
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-24.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "TheaterViewController.h"
#import <MapKit/MapKit.h>
#import "Theater.h"
#import "TheaterCell.h"

@interface TheaterViewController () <CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource, MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet UINavigationItem *navBar;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic) CLLocation *lastLocation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSMutableArray *theaters;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TheaterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.theaters = [[NSMutableArray alloc] init];
    
    self.navBar.title = self.selectedMovie.title;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }

}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager startUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    CLLocation *currentLocation = [locations lastObject];
    
    if (self.lastLocation == nil) {
        
        MKCoordinateSpan span = MKCoordinateSpanMake(0.03, 0.03);
        MKCoordinateRegion region = MKCoordinateRegionMake(currentLocation.coordinate, span);
        [self.mapView setRegion:region animated:NO];
        
        CLGeocoder *coder = [[CLGeocoder alloc] init];

        [coder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
            
            CLPlacemark *place = [placemarks firstObject];
            
            if (place) {
                NSString *postalCode = place.postalCode;
             ///////////
                
                NSString *newCode = [postalCode stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                NSString *newName = [self.selectedMovie.title stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
                NSString *stringToAdd = [NSString stringWithFormat:@"address=%@&movie=%@", newCode, newName];
                
                NSString *urlString = [@"http://lighthouse-movie-showtimes.herokuapp.com/theatres.json?" stringByAppendingString:stringToAdd];
                
                NSURLSession *session = [NSURLSession sharedSession];

                NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    
                    if (!error) {
                        
                        NSError *jsonError = nil;
                        
                        NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        
                        NSArray *theaters = info[@"theatres"];
                        
                        for (NSDictionary *theaterInfo in theaters) {
                            Theater *thea = [[Theater alloc] initWithDictionary:theaterInfo andCurrentLocation:currentLocation.coordinate];
                            [self.theaters addObject:thea];
                            
                            MKPointAnnotation *anno = [[MKPointAnnotation alloc] init];
                            anno.title = thea.name;
                            anno.subtitle = thea.address;
                            anno.coordinate = thea.coord;
                            
                            [self.mapView addAnnotation:anno];
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            [self.tableView reloadData];
                            
                        });
                        
                    }
                    
                }];
                
                [dataTask resume];
                
            }
        }];
    }
    
    self.lastLocation = currentLocation;

}

- (IBAction)doneButtonPushed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.theaters.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TheaterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"theaterCell"];
    Theater *currentTheater = self.theaters[indexPath.row];
    
    cell.titleLabel.text = currentTheater.name;
    cell.addressLabel.text = currentTheater.address;
    cell.distanceLabel.text = [NSString stringWithFormat:@"Distance to Theater: %.2fkm", (currentTheater.distance / 1000)];
    
    
    return cell;
}

- (nullable MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"Pin"];
    
    if (!pin) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"Pin"];
        pin.pinTintColor = [UIColor purpleColor];
        pin.canShowCallout = YES;
    }
    
    
    
    return pin;
}


@end
