//
//  MovieDetailViewController.h
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/16.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailDesc;
@property (weak, nonatomic) NSDictionary *movie;

@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIImageView *poster;
@end
