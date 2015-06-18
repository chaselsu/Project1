//
//  SecondViewController.h
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/12.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DVDViewController : UIViewController<UITableViewDelegate, UITableViewDataSource, UITabBarDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger type;

@end

