//
//  HMValue.h
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
//用来填写一些需要变化的参数内容
@interface HMValue : NSObject
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *guess;
@end
