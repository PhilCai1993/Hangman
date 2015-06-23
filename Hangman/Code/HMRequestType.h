//
//  HMRequestType.h
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSInteger {
    HMRequestTypeStartGame,//Start Game
    HMRequestTypeGiveMeAWord,//Give Me A Word
    HMRequestTypeMakeAGuess,//Make A Guess
    HMRequestTypeGetYourResult,//Get Your Result
    HMRequestTypeSubmitYourResult,//Submit Your Result
} HMRequestType;
