//
//  DetailViewController.m
//  Rotten Mangoes
//
//  Created by Taylor Benna on 2016-05-23.
//  Copyright © 2016 Taylor Benna. All rights reserved.
//

#import "DetailViewController.h"
#import "Review.h"
#import "ReviewCell.h"


@interface DetailViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet UILabel *runtimeLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *reviews;


@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reviews = [[NSMutableArray alloc] init];
    
    self.imageView.image = self.currentMovie.image;
    self.titleLabel.text = self.currentMovie.title;
    
    NSString *ratingString = [@"Rating: " stringByAppendingString:self.currentMovie.rating];
    self.ratingLabel.text = ratingString;
    
    
    NSString *run = [NSString stringWithFormat:@"%@", self.currentMovie.runtime];
    NSString *runtimeString = [@"Runtime: " stringByAppendingString:run];
    runtimeString = [runtimeString stringByAppendingString:@"min"];
    self.runtimeLabel.text = runtimeString;
    
    self.descriptionView.text = self.currentMovie.desc;
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:self.currentMovie.reviewsURL] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (!error) {
            
            NSError *jsonError = nil;
            
            NSDictionary *info = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
            
            NSLog(@"%@", info);
            
            NSArray *reviews = info[@"reviews"];
            
            for (int i = 0; i < 3; i++) {
                Review *rev = [[Review alloc] initWithDictionary:reviews[i]];
                [self.reviews addObject:rev];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                
            });
            
        }
        
        
    }];
    
    [dataTask resume];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reviewCell"];
    Review *currentReview = self.reviews[indexPath.row];
    
    cell.reviewNameLabel.text = [@"- " stringByAppendingString: currentReview.criticName];
    cell.quoteText.text = currentReview.reviewText;
    
    return cell;
}



@end
