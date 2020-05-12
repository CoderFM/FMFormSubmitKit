//
//  FormVerifyManager.h
//  QiaoKeApp
//
//  Created by 郑桂华 on 2020/3/18.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///字符数字中文下划线中划线
#define FormVerifyUnsigned @"[A-Za-z0-9_\-\u4e00-\u9fa5]+"
///手机号匹配
#define FormVerifyMobile @"0?(13|14|15|16|18|17|19)[0-9]{9}"
///身份证号
#define FormVerifyCardNo @"\d{17}[\d|x]|\d{15}"
///纯数字
#define FormVerifyOnlyNumber @"[0-9]+"
///纯字母
#define FormVerifyOnlyLetter @"[A-Za-z]+"
///数字字母
#define FormVerifyLetterNumber @"[0-9A-Za-z]+"
///中文
#define FormVerifyOnlyChinese @"[\u4e00-\u9fa5]+"
///中文+数字+字母
#define FormVerifyChineseLetterNumber @"[A-Za-z0-9\u4e00-\u9fa5]+"
///字符密码
#define FormVerifyPassword @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,20}"
///小数
#define FormVerifyDecimal @"(([0]|(0[.]\\d{0,2}))|([1-9]\\d{0,8}(([.]\\d{0,2})?)))?"


@interface NSString (FormVerifyManager)

- (BOOL)verifyPredicate:(NSString *)predicate;

@end

NS_ASSUME_NONNULL_END
