//
//  HMParameter.h
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HMRequestType.h"
@class HMValue;
@interface HMParameter : NSObject
+ (NSDictionary *)parameter:(HMRequestType)requestType otherValue:(HMValue *)otherValue;
@end
