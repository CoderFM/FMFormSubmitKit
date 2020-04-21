//
//  FMUpImageItemView.m
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/4/21.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMUpImageItemView.h"

@interface FMUpImageItemView ()

@property(nonatomic, weak)UIButton *btn;

@end

@implementation FMUpImageItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *btn = [[UIButton alloc] init];
        btn.backgroundColor = [UIColor redColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(addImageClick) forControlEvents:UIControlEventTouchUpInside];
        self.btn = btn;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.btn.frame = self.bounds;
}

@end
