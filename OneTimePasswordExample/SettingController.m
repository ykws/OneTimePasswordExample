//
//  SettingController.m
//  OneTimePasswordExample
//
//  Created by Mai Nakagami on 2021/09/28.
//

#import "SettingController.h"
#import "SettingsTableViewCell.h"
#import "ViewController.h"

#pragma mark - Settings item

typedef NS_ENUM(UInt8, SettingsItem) {
    AlgorithmItem,
    DigitsItem,
    PeriodItme,
};

extern SettingsItem SettingsItemUnknown;


#pragma mark - Settings table view controller

@interface SettingController () <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic) SettingsItem settingsItem;

@property (nonatomic) UIPickerView *pickerView;

@property (nonatomic) NSArray *algorithmPatterns;
@property (nonatomic) NSArray *digitsPatterns;
@property (nonatomic) NSArray *periodPatterns;

@property (nonatomic) NSString *algorithm;
@property (nonatomic) NSString *digits;
@property (nonatomic) NSString *period;

@end

@implementation SettingController {
    NSIndexPath * pickerIndexPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.center = self.view.center;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    [self.view addSubview: self.pickerView];

    self.algorithmPatterns = @[@"SHA1", @"SHA256", @"SHA512"];
    self.digitsPatterns = @[@"4", @"5", @"6", @"7", @"8", @"9", @"10"];
    self.periodPatterns = @[@"30", @"60"];

    self.algorithm = self.algorithmPatterns[0];
    self.digits = self.digitsPatterns[0];
    self.period = self.periodPatterns[0];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingsTableViewCell *cell = (SettingsTableViewCell *)[tableView dequeueReusableCellWithIdentifier: @"SettingsTableViewCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0:
            cell.titleLabel.text = @"アルゴリズム";
            cell.valueLabel.text = self.algorithm;
            break;
        case 1:
            cell.titleLabel.text = @"OTP桁数";
            cell.valueLabel.text = self.digits;
            break;
        case 2:
            cell.titleLabel.text = @"タイムステップ数";
            cell.valueLabel.text = self.period;
            break;
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.settingsItem = indexPath.row;
    [self.pickerView selectRow:0 inComponent:0 animated:true];
    [self.pickerView reloadAllComponents];
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
        case PeriodItme:
            return self.periodPatterns.count;
        default:
            return 0;
    }
}

#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            return self.algorithmPatterns[row];
        case DigitsItem:
            return self.digitsPatterns[row];
        case PeriodItme:
            return self.periodPatterns[row];
    }
    
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    switch (self.settingsItem) {
        case AlgorithmItem:
            self.algorithm = self.algorithmPatterns[row];
            break;
        case DigitsItem:
            self.digits = self.digitsPatterns[row];
            break;
        case PeriodItme:
            self.period = self.periodPatterns[row];
            break;
    }
 
    [self.tableView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *viewController = segue.destinationViewController;
    viewController.algorithm = self.algorithm;
    viewController.digits = self.digits;
    viewController.period = self.period;
}

@end
