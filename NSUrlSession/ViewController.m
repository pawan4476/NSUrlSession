//
//  ViewController.m
//  NSUrlSession
//
//  Created by Nagam Pawan on 10/1/16.
//  Copyright © 2016 Nagam Pawan. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (strong, nonatomic) NSArray *bundleId;
@property (strong, nonatomic) NSMutableArray *trackIdArray;
@property (strong, nonatomic) NSArray *results;
@property (strong, nonatomic) NSArray *trackId;
@property (strong, nonatomic) NSMutableArray *bundleIdDetails;
@property (strong, nonatomic) NSArray *image1;
@property (strong, nonatomic) NSMutableArray *imageDetails;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self UrlSession1];
    self.automaticallyAdjustsScrollViewInsets = false;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)UrlSession1{
    self.trackIdArray = [[NSMutableArray alloc]init];
    self.bundleIdDetails = [[NSMutableArray alloc]init];
    self.imageDetails = [[NSMutableArray alloc]init];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:[NSURL URLWithString:@"https://itunes.apple.com/search?term=apple&media=software"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        NSLog(@"All Json data is %@", json);
        self.results = [json valueForKey:@"results"];
        self.trackId = [self.results valueForKey:@"trackName"];
        self.bundleId = [self.results valueForKey:@"bundleId"];
        self.image1 = [self.results valueForKey:@"ipadScreenshotUrls"];
        for (int i = 0; i < _image1.count; i++) {
        [self.imageDetails addObjectsFromArray:self.image1[i]];
            i++;
        }
        NSLog(@"images are %@", _imageDetails);
        NSLog(@"Artist name are %@", _trackId);
        [self.trackIdArray addObjectsFromArray:self.trackId];
        [self.bundleIdDetails addObjectsFromArray:self.bundleId];
        NSLog(@"Artist Details are %@", self.trackIdArray);
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
    }
                                    ];
    [dataTask resume];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.trackIdArray count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    cell.textLabel.backgroundColor = [UIColor purpleColor];
//    cell.detailTextLabel.backgroundColor = [UIColor purpleColor];
    
//    cell.textLabel.textColor = [UIColor redColor];
//    cell.detailTextLabel.textColor = [UIColor grayColor];
    
    cell.textLabel.text = [self.trackIdArray objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [self.bundleIdDetails objectAtIndex:indexPath.row];
        NSURL *url = [NSURL URLWithString:[self.imageDetails objectAtIndex:indexPath.row]];
           NSData *data = [NSData dataWithContentsOfURL:url];
           [cell.imageView setImage:[UIImage imageWithData:data]];
    return cell;
}


@end
