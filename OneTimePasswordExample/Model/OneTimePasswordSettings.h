//
//  OneTimePasswordSettings.h
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/11/15.
//

#import <Foundation/Foundation.h>
#import "OneTimePassword.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneTimePasswordSettings : NSObject

@property (nonatomic) NSData *secretData;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *issuer;
@property (nonatomic) OTPAlgorithm algorithm;
@property (nonatomic) NSUInteger digits;
@property (nonatomic) NSTimeInterval period;

+ (instancetype)sharedInstance;

- (NSString *)generateOneTimePassword;

// 設定の比較用に文字列表現を取得できるようにする
- (NSString *)algorithmString;
- (NSString *)digitsString;
- (NSString *)periodString;

// 設定の文字列から保存できるようにする
- (void)saveAlgorithmString:(NSString *)algorithmString;
- (void)saveDigitsString:(NSString *)digitsString;
- (void)savePeriodString:(NSString *)periodString;

@end

NS_ASSUME_NONNULL_END
