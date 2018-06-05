//
//  WMSearchBar.m
//  SearchBarDemo
//
//  Created by 汪泽天 on 2017/7/19.
//  Copyright © 2017年 霍. All rights reserved.
//

#import "WMSearchBar.h"

@interface WMSearchBar ()

@property(nonatomic,assign) BOOL isChangeFrame;//是否要改变searchBar的frame

@end

@implementation WMSearchBar

- (void)layoutSubviews {
    
    [super layoutSubviews];
    for (UIView *subView in self.subviews) {
        
    
        if ([subView isKindOfClass:[UITextField class]]) {
            

//              subView.frame = CGRectMake(0, 0, LFscreenW - 2 * 44 - 2 * 15, 10);
        }
    }
}



@end
