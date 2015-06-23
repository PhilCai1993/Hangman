//
//  HMGameInfo.m
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMGameInfo.h"

@implementation HMGameInfo
@dynamic sessionId;
@dynamic numberOfGuessAllowedForEachWord;
@dynamic numberOfWordsToGuess;

+ (instancetype)currentGameInfo {
    static HMGameInfo *gameInfo;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        gameInfo = [[self alloc] init];
    });
    return gameInfo;
}
@end
