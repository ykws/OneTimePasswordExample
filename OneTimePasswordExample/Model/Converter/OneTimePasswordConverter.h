//
//  OneTimePasswordConverter.h
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/11/22.
//

#import <Foundation/Foundation.h>
#import "OneTimePassword.h"

NS_ASSUME_NONNULL_BEGIN

@interface OneTimePasswordConverter : NSObject

+ (NSString *)stringFromAlgorithm:(OTPAlgorithm)algorithm;
+ (NSString *)stringFromDigits:(NSUInteger)digits;
+ (NSString *)stringFromPeriod:(NSTimeInterval)period;

+ (NSData *)secretFromString:(NSString *)string;
+ (OTPAlgorithm)algorithmFromString:(NSString *)string;
+ (NSUInteger)digitisFromString:(NSString *)string;
+ (NSTimeInterval)periodFromString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
