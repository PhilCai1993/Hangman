//
//  HMGameInfo.h
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "PHDynamicObject.h"

@interface HMGameInfo : PHDynamicObject
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSNumber *numberOfGuessAllowedForEachWord;
@property (nonatomic, copy) NSNumber *numberOfWordsToGuess;
+ (instancetype) currentGameInfo;
@end
