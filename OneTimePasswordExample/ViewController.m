//
//  ViewController.m
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/08/05.
//

#import "ViewController.h"
#import "OneTimePassword.h"
#import "SettingController.h"
#import <Base32/MF_Base32Additions.h>
#import <UAProgressView.h>

@interface ViewController ()

@property (strong, nonatomic) OTPToken *token;

@property (weak, nonatomic) IBOutlet UILabel *oneTimePasswordLabel;
@property (weak, nonatomic) IBOutlet UAProgressView *oneTimePasswordProgressView;

@property (nonatomic, assign) CGFloat localProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initOneTimePasswordToken];
    [self initOneTimePasswordView];

    [NSTimer scheduledTimerWithTimeInterval:0.03 target:self selector:@selector(updateOneTimePasswordView:) userInfo:nil repeats:YES];
}

- (void)initOneTimePasswordToken {
    NSString *name = @"...";
    NSString *issuer = @"...";
    NSString *secretString = @"...";
    SettingController *settingController;

    NSData *secretData = [NSData dataWithBase32String:secretString];

    self.token = [OTPToken tokenWithType:OTPTokenTypeTimer secret:secretData name:name issuer:issuer];
    self.token.algorithm = @"OTPAlgorithm algorithm";
}

- (void)initOneTimePasswordView {
    // UNIXTIME を基準にワンタイムパスワードの残りの有効時間を算出
    NSInteger unixtime = [[NSDate date] timeIntervalSince1970];
    _localProgress = unixtime % 30 / 30.0;

    [self.oneTimePasswordProgressView setProgress:_localProgress animated:NO];
    [self.oneTimePasswordProgressView setLineWidth:10];

    [self.oneTimePasswordLabel setText:self.token.password];
}

- (void)updateOneTimePasswordView:(NSTimer *)timer {
    // 0.03 秒に1回更新するので、ワンタイムパスワード 30秒は 1000回で1周
    // 1回の更新では 0.001 ずつ progress を進める
    CGFloat newProgress = ((int)((_localProgress * 1000.0f) + 1.001) % 1000) / 1000.0f;

    if (newProgress < _localProgress) {
        [self.oneTimePasswordLabel setText:self.token.password];
    }

    _localProgress = newProgress;
    [self.oneTimePasswordProgressView setProgress:_localProgress animated:NO];
}

@end
