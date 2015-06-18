//
//  FirstViewController.m
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/12.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import "MovieController.h"
#import "MovieDetailViewController.h"
#import "MovieCell.h"
#import "MovieCollectionCell.h"
#import <UIImageView+AFNetworking.h>
 #import "SVProgressHUD.h"
@interface MovieController()<UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) NSArray *movies;
@property (strong, nonatomic)  UIRefreshControl *refreshControl;
@property (strong, nonatomic)  UIRefreshControl *refreshControlGrid;




@property (strong,nonatomic) UIWindow *dropdown;
@property (strong,nonatomic) UILabel *label;
@property (strong,nonatomic) UIWindow *win;


@end

@implementation MovieController
NSInteger tableCount;
-(void)animateHeaderViewWithText:(NSString *) text {
    self.label.text = text;
    NSLog(@"%@",self.dropdown.frame.origin.y);
    
    
    [UIView animateWithDuration:0.5 delay:0 options:0 animations:^{
        self.dropdown.frame = CGRectMake(0, 0, 320, 80);
    }completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.5 delay:5 options:0 animations:^{
            self.dropdown.frame = CGRectMake(0, -80, 320, 80);
        } completion:^(BOOL finished) {
            
            //animation finished!!!
        }];
        ;
    }];
    
}
- (void)viewDidLoad {
  
    [super viewDidLoad];
    
    
    self.dropdown = [[UIWindow alloc] initWithFrame:CGRectMake(0, -80, 320, 80)];
    self.dropdown.backgroundColor = [UIColor
                                     colorWithRed:1.0
                                     green:0.785
                                     blue:0.167
                                     alpha:1.0];;
    self.label = [[UILabel alloc] initWithFrame:self.dropdown.bounds];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.font = [UIFont systemFontOfSize:16];
    self.label.backgroundColor = [UIColor clearColor];
    [self.dropdown addSubview:self.label];
    self.dropdown.windowLevel = UIWindowLevelStatusBar;
    [self.dropdown makeKeyAndVisible];
    [self.dropdown resignKeyWindow];
    
    
    
    
    
    
    
    
    
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
    
    
   
}
-(void) reloadData{
    [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];

    NSString *apiURLString =@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?apikey=dagqdghwaq3e3mxyrp7kmmj5&limit=20&country=us";


    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:apiURLString]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
        
        if(connectionError!=nil){
    
        [self animateHeaderViewWithText:@"Network Error"];
        }
        else{
        
             NSString *newStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.movies = dict[@"movies"];
        [self.tableView reloadData];
        [self.collectionView reloadData];
           
        }
        
    }];
[SVProgressHUD dismiss];
}


- (void)refreshTableView:(id)sender {
    UIRefreshControl *refreshControl = (UIRefreshControl *)sender;
    NSLog(@"Refreshing");
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.movies.count;

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    NSLog(cell.title.text);
    cell.title.text = self.movies[indexPath.row][@"title"];
    cell.desc.text = self.movies[indexPath.row][@"synopsis"];
    cell.thumbnail.layer.cornerRadius = 5.0;
    cell.thumbnail.layer.borderColor = [[UIColor grayColor] CGColor];
    cell.thumbnail.layer.borderWidth = 1.0;
    cell.thumbnail.layer.masksToBounds = YES;
    [cell.thumbnail setImageWithURL:[NSURL URLWithString:(self.movies[indexPath.row][@"posters"][@"thumbnail"])]];
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
    return self.movies.count;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    
    MovieCollectionCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"mycCell" forIndexPath:indexPath];
  

    NSLog(cell.title.text);
    cell.title.text = self.movies[indexPath.row][@"title"];
    cell.image.layer.cornerRadius = 10.0;
    cell.image.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.image.layer.borderWidth = 3.0;
    cell.image.layer.masksToBounds = YES;
    [cell.image setImageWithURL:[NSURL URLWithString:(self.movies[indexPath.row][@"posters"][@"thumbnail"])]];
    cell.image.alpha = 0;
    
    [UIView animateWithDuration:1.0 animations:^{
        cell.image.alpha = 1.0;
        
    }];

    UIView *selectionColor = [[UIView alloc] init];
    selectionColor.backgroundColor = [UIColor colorWithRed:(0/255.0) green:(0/255.0) blue:(0/255.0) alpha:1];
    cell.selectedBackgroundView = selectionColor;
    
    return cell;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
  
    
    NSDictionary *movie = self.movies[indexPath.row];
    dest.movie = movie;

}
-(NSString *) convertPosterUrlStringToHighRes:(NSString*) urlString{
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if(range.length>0){
        
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}

-(void) refresh{
    [self reloadData];
    [self.tableView reloadData];
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
    [self.refreshControlGrid endRefreshing];
    
}


@end
