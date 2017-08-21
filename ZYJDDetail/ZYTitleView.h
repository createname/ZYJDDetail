//
//  ZYTitleView.h
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYTitleView : UIScrollView
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)void(^selectIndexBlock)(NSInteger index);
@property(nonatomic,strong)UIView *lineView;
@end
