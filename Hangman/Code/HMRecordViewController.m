//
//  HMRecordViewController.m
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "HMRecordViewController.h"
#import "YETIMotionLabel.h"
#import <UIColor+MLPFlatColors.h>
#import "HMBestGameStatus.h"
#import "HMGameInfo.h"
#import "HMValue.h"
@interface HMRecordViewController ()
@property (weak, nonatomic) IBOutlet YETIMotionLabel *correctLabel;
@property (weak, nonatomic) IBOutlet YETIMotionLabel *scoreLabel;
@property (weak, nonatomic) IBOutlet YETIMotionLabel *totalWordCountLabel;
@property (weak, nonatomic) IBOutlet YETIMotionLabel *totalWrongGuessCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@end

@implementation HMRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.label1.textColor = [UIColor flatWhiteColor];
        self.label2.textColor = [UIColor flatWhiteColor];
        self.label3.textColor = [UIColor flatWhiteColor];
        self.label4.textColor = [UIColor flatWhiteColor];
        self.correctLabel.textColor = [UIColor flatWhiteColor];
        self.scoreLabel.textColor = [UIColor flatWhiteColor];
        self.totalWordCountLabel.textColor = [UIColor flatWhiteColor];
        self.totalWrongGuessCountLabel.textColor = [UIColor flatWhiteColor];
    
    self.correctLabel.text = @"0";
    self.scoreLabel.text = @"0";
    self.totalWordCountLabel.text = @"0";
    self.totalWrongGuessCountLabel.text = @"0";
    [self getYourResult];

    // Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateUI];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - request
- (void)getYourResult {
    [SVProgressHUD showWithStatus:@"Getting result" maskType:SVProgressHUDMaskTypeBlack];
    HMGameInfo *gameInfo = [HMGameInfo currentGameInfo];
    HMValue *value = [HMValue new];
    value.sessionId = gameInfo.sessionId;
    if (!value.sessionId) {
        return;
    }
    [[HMRequestCenter requestCenter] requestJsonDataWithType:HMRequestTypeGetYourResult otherValue:value completion:^(BOOL success, NSDictionary *dict) {
        if(success){
            [SVProgressHUD dismiss];
            NSDictionary *resultData = [dict objectForKey:@"data"];
            HMBestGameStatus *bestStatus = [HMBestGameStatus bestGameStatus];
            bestStatus.correctWordCount = resultData[@"correctWordCount"];
            bestStatus.score = resultData[@"score"];
            bestStatus.totalWrongGuessCount = resultData[@"totalWrongGuessCount"];
            bestStatus.totalWordCount = resultData[@"totalWordCount"];
            [self updateUI];
        }else{
            [SVProgressHUD showInfoWithStatus:@"Network Error"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self dismissViewControllerAnimated:YES completion:nil];
            });

        }
    }];
}
#pragma mark - updateUI
- (void)updateUI {
    PHLog(@" ");
    HMBestGameStatus *status = [HMBestGameStatus bestGameStatus];
    if (status.correctWordCount) {
        self.correctLabel.text = [NSString stringWithFormat:@"%@",    status.correctWordCount];
    }
    if (status.score) {
        self.scoreLabel.text = [NSString stringWithFormat:@"%@",status.score];
    }

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
