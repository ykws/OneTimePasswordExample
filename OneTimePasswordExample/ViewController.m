//
//  ViewController.m
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/08/05.
//

#import "ViewController.h"
#import "SettingController.h"
#import "OneTimePasswordSettings.h"
#import <UAProgressView.h>

@interface ViewController ()

@property (strong, nonatomic) OneTimePasswordSettings *settings;

@property (weak, nonatomic) IBOutlet UILabel *oneTimePasswordLabel;
@property (weak, nonatomic) IBOutlet UAProgressView *oneTimePasswordProgressView;
@property (nonatomic, assign) CGFloat localProgress;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    [self initOneTimePasswordView];
}

- (void)initOneTimePasswordView {
    self.settings = [OneTimePasswordSettings sharedInstance];

    // UNIXTIME を基準にワンタイムパスワードの残りの有効時間を算出
    NSInteger unixtime = [[NSDate date] timeIntervalSince1970];
    _localProgress = unixtime % 30 / 30.0;

    [self.oneTimePasswordProgressView setProgress:_localProgress animated:NO];
    [self.oneTimePasswordProgressView setLineWidth:10];

    NSString *password = [self.settings generateOneTimePassword];
    [self.oneTimePasswordLabel setText:password];

    NSTimeInterval timeInterval = self.settings.period / 1000;
    [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(updateOneTimePasswordView:) userInfo:nil repeats:YES];
}

- (void)updateOneTimePasswordView:(NSTimer *)timer {
    // 0.03 秒に1回更新するので、ワンタイムパスワード 30秒は 1000回で1周
    // 1回の更新では 0.001 ずつ progress を進める
    CGFloat newProgress = ((int)((_localProgress * 1000.0f) + 1.001) % 1000) / 1000.0f;

    if (newProgress < _localProgress) {
        NSString *password = [self.settings generateOneTimePassword];
        [self.oneTimePasswordLabel setText:password];
    }

    _localProgress = newProgress;
    [self.oneTimePasswordProgressView setProgress:_localProgress animated:NO];
}

@end
