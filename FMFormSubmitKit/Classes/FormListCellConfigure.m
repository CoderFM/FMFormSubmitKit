//
//  FormListCellConfigure.m
//  YaLeGou
//
//  Created by 周发明 on 2019/12/17.
//  Copyright © 2019 y. All rights reserved.
//

#import "FormListCellConfigure.h"
#import "FormListUpImageConfigure.h"
#import "FormVerifyManager.h"

@interface FormListCellConfigure ()

@end

@implementation FormListCellConfigure

+ (instancetype)defaultConfigure{
    static FormListCellConfigure *_FormListCellConfigureInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _FormListCellConfigureInstance = [[FormListCellConfigure alloc] init];
        
        _FormListCellConfigureInstance.inputDecimalCount = 2;
        
        _FormListCellConfigureInstance.lrMargin = Form_BaseSize(25);
        _FormListCellConfigureInstance.arrowLMagin = Form_BaseSize(8);
        _FormListCellConfigureInstance.bottomLineDefaultHeight = 0.5;
        _FormListCellConfigureInstance.textDefaultHeight = Form_BaseSize(46);
        _FormListCellConfigureInstance.tfLMagin = Form_BaseSize(82);
        _FormListCellConfigureInstance.textVDefaultHeight = Form_BaseSize(130);
        
        _FormListCellConfigureInstance.bottomLineColor = FormUIColorFromRGB(0xf2f4f5);
        _FormListCellConfigureInstance.titleColor = FormUIColorFromRGB(0x333333);
        _FormListCellConfigureInstance.TFTVColor = FormUIColorFromRGB(0x333333);
        _FormListCellConfigureInstance.imageIntroColor = FormUIColorFromRGB(0x888888);
        
        _FormListCellConfigureInstance.placeholderColor = FormUIColorFromRGB(0x999999);
        _FormListCellConfigureInstance.textTintColor = [UIColor blackColor];
        
        _FormListCellConfigureInstance.tvTitleTopMargin = Form_BaseSize(16);
        
        _FormListCellConfigureInstance.titleFont = [UIFont systemFontOfSize:Form_BaseSize(14)];
        _FormListCellConfigureInstance.TFTVFont = [UIFont systemFontOfSize:Form_BaseSize(14)];
        _FormListCellConfigureInstance.imageIntroFont = [UIFont systemFontOfSize:Form_BaseSize(12)];
        
        
        _FormListCellConfigureInstance.currentConfigure = [FormListUpImageConfigure defaultConfigure];
    });
    return _FormListCellConfigureInstance;
}

@end
