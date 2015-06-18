//
//  MovieDetailViewController.m
//  HW1
//
//  Created by Wei-Lun Su on 2015/6/16.
//  Copyright (c) 2015年 Wei-Lun Su. All rights reserved.
//

#import "MovieDetailViewController.h"
#import <UIImageView+AFNetworking.h>
 #import "SVProgressHUD.h"
@implementation MovieDetailViewController


CGRect backupFrame;
CGRect backupDescFrame;
CGPoint backupPoint;

- (void) viewDidLoad{
    
    
    
    
    
    
   // [SVProgressHUD showWithStatus:@"Loading..." maskType:SVProgressHUDMaskTypeGradient];

    self.detailTitle.text = self.movie[@"title"];
    self.detailDesc.text = self.movie[@"synopsis"];

    NSString *posterUrlString = self.movie[@"posters"][@"detailed"];
    [self.poster setImageWithURL:[NSURL URLWithString:posterUrlString]];
    
    posterUrlString = [self convertPosterUrlStringToHighRes:self.movie[@"posters"][@"detailed"]];
    [self.poster setImageWithURL:[NSURL URLWithString:posterUrlString]];
 //   [SVProgressHUD dismiss];
   


}

-(NSString *) convertPosterUrlStringToHighRes:(NSString*) urlString{
    NSRange range = [urlString rangeOfString:@".*cloudfront.net/" options:NSRegularExpressionSearch];
    NSString *returnValue = urlString;
    if(range.length>0){
    
        returnValue = [urlString stringByReplacingCharactersInRange:range withString:@"https://content6.flixster.com/"];
    }
    return returnValue;
}
- (IBAction)singleTap:(id)sender {
    
    
    
    
    if(!CGRectEqualToRect(self.descView.bounds,self.poster.bounds)){
    
      [UIView animateWithDuration:0.5 animations:^{
        
        backupFrame = self.descView.bounds;
        backupPoint = self.descView.center;
        backupDescFrame = self.detailDesc.bounds;
        
        self.descView.bounds = self.poster.bounds;
        CGRect frame = self.poster.bounds;
        frame.size.height -= self.detailTitle.bounds.size.height;
        frame.size.width = self.detailDesc.bounds.size.width;
        self.detailDesc.bounds = frame;
        self.descView.center=self.poster.center;
     
      }];
    }
    
    else {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            self.descView.bounds = backupFrame;
            self.detailDesc.bounds = backupDescFrame;
            self.descView.center=backupPoint;
            
        }];

    
      
    
    }
    
}

@end
