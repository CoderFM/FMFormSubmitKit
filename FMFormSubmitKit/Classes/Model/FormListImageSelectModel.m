//
//  FormListImageSelectModel.m
//  ChengXuan
//
//  Created by 郑桂华 on 2019/11/28.
//  Copyright © 2019 蔡华荣. All rights reserved.
//

#import "FormListImageSelectModel.h"
#import "FormListConfigure.h"

@implementation FormListImageSelectModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.placeholderImage = [UIImage imageNamed:FormUpCellDefaultImage];
    }
    return self;
}
+ (instancetype)modelWithPlaceholderImageName:(NSString *)imageName{
    FormListImageSelectModel *model = [[self alloc] init];
    model.placeholderImage = [UIImage imageNamed:imageName];
    return model;
}

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    [[NSNotificationCenter defaultCenter] postNotificationName:FormSubmitModelValueChangeNotiKey object:self];
}

@end
