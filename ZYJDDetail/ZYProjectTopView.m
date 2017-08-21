//
//  ZYProjectTopView.m
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYProjectTopView.h"
#import "ZYProjectImageView.h"

#define screentWidth [UIScreen mainScreen].bounds.size.width
#define screentHeight [UIScreen mainScreen].bounds.size.height
@interface ZYProjectTopView()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)ZYProjectImageView *imageView;
//添加在头部视图的tempScrollView
@property (nonatomic, strong) UIScrollView *tempScrollView;
@end
@implementation ZYProjectTopView
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screentWidth, CGRectGetHeight(self.frame)-60)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self setUpHeadView];
    }
    return _tableView;
}
-(ZYProjectImageView *)imageView{
    if (!_imageView) {
        _imageView = [[ZYProjectImageView alloc]initWithFrame:CGRectMake(0, 0, screentWidth, screentWidth-30)];
        [_imageView setImagesArray:@[@"0", @"1", @"2", @"3", @"4", @"5"]];
    }
    return _imageView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.tableView];
    }
    return self;
}

-(void)setUpHeadView{
    UIView*headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screentWidth, screentWidth-30)];
    headerView.backgroundColor = [UIColor whiteColor];
    _tempScrollView = [[UIScrollView alloc] initWithFrame:headerView.frame];
    [headerView addSubview:_tempScrollView];
    [_tempScrollView addSubview:self.imageView];
    self.tableView.tableHeaderView = headerView;
}

#pragma mark- UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == self.tableView){
        //重新赋值，就不会有用力拖拽时的回弹
        _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, 0);
        if (offset >= 0 && offset <= screentWidth) {
            //因为tempScrollView是放在tableView上的，tableView向上速度为1，实际上tempScrollView的速度也是1，此处往反方向走1/2的速度，相当于tableView还是正向在走1/2，这样就形成了视觉差！
            _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, - offset / 2.0f);
        }
    }
    
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGFloat offset = scrollView.contentOffset.y;
    if (scrollView == self.tableView) {
        if (offset > (self.tableView.contentSize.height - screentHeight + 80)) {
            if (self.moveDownBlock) {
                _moveDownBlock();
            }
        }
    }
}

#pragma mark- UITableViewDelegate DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 16;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"123";
    return cell;
}


@end
