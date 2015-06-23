//
//  HMGameStatus.m
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMBestGameStatus.h"

@implementation HMBestGameStatus
@dynamic correctWordCount, score, totalWordCount, totalWrongGuessCount;
+ (instancetype)bestGameStatus{
    static HMBestGameStatus *best;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        best = [[self alloc] init];
    });
    return best;
}
@end
