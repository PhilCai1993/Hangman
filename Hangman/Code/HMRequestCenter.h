//
//  HMRequestCenter.h
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"
#import "HMRequestType.h"
@class HMValue;
typedef void (^HMRequestHandler)(BOOL success,NSDictionary *dict);
@interface HMRequestCenter : AFHTTPRequestOperationManager
+ (instancetype)requestCenter;
- (void)requestJsonDataWithType:(HMRequestType)requestType otherValue:(HMValue *)otherValue completion:(HMRequestHandler)completionBlock;
@end
