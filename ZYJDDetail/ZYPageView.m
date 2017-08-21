//
//  ZYPageView.m
//  ZYJDDetail
//
//  Created by liqiaona on 2017/8/17.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "ZYPageView.h"

@interface ZYPageView()
@property(nonatomic,strong)UILabel *textLabel;
@end
@implementation ZYPageView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.image = [UIImage imageNamed:@"product_page"];
        self.backgroundColor = [UIColor colorWithRed:217/255.f green:217/255.f blue:217/255.f alpha:1.0];
        self.layer.cornerRadius = self.frame.size.width/2;
        self.layer.masksToBounds = YES;
        self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.textLabel];
    }
    return self;
}
-(void)setText:(NSString *)text{
    _text = text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12]}];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 1)];
    self.textLabel.attributedText = attributedString;
}
-(void)setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.textLabel.textColor = textColor;
}
@end
