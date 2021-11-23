//
//  OneTimePasswrodConverter.m
//  OneTimePasswordExample
//
//  Created by KAWASHIMA Yoshiyuki on 2021/11/22.
//

#import "OneTimePasswordConverter.h"
#import <Base32/MF_Base32Additions.h>

@implementation OneTimePasswordConverter

+ (NSString *)stringFromAlgorithm:(OTPAlgorithm)algorithm {
    return [NSString stringForAlgorithm:algorithm];
}

+ (NSString *)stringFromDigits:(NSUInteger)digits {
    return [NSString stringWithFormat:@"%d", (int)digits];
}

+ (NSString *)stringFromPeriod:(NSTimeInterval)period {
    return [NSString stringWithFormat:@"%d", (int)period];
}

+ (NSData *)secretFromString:(NSString *)string {
    return [NSData dataWithBase32String:string.base32String];
}

+ (OTPAlgorithm)algorithmFromString:(NSString *)string {
    return [string algorithmValue];
}

+ (NSUInteger)digitisFromString:(NSString *)string {
    return [string intValue];
}

+ (NSTimeInterval)periodFromString:(NSString *)string {
    return [string intValue];
}

@end
