//
//  ZYImageScrollView.m
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYImageScrollView.h"

@implementation ZYImageScrollView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.panGestureRecognizer.delegate = self;
        _isOpen = YES;
    }
    return self;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // 修复轻滑崩溃的bug
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *pan = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat pointX = [pan translationInView:self].x;
        if (!_isOpen && pointX < 0) {
            return NO;
        }else{
            return YES;
        }
        
    }
    return YES;
}

@end
