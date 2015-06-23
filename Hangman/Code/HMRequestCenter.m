//
//  HMRequestCenter.m
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMRequestCenter.h"
#import "HMParameter.h"
NSString *const kRequestBaseURL = @"https://strikingly-hangman.herokuapp.com/game/on";
NSInteger const kTimeoutInterval = 15;
@implementation HMRequestCenter
#pragma mark - POST & Response Handler
- (void )requestJsonDataWithType:(HMRequestType)requestType otherValue:(HMValue *)otherValue completion:(HMRequestHandler)completionBlock {
    NSDictionary *parameters =[HMParameter parameter:requestType otherValue:otherValue];
 [self POST:@"" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        PHLog(@"URL:\n%@\nparameter:\n%@",operation.request.URL.absoluteString,parameters);
        PHLog(@"success\n%@",responseObject);
        NSDictionary *responseInfo = responseObject;
        completionBlock(YES, responseInfo);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        PHLog(@"URL:%@",operation.request.URL.absoluteString);
        PHLog(@"fail:\n%@",error.userInfo);
        completionBlock(NO,error.userInfo);
    }];
}
#pragma mark - init
+ (instancetype)requestCenter{
    static HMRequestCenter *_requestCenter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _requestCenter = [[self alloc] initWithBaseURL:[NSURL URLWithString:kRequestBaseURL]];
    });
    return _requestCenter;
}
- (instancetype)initWithBaseURL:(NSURL *)url{
    self = [super initWithBaseURL:url];
    if (self) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer.timeoutInterval = kTimeoutInterval;
    }
    return self;
}


@end
