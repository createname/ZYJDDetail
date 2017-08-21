//
//  ZYProjectImageView.m
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYProjectImageView.h"
#import "ZYPageView.h"
#import "ZYImageScrollView.h"
@interface ZYProjectImageView()<UIScrollViewDelegate>
@property(nonatomic,strong)ZYPageView *pageView;
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,strong)ZYImageScrollView *imgScrollView;

@end
@implementation ZYProjectImageView
-(UIScrollView *)imgScrollView{
    if (!_imgScrollView) {
        _imgScrollView = [[ZYImageScrollView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _imgScrollView.contentSize = CGSizeMake(self.bounds.size.width * 3, self.bounds.size.height);
        _imgScrollView.pagingEnabled = YES;
        _imgScrollView.bounces = NO;
        _imgScrollView.showsHorizontalScrollIndicator = NO;
        _imgScrollView.showsVerticalScrollIndicator = NO;
        _imgScrollView.delegate = self;
    }
    return _imgScrollView;
}
-(ZYPageView *)pageView{
    if (!_pageView) {
        _pageView = [[ZYPageView alloc]initWithFrame:CGRectMake(self.bounds.size.width - 50, self.bounds.size.height - 40, 30, 30)];
        _pageView.text = [NSString stringWithFormat:@"%zd/%zd", _currentIndex + 1, _imagesArray.count];
        _pageView.layer.zPosition = 1.6f;
    }
    return _pageView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

-(void)setImagesArray:(NSArray *)imagesArray{
    _imagesArray = imagesArray;
    _currentIndex = 0;
    [self addSubview:self.imgScrollView];
    _imgScrollView.contentSize = CGSizeMake(self.bounds.size.width * imagesArray.count, self.bounds.size.height);
    for (int i = 0; i < imagesArray.count; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = CGRectMake(i * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        imageView.image = [UIImage imageNamed:imagesArray[i]];
        [self.imgScrollView addSubview:imageView];
        
        imageView.userInteractionEnabled = YES;
    }
    [self addSubview:self.pageView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat xOffset = scrollView.contentOffset.x;
    //设置偏移
    int index = xOffset / self.bounds.size.width;
    UIImageView *imageView = scrollView.subviews[index];
    CGRect frame = imageView.frame;
    frame.origin.x = index *self.bounds.size.width + xOffset / 2 - (index * self.bounds.size.width) / 2;
    imageView.frame = frame;
    //设置页码
    [self pageNumberViewAnimation:xOffset];
    // scrollView手势开关
    BOOL isLeft = [scrollView.panGestureRecognizer translationInView:self].x < 0 ? YES : NO;
    if (index == _imagesArray.count - 1 && isLeft) {

        self.imgScrollView.isOpen = NO;
    } else {

        self.imgScrollView.isOpen = YES;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x / self.bounds.size.width;
    if (index == _imagesArray.count - 1) {
        self.imgScrollView.isOpen = NO;
    }else{
        self.imgScrollView.isOpen = YES;
    }
}



-(void)pageNumberViewAnimation:(CGFloat)xOffset{
    //超过一半
    int page = (int)(xOffset / self.imgScrollView.bounds.size.width + 0.5);
    //当前页码
    int index = xOffset / self.imgScrollView.bounds.size.width;
    self.currentIndex = page;
    CGFloat tmpOffset;
    if (page > index) {
        //超过一半动画参数
        tmpOffset = xOffset - page *self.imgScrollView.bounds.size.width;
    }else{
        tmpOffset = xOffset - index * self.imgScrollView.bounds.size.width;
    }
    self.pageView.layer.transform = CATransform3DMakeRotation(tmpOffset * M_PI / self.bounds.size.width, 0, 1, 0);
}

-(void)setCurrentIndex:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    self.pageView.text = [NSString stringWithFormat:@"%zd/%zd", _currentIndex + 1, _imagesArray.count];
}
@end
