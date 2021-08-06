//
//  ViewController.m
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/08/05.
//

#import "ViewController.h"
#import "OneTimePassword.h"
#import <Base32/MF_Base32Additions.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *name = @"...";
    NSString *issuer = @"...";
    NSString *secretString = @"...";

    NSData *secretData = [NSData dataWithBase32String:secretString];

    OTPToken *token = [OTPToken tokenWithType:OTPTokenTypeTimer secret:secretData name:name issuer:issuer ];

    NSLog(@"%@", token.password);
}


@end
