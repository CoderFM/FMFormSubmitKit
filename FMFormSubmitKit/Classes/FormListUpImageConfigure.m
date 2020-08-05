//
//  FormListUpImageConfigure.m
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/18.
//

#import "FormListUpImageConfigure.h"
#import <Masonry/Masonry.h>
#import "FormListImageSelectModel.h"

@interface FormListUpImageConfigure ()

@end

@implementation FormListUpImageConfigure

- (id)copyWithZone:(NSZone *)zone{
    FormListUpImageConfigure *con = [[self class] allocWithZone:zone];
    con.direction = self.direction;
    con.totalWidth = self.totalWidth;
    con.inset = self.inset;
    con.imageLineSpace = self.imageLineSpace;
    con.imageItemSpace = self.imageItemSpace;
    con.imageHeight = self.imageHeight;
    con.imageWidth = self.imageWidth;
    con.placeholderImage = self.placeholderImage;
    con.column = self.column;
    con.imageViewClass = self.imageViewClass;
    con.masony_makeBlock = [self.masony_makeBlock copy];
    con.createAddModel = [self.createAddModel copy];
    return con;
}

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
            _masony_makeBlock = ^(MASConstraintMaker * _Nonnull maker, NSInteger index){
                NSInteger currentIndex = index;
                NSInteger currentLine = 0;
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
        }
    }
    return _masony_makeBlock;
}

- (FormListImageSelectModel *_Nonnull (^)(void))createAddModel{
    if (_createAddModel == nil) {
        __weak typeof(self) weakSelf = self;
        _createAddModel = ^{
            FormListImageSelectModel *model = [[FormListImageSelectModel alloc] init];
            model.placeholderImage = weakSelf.placeholderImage;
            return model;
        };
    }
    return _createAddModel;
}

+ (instancetype)defaultConfigure{
    FormListUpImageConfigure *con = [[self alloc] init];
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

+ (instancetype)configureWithInset:(UIEdgeInsets)inset lineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace imageSize:(CGSize)imageSize column:(NSInteger)column{
    FormListUpImageConfigure *con = [[self alloc] init];
    con.totalWidth = [UIScreen mainScreen].bounds.size.width;
    con.inset = inset;
    con.imageLineSpace = lineSpace;
    con.imageItemSpace = itemSpace;
    con.imageWidth = imageSize.width;
    con.imageHeight = imageSize.height;
    con.column = column;
    return con;
}

- (CGFloat)heightWithCount:(NSInteger)count{
    NSInteger singleCount = self.column;
    NSInteger lines = count % singleCount == 0 ? (count / singleCount) : (count / singleCount + 1);
    return self.inset.top + lines * self.imageHeight + (lines > 0 ? lines - 1 : 0) * self.imageLineSpace + self.inset.bottom;
}

- (void)oneLineScrollMasonyMake{
    __weak typeof(self) weakSelf = self;
    self.masony_makeBlock = ^(MASConstraintMaker * _Nonnull make, NSInteger index) {
        make.left.mas_equalTo(weakSelf.inset.left + index * (weakSelf.imageWidth + weakSelf.imageItemSpace));
        make.top.mas_equalTo(weakSelf.inset.top);
        make.width.mas_equalTo(weakSelf.imageWidth);
        make.height.mas_equalTo(weakSelf.imageHeight);
    };
}

@end
