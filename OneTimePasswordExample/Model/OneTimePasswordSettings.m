//
//  OneTimePasswordSettings.m
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/11/15.
//

#import "OneTimePasswordSettings.h"
#import "OneTimePasswordConverter.h"

@implementation OneTimePasswordSettings

+ (instancetype)sharedInstance {
    static OneTimePasswordSettings *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[OneTimePasswordSettings alloc] init];

        NSString *name = @"...";
        NSString *issuer = @"...";
        NSString *secretString = @"...";

        sharedInstance.secretData = [OneTimePasswordConverter secretFromString:secretString];
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
    return [OneTimePasswordConverter stringFromAlgorithm:self.algorithm];
}

- (NSString *)digitsString {
    return [OneTimePasswordConverter stringFromDigits:self.digits];
}

- (NSString *)periodString {
    return [OneTimePasswordConverter stringFromPeriod:self.period];
}

- (void)saveAlgorithmString:(NSString *)algorithmString {
    self.algorithm = [OneTimePasswordConverter algorithmFromString:algorithmString];
}

- (void)saveDigitsString:(NSString *)digitsString {
    self.digits = [OneTimePasswordConverter digitisFromString:digitsString];
}

- (void)savePeriodString:(NSString *)periodString {
    self.period = [OneTimePasswordConverter periodFromString:periodString];
}

@end
