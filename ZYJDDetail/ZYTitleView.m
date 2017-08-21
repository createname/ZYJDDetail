//
//  ZYTitleView.m
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYTitleView.h"

@implementation ZYTitleView
static const CGFloat btnWidht = 40.0;
static const CGFloat btnSpace = 20.0;

-(UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]initWithFrame:CGRectMake(0, 43, btnWidht, 1.5)];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.scrollEnabled = NO;
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    self.frame = CGRectMake(0, 0, (btnWidht + btnSpace) * array.count - btnSpace, 44);
    for (int i = 0; i < array.count; i++) {
        UIButton *button = [UIButton buttonWithType:0];
        button.frame = CGRectMake(i * (btnWidht + btnSpace), 0, btnWidht, 42);
        [button setTitle:array[i] forState:0];
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:0];
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:16.0];
        [self addSubview:button];
        
    }
    
    [self addSubview:self.lineView];
    
    UIView *nextTitleView =[[UIView alloc]initWithFrame:CGRectMake(0, 44, (btnWidht + btnSpace) * array.count - btnSpace, 44)];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:nextTitleView.bounds];
    titleLabel.text = @"图文详情";
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [nextTitleView addSubview:titleLabel];
    [self addSubview:nextTitleView];
}

-(void)btnClick:(UIButton *)btn{
    if (_selectIndexBlock) {
        CGRect rect = self.lineView.frame;
        rect.origin.x = btn.tag * 60;
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = rect;
        }];
        _selectIndexBlock(btn.tag);
    }
}

@end
