//
//  ViewController.m
//  Hangman
//
//  Created by Phil Cai on 15/6/21.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMGameViewController.h"
#import "HMRequestCenter.h"
#import "HMGameInfo.h"
#import "HMValue.h"
#import "YETIMotionLabel.h"
#import "YETIFallingLabel.h"
#import <UIColor+MLPFlatColors.h>
#import "HMMenuViewController.h"
#import "HMBestGameStatus.h"
@interface HMGameViewController ()<HMMenuDelegate>{
    //    NSInteger chanceLeft;
}
@property (weak, nonatomic) IBOutlet YETIMotionLabel *wordLabel;


@property (weak, nonatomic) IBOutlet YETIFallingLabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalChanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWordIndexLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalWordCountLabel;



@end

@implementation HMGameViewController
#pragma mark - init



#pragma mark - viewlife
- (void)viewDidLoad {
    [super viewDidLoad];
    HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
    PHLog(@"..%@",gameInfo);
    self.wordLabel.textColor = [UIColor flatWhiteColor];
    self.infoLabel.textColor = [UIColor flatWhiteColor];
    self.totalChanceLabel.textColor = [UIColor flatWhiteColor];
    self.currentWordIndexLabel.textColor = [UIColor flatWhiteColor];
    self.totalWordCountLabel.textColor = [UIColor flatWhiteColor];
    //    chanceLeft = [gameInfo.numberOfGuessAllowedForEachWord integerValue];
    
    [self giveMeAWord];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
    
    
    self.wordLabel.text = @"";
    self.infoLabel.text = @"Wrong : 0";
    //    self.totalChanceLabel.text = @"Chances : 0";
    self.totalChanceLabel.text = [NSString stringWithFormat:@"Chances : %@",gameInfo.numberOfGuessAllowedForEachWord];
    self.totalWordCountLabel.text = [NSString stringWithFormat:@"Total Word Count : %@",gameInfo.numberOfWordsToGuess];
    self.currentWordIndexLabel.text = [NSString stringWithFormat:@"Current Word Index : 0"];;
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
#pragma mark - layout


- (IBAction)sendRequest:(id)sender {
    if (self.isKeyboardShown) {
        [self hideKeyboard];
    }else{
        [self showKeyboard];
    }
}


#pragma mark - HMKeyboardDelegate
- (void)keyButtonDidPress:(UIButton *)button {
    [self guess:button];
}
- (void)okButtonDidPress:(UIButton *)button {
    //        [self dismissViewControllerAnimated:YES completion:nil];
    //    return;
    PHLog(@"%@",button.titleLabel.text);
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    HMMenuViewController *menu = [sb instantiateViewControllerWithIdentifier:@"HMMenuViewController"];
    menu.delegate = self;
    menu.blurStyle = UIBlurEffectStyleLight;
    [self presentViewController:menu animated:YES completion:^{
        
    }];
}
#pragma mark - request
- (void)giveMeAWord {
    [SVProgressHUD showWithStatus:@"Preparing for the game" maskType:SVProgressHUDMaskTypeBlack];
    
    HMValue *value = [HMValue new];
    value.sessionId = self.sessionId;
    [[HMRequestCenter requestCenter] requestJsonDataWithType:HMRequestTypeGiveMeAWord otherValue:value completion:^(BOOL success, NSDictionary *dict) {
        if (success) {
            NSDictionary *gameData = [dict objectForKey:@"data"];
            if (gameData) {
                [SVProgressHUD dismiss];
                NSString *word = gameData[@"word"];
                NSNumber *totalWordCount = gameData[@"totalWordCount"];
                NSNumber *wrongGuessCountOfCurrentWord = gameData[@"wrongGuessCountOfCurrentWord"];
                [self resetKeyBoard];
                self.wordLabel.text = word;
                //                TODO:
                self.infoLabel.text =[NSString stringWithFormat:@"Wrong : %@",wrongGuessCountOfCurrentWord];
                
                HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
                self.currentWordIndexLabel.text = [NSString stringWithFormat:@"Current Word Index : %@",totalWordCount];
                [self showKeyboard];
                if ([totalWordCount isEqualToNumber:gameInfo.numberOfWordsToGuess]) {
                    [self sessionOver];
                    return ;
                }
            }else {
                NSString *message = [dict objectForKey:@"message"];
                [SVProgressHUD showInfoWithStatus:message];
                
                // TODO:retry
            }
        }else{
            // TODO:retry
            [SVProgressHUD showErrorWithStatus:@"Please Check Your Network"];
        }
    }];
}
- (void)guess:(UIButton *)button {
    [SVProgressHUD showWithStatus:@"Sending" maskType:SVProgressHUDMaskTypeBlack];
    HMValue *value = [HMValue new];
    value.guess = button.titleLabel.text;
    value.sessionId = self.sessionId;
    [[HMRequestCenter requestCenter] requestJsonDataWithType:HMRequestTypeMakeAGuess otherValue:value completion:^(BOOL success, NSDictionary *dict) {
        if (success) {
            NSDictionary *gameData = [dict objectForKey:@"data"];
            if (gameData) {
                NSString *word = gameData[@"word"];
                NSNumber *totalWordCount = gameData[@"totalWordCount"];
                
                NSNumber *wrongGuessCountOfCurrentWord = gameData[@"wrongGuessCountOfCurrentWord"];
                self.wordLabel.text = word;
                self.infoLabel.text = [NSString stringWithFormat:@"Wrong : %@",wrongGuessCountOfCurrentWord];
                self.currentWordIndexLabel.text = [NSString stringWithFormat:@"Current Word Index : %@",totalWordCount];
                button.hidden = YES;
                if ([HMStringChecker isEnglish:word]) {
                    PHLog(@"GAME OVER");
                    [self gameOver];
                }else{
                    PHLog(@"GAME NOT OVER");
                    if ([wrongGuessCountOfCurrentWord isEqualToNumber:[HMGameInfo currentGameInfo].numberOfGuessAllowedForEachWord]) {
                        [self hideKeyboard];
                        [SVProgressHUD showInfoWithStatus:@"Failed, NeXT."];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self giveMeAWord];
                        });
                        return;
                    }
                }
                
                [SVProgressHUD dismiss];
                
            }else {
                NSString *message = [dict objectForKey:@"message"];
                [SVProgressHUD showInfoWithStatus:message];
            }
        }else {
            [SVProgressHUD showErrorWithStatus:@"Please Check Your Network"];
        }
    }];
}

