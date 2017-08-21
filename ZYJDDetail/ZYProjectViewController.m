//
//  ZYProjectViewController.m
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYProjectViewController.h"
#import "ZYProjectTopView.h"
#import "ZYProjectBottomView.h"
#import "ZYTitleView.h"
#define screentWidth [UIScreen mainScreen].bounds.size.width
#define screentHeight [UIScreen mainScreen].bounds.size.height
@interface ZYProjectViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)ZYProjectTopView *topView;
@property(nonatomic,strong)ZYProjectBottomView *bottomView;
@end

@implementation ZYProjectViewController
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, screentWidth, screentHeight * 2)];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return _contentView;
}

-(ZYProjectTopView *)topView{
    if (!_topView) {
        _topView = [[ZYProjectTopView alloc]initWithFrame:CGRectMake(0, 0, screentWidth, screentHeight)];
    }
    return _topView;
}
-(ZYProjectBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ZYProjectBottomView alloc]initWithFrame:CGRectMake(0, screentHeight, screentWidth, screentHeight)];
    }
    return _bottomView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.contentView];
    [self.contentView addSubview:self.topView];
    [self.contentView addSubview:self.bottomView];
    __weak __typeof(self)weakSelf = self;
    [self.topView setMoveDownBlock:^{
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, - screentHeight);
            ZYTitleView *titleView = (ZYTitleView *)weakSelf.parentViewController.navigationItem.titleView;
            titleView.contentOffset = CGPointMake(0, titleView.bounds.size.height);
            
        }];
    }];
    self.bottomView.block = ^{
        [UIView animateWithDuration:0.4 animations:^{
            weakSelf.contentView.transform = CGAffineTransformTranslate(CGAffineTransformIdentity, 0, 0);
            ZYTitleView *titleView = (ZYTitleView *)weakSelf.parentViewController.navigationItem.titleView;
            titleView.contentOffset = CGPointMake(0, 0);
            
        }];
    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
