//
//  OneTimePasswordSettings.m
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/11/15.
//

#import "OneTimePasswordSettings.h"
#import <Base32/MF_Base32Additions.h>

@implementation OneTimePasswordSettings

+ (instancetype)sharedInstance {
    static OneTimePasswordSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OneTimePasswordSettings alloc] init];

        NSString *name = @"...";
        NSString *issuer = @"...";
        NSString *secretString = @"...";

        NSData *secretData = [NSData dataWithBase32String:secretString];

        sharedInstance.secretData = secretData;
        sharedInstance.name = name;
        sharedInstance.issuer = issuer;
        sharedInstance.algorithm = [OTPToken defaultAlgorithm];
        sharedInstance.digits = [OTPToken defaultDigits];
        sharedInstance.period = [OTPToken defaultPeriod];
    });
    return sharedInstance;
}

- (NSString *)generateOneTimePassword {
    OTPToken *token = [OTPToken tokenWithType:OTPTokenTypeTimer secret:self.secretData name:self.name issuer:self.issuer];
    token.algorithm = self.algorithm;
    token.digits = self.digits;
    token.period = self.period;
    return token.password;
}

- (NSString *)algorithmString {
    return [NSString stringForAlgorithm:self.algorithm];
}

- (NSString *)digitsString {
    return [NSString stringWithFormat:@"%d", (int)self.digits];
}

- (NSString *)periodString {
    return [NSString stringWithFormat:@"%d", (int)self.period];
}

- (void)saveAlgorithmString:(NSString *)algorithmString {
    self.algorithm = [algorithmString algorithmValue];
}

- (void)saveDigitsString:(NSString *)digitsString {
    self.digits = [digitsString intValue];
}

- (void)savePeriodString:(NSString *)periodString {
    self.period = [periodString intValue];
}

@end