- (void)getYourResult {
    [SVProgressHUD showWithStatus:@"Getting Result" maskType:SVProgressHUDMaskTypeBlack];
    HMValue *value = [HMValue new];
    value.sessionId = self.sessionId;
    [[HMRequestCenter requestCenter] requestJsonDataWithType:HMRequestTypeGetYourResult otherValue:value completion:^(BOOL success, NSDictionary *dict) {
        if(success){
            NSDictionary *resultData = [dict objectForKey:@"data"];
            HMBestGameStatus *bestStatus = [HMBestGameStatus bestGameStatus];
            bestStatus.correctWordCount = resultData[@"correctWordCount"];
            bestStatus.score = resultData[@"score"];
            bestStatus.totalWrongGuessCount = resultData[@"totalWrongGuessCount"];
            bestStatus.totalWordCount = resultData[@"totalWordCount"];
            [SVProgressHUD showInfoWithStatus:[NSString stringWithFormat:@"Score : %@",bestStatus.score] maskType:SVProgressHUDMaskTypeBlack];
        }else{
            [SVProgressHUD showInfoWithStatus:@"Please Check Your Network"];
        }
    }];
}

- (void)submitYourResult {
    [SVProgressHUD showWithStatus:@"Wait while submitting" maskType:SVProgressHUDMaskTypeBlack];
    HMValue *value = [HMValue new];
    value.sessionId = self.sessionId;
    [[HMRequestCenter requestCenter] requestJsonDataWithType:HMRequestTypeSubmitYourResult otherValue:value completion:^(BOOL success, NSDictionary *dict) {
        if (success) {
            [SVProgressHUD dismiss];
            [[HMGameInfo currentGameInfo] resetAll];
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }else{
            [SVProgressHUD showInfoWithStatus:@"Please Check Your Network"];
        }
    }];
}




#pragma mark - Game Over and Session OVer
- (void)gameOver {
    [self resetKeyBoard];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HMMenuViewController *menu = [sb instantiateViewControllerWithIdentifier:@"HMMenuViewController"];
    menu.blurStyle = UIBlurEffectStyleLight;
    [self presentViewController:menu animated:YES completion:^{
        
    }];
}
- (void)sessionOver {
    //    TODO:
    [self resetKeyBoard];
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    HMMenuViewController *menu = [sb instantiateViewControllerWithIdentifier:@"HMMenuViewController"];
    menu.blurStyle = UIBlurEffectStyleLight;
    [self presentViewController:menu animated:YES completion:^{
        
    }];
}
#pragma mark - HMMenuDelegate
- (void)hmMenuNextAction{
    [self giveMeAWord];
    PHLog(@" ");
}
- (void)hmMenuSeeResultAction {
    [self getYourResult];
    PHLog(@" ");
}
- (void)hmMenuSubmitAction {
    [self submitYourResult];
    PHLog(@" ");
}
- (void)hmMenuQuitGameAction {
    [self dismissViewControllerAnimated:YES completion:nil];
    PHLog(@" ");
}
@end
