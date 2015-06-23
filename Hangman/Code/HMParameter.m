//
//  HMParameter.m
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMParameter.h"
#import "HMValue.h"
NSString *const kPlayerId = @"philcai@yeah.net";
@implementation HMParameter
+ (NSDictionary *)parameter:(HMRequestType)requestType otherValue:(HMValue *)otherValue{
    NSMutableDictionary *tmpParameter = [NSMutableDictionary dictionary];
    switch (requestType) {
        case HMRequestTypeStartGame:
        {
            [tmpParameter setObject:kPlayerId forKey:@"playerId"];
            [tmpParameter setObject:@"startGame" forKey:@"action"];
        }
            break;
        case HMRequestTypeGiveMeAWord:
        {
            [tmpParameter setObject:otherValue.sessionId forKey:@"sessionId"];
            [tmpParameter setObject:@"nextWord" forKey:@"action"];
        }
            break;
        case HMRequestTypeMakeAGuess:
        {
            [tmpParameter setObject:otherValue.sessionId forKey:@"sessionId"];
            [tmpParameter setObject:@"guessWord" forKey:@"action"];
            [tmpParameter setObject:[otherValue.guess uppercaseString] forKey:@"guess"];
        }
            break;
        case HMRequestTypeGetYourResult:
        {
            [tmpParameter setObject:otherValue.sessionId forKey:@"sessionId"];
            [tmpParameter setObject:@"getResult" forKey:@"action"];
        }
            break;
        case HMRequestTypeSubmitYourResult:
        {
            [tmpParameter setObject:otherValue.sessionId forKey:@"sessionId"];
            [tmpParameter setObject:@"submitResult" forKey:@"action"];
        }
            break;
        default:
            break;
    }
    return tmpParameter;
}
@end
