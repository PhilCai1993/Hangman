//
//  AuthorViewController.m
//  Hangman
//
//  Created by Phil Cai on 15/6/23.
//  Copyright © 2015年 Phil Cai. All rights reserved.
//

#import "AuthorViewController.h"
#import <UIColor+MLPFlatColors.h>
#import <WebKit/WebKit.h>
NSString *const kAuthURL = @"http://philcai.com";
@interface AuthorViewController ()<WKNavigationDelegate>
{
    WKWebView *webView;
}
@property (weak, nonatomic) IBOutlet UIButton *homeButton;
@end

@implementation AuthorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor flatWhiteColor];
    [self.homeButton setTintColor:[UIColor flatBlackColor]];
    if (!webView) {
        webView = [[WKWebView alloc] initWithFrame:CGRectZero];
        webView.translatesAutoresizingMaskIntoConstraints = NO;
        webView.allowsBackForwardNavigationGestures = YES;
        [self.view addSubview:webView];
        webView.navigationDelegate = self;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:kAuthURL]]];
    }
    [self configConstraints];
    // Do any additional setup after loading the view.
}
- (IBAction)goHomeViewController:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - layout
- (void)configConstraints{
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
        make.left.equalTo(self.view.mas_left);
                make.right.equalTo(self.view.mas_right);
                make.top.equalTo(self.view.mas_top).offset(64);
                make.bottom.equalTo(self.view.mas_bottom);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"didStartProvisionalNavigation");
}
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {
    NSLog(@"didCommitNavigation");
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
}

- (void)viewDidLayoutSubviews{
    PHLog(@"%@",NSStringFromCGRect(self.homeButton.frame));
}

@end
