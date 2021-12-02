//
//  SettingController.m
//  OneTimePasswordExample
//
//  Created by Mai Nakagami on 2021/09/28.
//

#import "SettingController.h"
#import "OneTimePasswordSettings.h"

#pragma mark - Settings item

typedef NS_ENUM(UInt8, SettingsItem) {
    AlgorithmItem,
    DigitsItem,
    PeriodItem,
};

extern SettingsItem SettingsItemUnknown;

#pragma mark - Settings table view controller

@interface SettingController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UILabel *algorithmLabel;
@property (weak, nonatomic) IBOutlet UILabel *digitsLabel;
@property (weak, nonatomic) IBOutlet UILabel *periodLabel;

@property (nonatomic) OneTimePasswordSettings *settings;

@property (nonatomic) SettingsItem settingsItem;

@property (nonatomic) UIPickerView *pickerView;

@property (nonatomic) NSArray *algorithmPatterns;
@property (nonatomic) NSArray *digitsPatterns;
@property (nonatomic) NSArray *periodPatterns;

@end

@implementation SettingController {
    NSIndexPath * pickerIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.settings = [OneTimePasswordSettings sharedInstance];

    self.nameTextField.delegate = self;
    self.nameTextField.text = self.settings.name;
    self.algorithmLabel.text = [self.settings algorithmString];
    self.digitsLabel.text = [self.settings digitsString];
    self.periodLabel.text = [self.settings periodString];

    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.center = self.view.center;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview: self.pickerView];

    self.algorithmPatterns = @[@"SHA1", @"SHA256", @"SHA512"];
    self.digitsPatterns = @[@"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    self.periodPatterns = @[@"30", @"60"];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // FIXME: タップしても反応しないことがある
    self.settingsItem = (indexPath.row - 1);
    NSInteger selectRow = [self pickerSelectRowWithItem:self.settingsItem];
    [self.pickerView selectRow:selectRow inComponent:0 animated:true];
    [self.pickerView reloadAllComponents];
}

#pragma mark - Text field delegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.settings.name = textField.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    self.settings.name = textField.text;
    return YES;
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            return self.algorithmPatterns.count;
        case DigitsItem:
            return self.digitsPatterns.count;
        case PeriodItem:
            return self.periodPatterns.count;
    }
}

#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            return self.algorithmPatterns[row];
        case DigitsItem:
            return self.digitsPatterns[row];
        case PeriodItem:
            return self.periodPatterns[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            [self.settings saveAlgorithmString:self.algorithmPatterns[row]];
            self.algorithmLabel.text = [self.settings algorithmString];
            break;
        case DigitsItem:
            [self.settings saveDigitsString:self.digitsPatterns[row]];
            self.digitsLabel.text = [self.settings digitsString];
            break;
        case PeriodItem:
            [self.settings savePeriodString:self.periodPatterns[row]];
            self.periodLabel.text = [self.settings periodString];
            break;
    }
 
    [self.tableView reloadData];
}

#pragma mark - Settigns Index

- (NSInteger)pickerSelectRowWithItem:(SettingsItem)item{
    switch (item) {
        case AlgorithmItem:
            return [self indexWithAlgorithmString:[self.settings algorithmString]];
        case DigitsItem:
            return [self indexWithDigitsString:[self.settings digitsString]];
        case PeriodItem:
            return [self indexWithPeriodString:[self.settings periodString]];
    }
}

- (NSInteger)indexWithAlgorithmString:(NSString *)algorithmString {
    for (int i = 0; i < self.algorithmPatterns.count; i++) {
        if ([self.algorithmPatterns[i] isEqual:algorithmString]) {
            return i;
        }
    }
    return 0;
}

- (NSInteger)indexWithDigitsString:(NSString *)digitsString {
    for (int i = 0; i < self.digitsPatterns.count; i++) {
        if ([self.digitsPatterns[i] isEqual:digitsString]) {
            return i;
        }
    }
    return 0;
}

- (NSInteger)indexWithPeriodString:(NSString *)periodString {
    for (int i = 0; i < self.periodPatterns.count; i++) {
        if ([self.periodPatterns[i] isEqual:periodString]) {
            return i;
        }
    }
    return 0;
}

@end
