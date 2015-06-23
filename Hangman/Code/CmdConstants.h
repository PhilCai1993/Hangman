//
//  CmdConstants.h
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#ifndef CmdConstants_h
#define CmdConstants_h

#define DEBUGLOG 1
#ifdef DEBUGLOG
#       define PHLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#       define PHLog(...)
#endif


#endif /* CmdConstants_h */
