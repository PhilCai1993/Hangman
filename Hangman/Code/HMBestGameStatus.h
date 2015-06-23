//
//  HMGameStatus.h
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "PHDynamicObject.h"
//记录分数
@interface HMBestGameStatus : PHDynamicObject
+ (instancetype)bestGameStatus;
@property (nonatomic, copy) NSNumber *correctWordCount;
@property (nonatomic, copy) NSNumber *score;
@property (nonatomic, copy) NSNumber *totalWordCount;
@property (nonatomic, copy) NSNumber *totalWrongGuessCount;

@end
