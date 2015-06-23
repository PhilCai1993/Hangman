//
//  PHDynamicObject.h
//  Test @Dynamic
//
//  Created by Phil Cai on 15/6/15.
//  Copyright (c) 2015年 Phil Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  Usage:
 *  1.Create subclass of PHDynamicObject
 *  2.Create properties and make them "@dynamic"
 *  3.Make a singleton
 *  Example:
 *  1.Config.h
 *  2.User.h
 */
@interface PHDynamicObject : NSObject
- (void)resetAll;
@end
