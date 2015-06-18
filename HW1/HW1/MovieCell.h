//
//  MovieCell.h
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/16.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@end
