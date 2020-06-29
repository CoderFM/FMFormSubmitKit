//
//  SubmitViewController.m
//  FormSubmitList
//
//  Created by 周发明 on 2019/12/20.
//  Copyright © 2019 周发明. All rights reserved.
//

#import "SubmitViewController.h"
#import "FMUpImageItemView.h"
#import <FormListUpImageConfigure.h>

#import <AudioToolbox/AudioToolbox.h>

#import "FMSelectManager.h"

@interface SubmitViewController ()

@end

@implementation SubmitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"表单样式"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStyleDone target:self action:@selector(submitClick)];
    [FormListCellConfigure defaultConfigure].selectNormalImage = [UIImage imageNamed:@"base_choose_no"];
    [FormListCellConfigure defaultConfigure].selectSelectedImage = [UIImage imageNamed:@"base_choose_yes"];
    [FormListCellConfigure defaultConfigure].eyeNormalImage = [UIImage imageNamed:@"login_eye_no"];
    [FormListCellConfigure defaultConfigure].eyeSelectedImage = [UIImage imageNamed:@"login_eye_yes"];
    
    [FormListCellConfigure defaultConfigure].inputDecimalCount = 4;
    
    [FMSelectManager manager];
    
//    [self addData];
}

- (void)submitClick{
    NSLog(@"%@", self.tableView.submitParam);
//    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlaySystemSound(1519);
}

- (void)addData{
    {
        FormListBaseModel *model = [FormListBaseModel modelWithCellHeight:5 bottomLineHeight:5 bottomLineLRMargin:0];
        [self.dataSource addObject:model];
    }
    {
        FormListBaseModel *model = [FormListBaseModel modelWithCellHeight:10 bottomLineHeight:5 bottomLineLRMargin:10];
        model.bottomLineBMargin = 2;
        model.bottomLineLMargin = 50;
        [self.dataSource addObject:model];
    }
    {
        FormListBaseModel *model = [FormListBaseModel modelWithCellHeight:10 bottomLineHeight:1 bottomLineLRMargin:0];
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:@"元" title:@"文本输入"];
        model.submitKey = @"money";
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@"文本输入"];
        model.alignment = NSTextAlignmentLeft;
        model.submitKey = @"text";
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入(支持emoji表情输入)" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@""];
        model.textFLeftMargin = FormCellLRMargin;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入(不支持emoji表情输入)" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@""];
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        model.inputPredicate = FormVerifyOnlyChinese;
        model.limitCount = 55;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入" keyboardType:UIKeyboardTypeDefault hasRight:NO righrContent:nil title:@""];
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        model.eyeEnable = YES;
        [model setTextLengthChange:^(NSInteger length) {
            
        }];
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入小数" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:[UIImage imageNamed:@"mine_arrow_right_black"] title:@""];
        model.inputPredicate = FormVerifyOnlyDecimal;
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入纯中文" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:[UIImage imageNamed:@"mine_arrow_right_black"] title:@""];
        model.inputPredicate = FormVerifyOnlyChinese;
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入纯英文" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:[UIImage imageNamed:@"mine_arrow_right_black"] title:@""];
        model.inputPredicate = FormVerifyOnlyLetter;
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请输入纯数字" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:[UIImage imageNamed:@"mine_arrow_right_black"] title:@""];
        model.inputPredicate = FormVerifyOnlyNumber;
        model.textFLeftMargin = FormCellLRMargin;
        model.alignment = NSTextAlignmentLeft;
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithPlaceholder:@"请选择" keyboardType:UIKeyboardTypeDefault hasRight:YES righrContent:[UIImage imageNamed:@"mine_arrow_right_black"] title:@"选择"];
        model.isSelect = YES;
        [model setSelectBlock:^(id  _Nonnull tftv, FormListTextModel * _Nonnull model) {
            [[FMSelectManager manager] showSelectTimeWithMiddleTitle:@"时间" okBlock:^(NSDate *date) {
                
            }];
        }];
        [self.dataSource addObject:model];
    }
    {
        FormListSelectModel *model = [FormListSelectModel modelWithTitle:@"单选类型"];
        model.selects = @[@"选择1", @"选择2"];
        model.submitKey = @"select";
        [self.dataSource addObject:model];
    }
    
    {
        FormListImageUpModel *model = [[FormListImageUpModel alloc] init];
        FormListImageSelectModel *selModel = [[FormListImageSelectModel alloc] init];
        selModel.submitKey = @"image0";
        selModel.imageUrl = @"image0.imageUrl";
        FormListImageSelectModel *selModel1 = [[FormListImageSelectModel alloc] init];
        FormListImageSelectModel *selModel2 = [[FormListImageSelectModel alloc] init];
        FormListImageSelectModel *selModel3 = [[FormListImageSelectModel alloc] init];
            model.images = [@[selModel, selModel1, selModel2, selModel3, ] mutableCopy];
        model.imageConfigure.imageViewClass = [FMUpImageItemView class];
        model.canDynamicAdd = NO;
//        model.maxCount = 8;
        [model setRefreshBlock:^{
            [self.tableView reloadData];
        }];
        [self.dataSource addObject:model];
    }
    {
        FormListTextModel *model = [FormListTextModel modelWithTVPlaceholder:@"请输入文章内容" title:@""];
        model.alignment = NSTextAlignmentLeft;
        model.cellHeight = 300;
        model.textFLeftMargin = 15;
        model.textVTopMargin = 5;
//        model.isSelect = YES;
        model.limitCount = 10;
        model.submitKey = @"textViewtext";
        model.inputPredicate = FormVerifyOnlyLetter;
        [model setTextLengthChange:^(NSInteger length) {
            
        }];
        [self.dataSource addObject:model];
    }
    {
            FormListImageUpModel *model = [[FormListImageUpModel alloc] init];
        FormListImageSelectModel *selModel = [[FormListImageSelectModel alloc] init];
        selModel.imageUrl = @"image0.imageUrl";
        FormListImageSelectModel *selModel1 = [[FormListImageSelectModel alloc] init];
        selModel1.imageUrl = @"image1.imageUrl";
        FormListImageSelectModel *selModel2 = [[FormListImageSelectModel alloc] init];
        FormListImageSelectModel *selModel3 = [[FormListImageSelectModel alloc] init];
            model.images = [@[selModel, selModel1, selModel2, selModel3, ] mutableCopy];
            model.imageConfigure.imageViewClass = [FMUpImageItemView class];
            model.canDynamicAdd = YES;
            model.maxCount = 8;
        model.submitKey = @"image[]";
            [model setRefreshBlock:^{
                [self.tableView reloadData];
            }];
            [self.dataSource addObject:model];
        }
    ///多种类型
    
    [self.tableView reloadData];
    
}

@end
