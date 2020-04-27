//
//  FMUpImageItemView.m
//  FMFormSubmitKit_Example
//
//  Created by 郑桂华 on 2020/4/21.
//  Copyright © 2020 zhoufaming251@163.com. All rights reserved.
//

#import "FMUpImageItemView.h"
#import <FormListImageSelectModel.h>

@interface FMUpImageItemView ()

@property(nonatomic, weak)UIButton *btn;
@property(nonatomic, weak)UIButton *deleteBtn;
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
        
        UIButton *delete = [[UIButton alloc] init];
        [delete addTarget:self action:@selector(delButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [delete setTitle:@"删" forState:UIControlStateNormal];
        [self addSubview:delete];
        self.deleteBtn = delete;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.btn.frame = self.bounds;
    self.deleteBtn.frame = CGRectMake(0, 0, 30, 30);
}

- (void)setModel:(FormListImageSelectModel *)model{
    [super setModel:model];
    if (model.image) {
        self.btn.backgroundColor = [UIColor orangeColor];
    } else {
        self.btn.backgroundColor = [UIColor redColor];
    }
}

- (void)addImageClick{
    self.model.image = [UIImage new];
    [super addImageClick];
}

- (void)delButtonClick{
    self.model.image = nil;
    [super delButtonClick];
}

@end
