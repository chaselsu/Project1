//
//  TabBarController.m
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/17.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import "TabBarController.h"
#import "MovieController.h"
#import "DVDViewController.h"
@implementation TabBarController
-(void)viewDidLoad{
    [super viewDidLoad];
    self.delegate = self;
    self.navItem.title=@"Movie";
  //  self.bar.delegate=self;
   // self.bar.delegate=self;

}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    if([viewController isKindOfClass:[MovieController class]]){
        self.navItem.title=@"Movie";
    }
    else{
        self.navItem.title=@"DVD";
    }
   
}
- (IBAction)segValueChanged:(id)sender {
    NSLog(@"segChanged");
    MovieController *viewController;
    DVDViewController *dvdViewController;
    switch([sender selectedSegmentIndex]){
        case 0:
            viewController =(MovieController*) [self.viewControllers objectAtIndex:0];
            viewController.tableView.alpha=1;
            viewController.type = 0;
            
            
            dvdViewController =(DVDViewController*) [self.viewControllers objectAtIndex:1];
            dvdViewController.tableView.alpha=1;
            dvdViewController.type = 0;

            
            
            break;
        case 1:
            viewController =(MovieController*) [self.viewControllers objectAtIndex:0];
            viewController.tableView.alpha=0;
            viewController.type = 1;
            
            
            dvdViewController =(DVDViewController*) [self.viewControllers objectAtIndex:1];
            dvdViewController.tableView.alpha=0;
            dvdViewController.type = 1;
            break;
            
    }
    
}

@end
