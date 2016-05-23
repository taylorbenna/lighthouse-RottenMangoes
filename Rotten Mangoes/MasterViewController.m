//
//  ViewController.m
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "MasterViewController.h"
#import "MovieCell.h"
#import "Movie.h"
#import "DetailViewController.h"

@interface MasterViewController () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic) NSMutableArray *movies;
@property (nonatomic) Movie *currentMovie;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.movies = [[NSMutableArray alloc] init];
    
    NSString *urlString = @"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json?apikey=55gey28y6ygcr8fjy4ty87ek&page_limit=20";
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:urlString] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSArray *movies = info[@"movies"];;
            
            for (NSDictionary *movieInfo in movies) {
                Movie *mov = [[Movie alloc] initWithDictionary:movieInfo];
                [self.movies addObject:mov];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.collectionView reloadData];
                
            });
            
        }

        
    }];
    
    [dataTask resume];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"movieCell" forIndexPath:indexPath];
    
    Movie *currentMovie = self.movies[indexPath.item];
    cell.movieTitle.text = currentMovie.title;
    cell.movieImage.image = currentMovie.image;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:cell.bounds];
    cell.layer.masksToBounds = NO;
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    cell.layer.shadowOpacity = 0.5f;
    cell.layer.shadowPath = shadowPath.CGPath;
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.currentMovie = self.movies[indexPath.item];
    [self performSegueWithIdentifier:@"detailSegue" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"detailSegue"])
    {
        DetailViewController *detailController = segue.destinationViewController;
        detailController.currentMovie = self.currentMovie;
    }
}


@end
