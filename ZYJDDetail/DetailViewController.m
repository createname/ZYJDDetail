//
//  DetailViewController.m
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "DetailViewController.h"
#import "ZYTitleView.h"
#import "ZYProjectViewController.h"
#import "ZYDetailViewController.h"
#import "ZYCommentViewController.h"

@interface DetailViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)ZYTitleView *titleView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)ZYProjectViewController *projectVC;
@property(nonatomic,strong)ZYDetailViewController *detailVC;
@property(nonatomic,strong)ZYCommentViewController *commentVC;

@property(nonatomic,strong)UIView *bottomView;

/**
 弹出的View
 */
@property(nonatomic,strong)UIView *showView;
@end

@implementation DetailViewController

-(UIView *)showView{
    if (!_showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 150)];
        _showView.backgroundColor = [UIColor redColor];
    }
    return _showView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.bounds.size.height - 60, self.view.bounds.size.width, 60)];
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
        [button setTitle:@"加入" forState:0];
        [button setBackgroundColor:[UIColor redColor]];
        [button addTarget:self action:@selector(addCart:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView addSubview:button];
    }
    return _bottomView;
}
-(ZYTitleView *)titleView{
    if (!_titleView) {
        _titleView = [[ZYTitleView alloc]init];
        [_titleView setArray:@[@"商品",@"详情",@"评价"]];
        __weak __typeof(self)weakSelf = self;
        [_titleView setSelectIndexBlock:^(NSInteger index){
            [weakSelf.scrollView setContentOffset:CGPointMake(CGRectGetWidth(weakSelf.scrollView.frame)*index, 0) animated:YES];
           
        }];
    }
    return _titleView;
}

-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height)];
        _scrollView.contentSize = CGSizeMake(self.view.bounds.size.width * 3, self.view.bounds.size.height);
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return _scrollView;
}
-(ZYProjectViewController *)projectVC{
    if (!_projectVC) {
        _projectVC = [[ZYProjectViewController alloc]init];
    }
    return _projectVC;
}
-(ZYDetailViewController *)detailVC{
    if (!_detailVC) {
        _detailVC = [[ZYDetailViewController alloc]init];
    }
    return _detailVC;
}
-(ZYCommentViewController *)commentVC{
    if (!_commentVC) {
        _commentVC = [[ZYCommentViewController alloc]init];
    }
    return _commentVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.titleView = self.titleView;
    [self.view addSubview:self.scrollView];
    [self addChildVC];
    
    [self.view addSubview:self.bottomView];
}

-(void)addChildVC{
    [self addChildViewController:self.projectVC];
    [self addChildViewController:self.detailVC];
    [self addChildViewController:self.commentVC];
    __weak __typeof(self)weakSelf = self;
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.view.frame = CGRectMake(idx * weakSelf.scrollView.bounds.size.width, 0, weakSelf.scrollView.bounds.size.width, weakSelf.scrollView.bounds.size.height);
        [weakSelf.scrollView addSubview:obj.view];
    }];
}

/**
 设置选择效果

 @return return value description
 */
- (CATransform3D)firstTransform{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 0.95, 0.95, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15.0 * M_PI/180.0, 1, 0, 0);
    return t1;
    
}

/**
 恢复

 @return return value description
 */
- (CATransform3D)firstTransform2{
    CATransform3D t1 = CATransform3DIdentity;
    t1.m34 = 1.0/-900;
    
    //带点缩小的效果
    t1 = CATransform3DScale(t1, 1, 1, 1);
    //绕x轴旋转
    t1 = CATransform3DRotate(t1, 15 * M_PI/180.0, 1, 0, 0);
    return t1;
    
}
-(void)addCart:(UIButton *)sender{
//    sender.selected = !sender.selected;
//    if (sender.selected) {
//        
//        [UIView animateWithDuration:0.3 animations:^{
//            
//            [self.navigationController.view.layer setTransform:[self firstTransform]];
//            UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
//            [window addSubview:self.showView];
//        }completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.3 animations:^{
//                self.navigationController.view.transform = CGAffineTransformMakeScale(0.9, 0.95);//旋转完成以后页面缩小 同事改变黄色页面的frame的y值
//                CGRect rect = self.showView.frame;
//                rect.origin.y = self.view.bounds.size.height - rect.size.height;
//                self.showView.frame = rect;
//            } ];
//        }];
//    }else{
//        [UIView animateWithDuration:0.5 animations:^{
//            CGRect rect = self.showView.frame;
//            rect.origin.y = self.view.bounds.size.height;
//            self.showView.frame = rect;
//            [self.navigationController.view.layer setTransform:[self firstTransform2]];
//        }completion:^(BOOL finished) {
//            [self.showView removeFromSuperview];
//            [UIView animateWithDuration:0.5 animations:^{
//                self.navigationController.view.transform = CGAffineTransformMakeScale(1, 1);
//            }];
//            
//        }];
//    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat xOffset = scrollView.contentOffset.x;
    int index = xOffset / self.view.bounds.size.width;
    CGRect rect = self.titleView.lineView.frame;
    rect.origin.x = 60 * index;
    [UIView animateWithDuration:0.2 animations:^{
        
        self.titleView.lineView.frame = rect;
    }];
    
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
