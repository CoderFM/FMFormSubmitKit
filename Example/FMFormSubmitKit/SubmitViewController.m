//
//  SubmitViewController.m
//  FormSubmitList
//
//  Created by 郑桂华 on 2019/12/20.
//  Copyright © 2019 郑桂华. All rights reserved.
//

#import "SubmitViewController.h"
#import "FMUpImageItemView.h"
#import <FormListUpImageConfigure.h>

@interface SubmitViewController ()

@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"表单样式"];
    [FormListCellConfigure defaultConfigure].selectNormalImage = [UIImage imageNamed:@"base_choose_no"];
    [FormListCellConfigure defaultConfigure].selectSelectedImage = [UIImage imageNamed:@"base_choose_yes"];
    [FormListCellConfigure defaultConfigure].eyeNormalImage = [UIImage imageNamed:@"login_eye_no"];
    [FormListCellConfigure defaultConfigure].eyeSelectedImage = [UIImage imageNamed:@"login_eye_yes"];
}

- (void)addData{
    {
        FormListBaseModel *model = [FormListBaseModel modelWithCellHeight:5 bottomLineHeight:5 bottomLineLRMargin:0];
        [self.dataSource addObject:model];
    }
    {
        FormListBaseModel *model = [FormListBaseModel modelWithCellHeight:10 bottomLineHeight:5 bottomLineLRMargin:10];
        [self.dataSource addObject:model];
    }
    {
        FormListBaseModel *model = [FormListBaseModel modelWithCellHeight:10 bottomLineHeight:1 bottomLineLRMargin:0];
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:@"元" title:@"文本输入"];
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@"文本输入"];
        model.alignment = NSTextAlignmentLeft;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@""];
        model.textFLeftMargin = FormCellLRMargin;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@""];
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@""];
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        model.eyeEnable = YES;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请选择" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:[UIImage imageNamed:@"mine_arrow_right_black"] title:@""];
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请选择" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:[UIImage imageNamed:@"mine_arrow_right_black"] title:@"选择"];
        [self.dataSource addObject:model];
    }
    {
        FormListSelectModel *model = [FormListSelectModel modelWithTitle:@"单选类型"];
        model.selects = @[@"选择1", @"选择2"];
        [self.dataSource addObject:model];
    }
    
    {
        FormListImageUpModel *model = [[FormListImageUpModel alloc] init];
        model.images = @[@"1", @"2", @"3", @"4", ];
        model.imageConfigure.imageViewClass = [FMUpImageItemView class];
        model.canDynamicAdd = NO;
//        model.maxCount = 8;
        [model setRefreshBlock:^{
            [self.tableView reloadData];
        }];
        [self.dataSource addObject:model];
    }
    
    ///多种类型
    [self.tableView reloadData];
    
}


@end
