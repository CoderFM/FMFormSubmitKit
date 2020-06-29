//
//  FormListUpImageConfigure.h
//  FMFormSubmitKit
//
//  Created by 周发明 on 2020/4/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    FormListUpImageDirectionLTR,
    FormListUpImageDirectionRTL
} FormListUpImageDirection;

@class MASConstraintMaker, FormListImageSelectModel;
@interface FormListUpImageConfigure : NSObject

@property(nonatomic, assign)FormListUpImageDirection direction;
@property(nonatomic, assign)CGFloat totalWidth;
@property(nonatomic, assign)UIEdgeInsets inset;
@property(nonatomic, assign)CGFloat imageLineSpace;
@property(nonatomic, assign)CGFloat imageItemSpace;
@property(nonatomic, assign)CGFloat imageHeight;
@property(nonatomic, assign)CGFloat imageWidth;

@property(nonatomic, strong)UIImage *placeholderImage;

@property(nonatomic, assign)NSInteger column;

@property(nonatomic, strong)Class imageViewClass;///需要继承自FormListImageUpCellItemView 或者自定义并遵守FormListImageUpCellItemDelegate
@property(nonatomic, copy)void(^masony_makeBlock)(MASConstraintMaker *make, NSInteger index);
@property(nonatomic, copy)FormListImageSelectModel *(^createAddModel)(void);
+ (instancetype)defaultConfigure;
+ (instancetype)configureWithInset:(UIEdgeInsets)inset lineSpace:(CGFloat)lineSpace itemSpace:(CGFloat)itemSpace imageSize:(CGSize)imageSize column:(NSInteger)column;
- (CGFloat)heightWithCount:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
