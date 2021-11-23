//
//  OneTimePasswordSettingsTests.m
//  OneTimePasswordExampleTests
//
//  Created by KAWASHIMA Yoshiyuki on 2021/11/23.
//

#import <XCTest/XCTest.h>
#import "OneTimePasswordSettings.h"
#import "OneTimePassword.h"

@interface OneTimePasswordSettingsTests : XCTestCase

@end

@implementation OneTimePasswordSettingsTests

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testAlgorithmString {
    OneTimePasswordSettings *settings = [OneTimePasswordSettings sharedInstance];

    settings.algorithm = OTPAlgorithmSHA1;
    XCTAssertEqualObjects(@"SHA1", [settings algorithmString]);

    settings.algorithm = OTPAlgorithmSHA256;
    XCTAssertEqualObjects(@"SHA256", [settings algorithmString]);

    settings.algorithm = OTPAlgorithmSHA512;
    XCTAssertEqualObjects(@"SHA512", [settings algorithmString]);
}

- (void)testDigisString {
    OneTimePasswordSettings *settings = [OneTimePasswordSettings sharedInstance];

    settings.digits = 4;
    XCTAssertEqualObjects(@"4", [settings digitsString]);
    
    settings.digits = 5;
    XCTAssertEqualObjects(@"5", [settings digitsString]);
    
    settings.digits = 6;
    XCTAssertEqualObjects(@"6", [settings digitsString]);
    
    settings.digits = 7;
    XCTAssertEqualObjects(@"7", [settings digitsString]);
    
    settings.digits = 8;
    XCTAssertEqualObjects(@"8", [settings digitsString]);
    
    settings.digits = 9;
    XCTAssertEqualObjects(@"9", [settings digitsString]);
    
    settings.digits = 10;
    XCTAssertEqualObjects(@"10", [settings digitsString]);
}

- (void)testPeriodString {
    OneTimePasswordSettings *settings = [OneTimePasswordSettings sharedInstance];

    settings.period = 30;
    XCTAssertEqualObjects(@"30", [settings periodString]);

    settings.period = 60;
    XCTAssertEqualObjects(@"60", [settings periodString]);
}

- (void)testSaveAlgorithm {
    OneTimePasswordSettings *settings = [OneTimePasswordSettings sharedInstance];

    [settings saveAlgorithmString:@"SHA1"];
    XCTAssertEqual(OTPAlgorithmSHA1, settings.algorithm);

    [settings saveAlgorithmString:@"SHA256"];
    XCTAssertEqual(OTPAlgorithmSHA256, settings.algorithm);

    [settings saveAlgorithmString:@"SHA512"];
    XCTAssertEqual(OTPAlgorithmSHA512, settings.algorithm);
}

- (void)testSaveDigits {
    OneTimePasswordSettings *settings = [OneTimePasswordSettings sharedInstance];

    [settings saveDigitsString:@"4"];
    XCTAssertEqual(4, settings.digits);

    [settings saveDigitsString:@"5"];
    XCTAssertEqual(5, settings.digits);

    [settings saveDigitsString:@"6"];
    XCTAssertEqual(6, settings.digits);

    [settings saveDigitsString:@"7"];
    XCTAssertEqual(7, settings.digits);

    [settings saveDigitsString:@"8"];
    XCTAssertEqual(8, settings.digits);

    [settings saveDigitsString:@"9"];
    XCTAssertEqual(9, settings.digits);

    [settings saveDigitsString:@"10"];
    XCTAssertEqual(10, settings.digits);
}

- (void)testSavePeriod {
    OneTimePasswordSettings *settings = [OneTimePasswordSettings sharedInstance];

    [settings savePeriodString:@"30"];
    XCTAssertEqual(30, settings.period);

    [settings savePeriodString:@"60"];
    XCTAssertEqual(60, settings.period);
}

@end
