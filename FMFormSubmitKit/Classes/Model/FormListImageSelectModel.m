//
//  FormListImageSelectModel.m
//  ChengXuan
//
//  Created by 周发明 on 2019/11/28.
//  Copyright © 2019 周发明. All rights reserved.
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

- (BOOL)verifySuccess{
    return self.imageUrl && self.imageUrl.length > 0;
}

@end
