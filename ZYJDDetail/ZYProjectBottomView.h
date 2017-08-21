//
//  ZYProjectBottomView.h
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "JKRProjectDetailView.h"
typedef void(^moveUpBlock)();
@interface ZYProjectBottomView : JKRProjectDetailView<UIScrollViewDelegate>
@property (nonatomic, strong) moveUpBlock block;
@end
