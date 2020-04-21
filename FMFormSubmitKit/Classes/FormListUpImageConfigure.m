//
//  FormListUpImageConfigure.m
//  FMFormSubmitKit
//
//  Created by 郑桂华 on 2020/4/18.
//

#import "FormListUpImageConfigure.h"
#import <Masonry/Masonry.h>

@interface FormListUpImageConfigure ()

@end

@implementation FormListUpImageConfigure

- (void (^)(MASConstraintMaker * _Nonnull, NSInteger index))masony_makeBlock{
    if (_masony_makeBlock == nil) {
        __weak typeof(self) weakSelf = self;
        NSInteger singleCount = self.column;
        if (singleCount > 0) {
            _masony_makeBlock = ^(MASConstraintMaker * _Nonnull maker, NSInteger index){
                NSInteger currentIndex = index % singleCount;
                NSInteger currentLine = index / singleCount;
                CGFloat left;
                CGFloat top = weakSelf.inset.top + currentLine * weakSelf.imageHeight + (currentLine == 0 ? 0 : currentLine * weakSelf.imageLineSpace);
                if (weakSelf.direction == FormListUpImageDirectionLTR) {
                    left = weakSelf.inset.left + currentIndex * weakSelf.imageWidth + (currentIndex == 0 ? 0 : currentIndex * weakSelf.imageItemSpace);
                } else {
                    left = weakSelf.totalWidth - weakSelf.inset.right - (currentIndex + 1) * weakSelf.imageWidth - currentIndex * weakSelf.imageItemSpace;
                }
                maker.left.mas_equalTo(left);
                maker.top.mas_equalTo(top);
                maker.width.mas_equalTo(weakSelf.imageWidth);
                maker.height.mas_equalTo(weakSelf.imageHeight);
            };
        } else {
            NSLog(@"上传图片的宽度给的有误   请重新计算");
        }
    }
    return _masony_makeBlock;
}

+ (instancetype)defaultConfigure{
    FormListUpImageConfigure *con = [[FormListUpImageConfigure alloc] init];
    con.totalWidth = [UIScreen mainScreen].bounds.size.width;
    con.inset = UIEdgeInsetsMake(10, 10, 10, 10);
    con.imageItemSpace = 10;
    con.imageLineSpace = 10;
    con.imageWidth = 100;
    con.imageHeight = con.imageWidth;
    con.column = 2;
    con.direction = FormListUpImageDirectionLTR;
    return con;
}

- (CGFloat)heightWithCount:(NSInteger)count{
    NSInteger singleCount = self.column;
    NSInteger lines = count % singleCount == 0 ? (count / singleCount) : (count / singleCount + 1);
    return self.inset.top + lines * self.imageHeight + (lines > 0 ? lines - 1 : 0) * self.imageLineSpace + self.inset.bottom;
}

@end
