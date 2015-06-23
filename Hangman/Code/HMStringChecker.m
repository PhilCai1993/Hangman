//
//  HMStringChecker.m
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMStringChecker.h"

@implementation HMStringChecker
+ (BOOL)isEnglish:(NSString *)string {
    NSString *reg = @"^[A-Z]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",reg];
    return [predicate evaluateWithObject:string];
}
@end
