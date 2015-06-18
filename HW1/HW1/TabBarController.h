//
//  TabBarController.h
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/17.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabBarController : UITabBarController<UITabBarControllerDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navItem;
@property (weak, nonatomic) IBOutlet UITabBar *bar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *seg;

@end
