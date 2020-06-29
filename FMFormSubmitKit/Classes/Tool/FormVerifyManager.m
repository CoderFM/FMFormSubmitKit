//
//  FormVerifyManager.m
//  QiaoKeApp
//
//  Created by 周发明 on 2020/3/18.
//

#import "FormVerifyManager.h"

@implementation NSString (FormVerifyManager)

- (BOOL)verifyPredicate:(NSString *)predicate{
    NSPredicate *pre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", predicate];
    return [pre evaluateWithObject:self];
}

@end
