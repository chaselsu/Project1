//
//  SecondViewController.m
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/12.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import "DVDViewController.h"
 #import "SVProgressHUD.h"
#import "MovieCell.h"
#import "MovieCollectionCell.h"
#import <UIImageView+AFNetworking.h>
#import "MovieDetailViewController.h"
@interface DVDViewController ()
@property (strong, nonatomic) NSArray *dvds;
@property (strong, nonatomic)  UIRefreshControl *refreshControl;
@property (strong, nonatomic)  UIRefreshControl *refreshControlGrid;

@end

@implementation DVDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(refresh)
                  forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    
    
    
    self.refreshControlGrid = [[UIRefreshControl alloc] init];
    [self.refreshControlGrid addTarget:self action:@selector(refresh)
                      forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:self.refreshControlGrid];
    
    
    
    //[self.collectionView addSubview:self.refreshControl];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    self.type = 0;
    
    //@"https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json";
    
    [self reloadData];
    
    
    //[SVProgressHUD dismiss];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) reloadData{
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];

    NSString *apiURLString =@"https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json";
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiURLString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        // NSLog(@"%@",data);
        // NSLog(@"%@",connectionError);
        NSString *newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.dvds = dict[@"movies"];
        [self.tableView reloadData];
        [self.collectionView reloadData];
        
         [SVProgressHUD dismiss];
    }];
    
}



- (void)refreshTableView:(id)sender {
    UIRefreshControl *refreshControl = (UIRefreshControl *)sender;
    NSLog(@"Refreshing");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dvds.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    NSLog(cell.title.text);
    cell.title.text = self.dvds[indexPath.row][@"title"];
    cell.desc.text = self.dvds[indexPath.row][@"synopsis"];
    cell.thumbnail.layer.cornerRadius = 5.0;
    cell.thumbnail.layer.borderColor = [[UIColor grayColor] CGColor];
    cell.thumbnail.layer.borderWidth = 1.0;
    cell.thumbnail.layer.masksToBounds = YES;
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:(self.dvds[indexPath.row][@"posters"][@"thumbnail"])]];
    cell.thumbnail.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        cell.thumbnail.alpha = 1.0;
        
    }];
    
    
    
    //[cell.thumbnail setImageWithURL:[NSURL URLWithString:[self convertPosterUrlStringToHighRes:self.movies[indexPath.row][@"posters"][@"detailed"]]]];
    
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    
    return cell;
    
}




- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dvds.count;
    
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    MovieCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"mycCell" forIndexPath:indexPath];
    
    
    NSLog(cell.title.text);
    cell.title.text = self.dvds[indexPath.row][@"title"];
    cell.image.layer.cornerRadius = 10.0;
    cell.image.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.image.layer.borderWidth = 3.0;
    cell.image.layer.masksToBounds = YES;
    [cell.image setImageWithURL:[NSURL URLWithString:(self.dvds[indexPath.row][@"posters"][@"thumbnail"])]];
    cell.image.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        cell.image.alpha = 1.0;
        
    }];
    
    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    return cell;
    
}

-(void) refresh{
    [self reloadData];
    [self.tableView reloadData];
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
    [self.refreshControlGrid endRefreshing];
    
}
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    MovieCell *cell = sender;
    NSIndexPath *indexPath;
    if(self.type == 0){
        indexPath = [self.tableView indexPathForCell:cell];
    }
    else{
        indexPath  = [self.collectionView indexPathForCell:cell];
    }
    MovieDetailViewController *dest = segue.destinationViewController;
    
    
    NSDictionary *movie = self.dvds[indexPath.row];
    dest.movie = movie;
    
}

@end
