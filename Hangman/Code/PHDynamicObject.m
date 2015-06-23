//
//  PHDynamicObject.m
//  Test @Dynamic
//
//  Created by Phil Cai on 15/6/15.
//  Copyright (c) 2015年 Phil Cai. All rights reserved.
//

#import "PHDynamicObject.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface PHDynamicObject()
@property (nonatomic, strong) NSUserDefaults *defaults;
@end
@implementation PHDynamicObject

-(instancetype)init{
    self = [super init];
    if (self) {
        self.defaults = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector{
    NSString *selectorName = NSStringFromSelector(aSelector);
    if ([selectorName rangeOfString:@"set"].location==0) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }else {
        return [NSMethodSignature signatureWithObjCTypes:"@@:"];
    }
    return nil;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation{
    SEL selector = [anInvocation selector];
    NSString *selectorName = NSStringFromSelector(selector);
    if ([selectorName rangeOfString:@"set"].location==0) {
        __unsafe_unretained id obj = nil;
        [anInvocation getArgument:&obj atIndex:2];
        NSString *key = [NSString stringWithFormat:@"%@_%@",NSStringFromClass([self class]),[[selectorName lowercaseString] substringWithRange:NSMakeRange(3, selectorName.length-4)]];
        if ([obj isKindOfClass:[NSArray class]] || [obj isKindOfClass:[NSDictionary class]]) {
            [self.defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:obj] forKey:key];
        }else{
            [self.defaults setObject:obj forKey:key];
        }
    }else{
        NSString *key = [NSString stringWithFormat:@"%@_%@",NSStringFromClass([self class]),[selectorName lowercaseString]];
        __unsafe_unretained  id obj = [self.defaults objectForKey:key];
        if ([obj isKindOfClass:[NSData class]]) {
            void *cfValue = (__bridge void *)[NSKeyedUnarchiver unarchiveObjectWithData:obj];
            [anInvocation setReturnValue:&cfValue];
        }else{
            [anInvocation setReturnValue:&obj];
        }
    }
}


- (void)resetAll{
    for (NSString *key in [self propertiesInfo]) {
//        NSLog(@"%@",key);
        NSString *theKey = [NSString stringWithFormat:@"%@_%@",NSStringFromClass([self class]),[key lowercaseString]];
        NSLog(@"reset : %@",theKey);
        [self.defaults removeObjectForKey:theKey];
    }
#ifdef DEBUG
    NSLog(@"reset:%@",self);
#endif
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@:\n%@",NSStringFromClass([self class]),[self propertiesInfo]];
}

#pragma mark - private method
- (NSDictionary *)propertiesInfo{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(property)] ;
        SEL propertySel = NSSelectorFromString(propertyName);
        //        NSObject *value = [self performSelector:propertySel];
        NSObject *value = objc_msgSend(self,propertySel);
        if (value==nil) {
            [props setObject:[NSNull null] forKey:propertyName];
        }else{
            [props setObject:value forKey:propertyName];
        }
    }
    free(properties);
    return props;
}

@end
