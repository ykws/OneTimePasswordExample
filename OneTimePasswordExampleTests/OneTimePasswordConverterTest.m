//
//  OneTimePasswordConverterTest.m
//  OneTimePasswordExampleTests
//
//  Created by KAWASHIMA Yoshiyuki on 2021/11/24.
//

#import <XCTest/XCTest.h>
#import "OneTimePasswordConverter.h"
#import "OneTimePassword.h"
#import <Base32/MF_Base32Additions.h>

@interface OneTimePasswordConverterTest : XCTestCase

@end

@implementation OneTimePasswordConverterTest

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testStringFromAlgorithm {
    XCTAssertEqualObjects(@"SHA1",   [OneTimePasswordConverter stringFromAlgorithm:OTPAlgorithmSHA1]);
    XCTAssertEqualObjects(@"SHA256", [OneTimePasswordConverter stringFromAlgorithm:OTPAlgorithmSHA256]);
    XCTAssertEqualObjects(@"SHA512", [OneTimePasswordConverter stringFromAlgorithm:OTPAlgorithmSHA512]);
}

- (void)testStringFromDigits {
    XCTAssertEqualObjects(@"4",  [OneTimePasswordConverter stringFromDigits:4]);
    XCTAssertEqualObjects(@"5",  [OneTimePasswordConverter stringFromDigits:5]);
    XCTAssertEqualObjects(@"6",  [OneTimePasswordConverter stringFromDigits:6]);
    XCTAssertEqualObjects(@"7",  [OneTimePasswordConverter stringFromDigits:7]);
    XCTAssertEqualObjects(@"8",  [OneTimePasswordConverter stringFromDigits:8]);
    XCTAssertEqualObjects(@"9",  [OneTimePasswordConverter stringFromDigits:9]);
    XCTAssertEqualObjects(@"10", [OneTimePasswordConverter stringFromDigits:10]);
}

- (void)testStringFromPeriod {
    XCTAssertEqualObjects(@"30", [OneTimePasswordConverter stringFromPeriod:30]);
    XCTAssertEqualObjects(@"60", [OneTimePasswordConverter stringFromPeriod:60]);
}

- (void)testSecretFromString {
    NSData *data = [OneTimePasswordConverter secretFromString:@"Test"];
    NSString *decode = [MF_Base32Codec base32StringFromData:data];
    XCTAssertEqualObjects(@"KRSXG5A=", decode);
}

- (void)testAlgorithmFromString {
    XCTAssertEqual(OTPAlgorithmSHA1,   [OneTimePasswordConverter algorithmFromString:@"SHA1"]);
    XCTAssertEqual(OTPAlgorithmSHA256, [OneTimePasswordConverter algorithmFromString:@"SHA256"]);
    XCTAssertEqual(OTPAlgorithmSHA512, [OneTimePasswordConverter algorithmFromString:@"SHA512"]);
}

- (void)testDigitsFromString {
    XCTAssertEqual(4,  [OneTimePasswordConverter digitisFromString:@"4"]);
    XCTAssertEqual(5,  [OneTimePasswordConverter digitisFromString:@"5"]);
    XCTAssertEqual(6,  [OneTimePasswordConverter digitisFromString:@"6"]);
    XCTAssertEqual(7,  [OneTimePasswordConverter digitisFromString:@"7"]);
    XCTAssertEqual(8,  [OneTimePasswordConverter digitisFromString:@"8"]);
    XCTAssertEqual(9,  [OneTimePasswordConverter digitisFromString:@"9"]);
    XCTAssertEqual(10, [OneTimePasswordConverter digitisFromString:@"10"]);
}

- (void)testPeriodFromString {
    XCTAssertEqual(30, [OneTimePasswordConverter periodFromString:@"30"]);
    XCTAssertEqual(60, [OneTimePasswordConverter periodFromString:@"60"]);
}

@end
