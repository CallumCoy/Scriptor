//
//  SettingsViewController.m
//  ScriptorSprint2
//
//  Created by Adrian Garcia on 2/24/19.
//  Copyright © 2019 Adrian Garcia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SettingsViewController.h"
#import "ViewController.h"

@interface SettingsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIStepper *fontStepper;
@property (weak, nonatomic) IBOutlet UILabel *exampleLabel;
@property (weak, nonatomic) IBOutlet UIButton *selectChurch;
@property (weak, nonatomic) IBOutlet UILabel *churchNameLabel;
@property (weak, nonatomic) IBOutlet UIDatePicker *dateSelector;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger val = 17;
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    val = [settings integerForKey:@"fontSize"];
    _exampleLabel.font = [UIFont systemFontOfSize:val];
    _fontStepper.value = val;
    NSInteger *savedDay = (NSInteger) [settings integerForKey:@"selectedDay"];
    NSInteger *savedMonth = (NSInteger) [settings integerForKey:@"selectedMonth"];
    NSInteger *savedYear = (NSInteger) [settings integerForKey:@"selectedYear"];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.timeStyle = NSDateFormatterNoStyle;
    dateFormat.dateFormat = @"MM/dd/yyyy";
    NSMutableString *dateString = [NSMutableString stringWithFormat:@""];
    if((long) savedMonth < 10){
        NSString *temp = [NSString stringWithFormat:@"0%ld", (long) savedMonth];
        int stopper = 0;
        [dateString appendString:temp];
    } else {
        NSString *temp = [NSString stringWithFormat:@"%ld", (long) savedMonth];
        int stopper = 0;
        [dateString appendString:temp];
    }
    if((long) savedDay < 10){
        NSString *temp = [NSString stringWithFormat:@"/0%ld", (long) savedDay];
        [dateString appendString:temp];
    } else {
        NSString *temp = [NSString stringWithFormat:@"/%ld", (long) savedDay];
        [dateString appendString:temp];
    }
    [dateString appendString:[NSString stringWithFormat:@"/%ld", (long) savedYear]];
    NSDate *savedDate = [dateFormat dateFromString:dateString];
    _dateSelector.date = savedDate;
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void) viewDidAppear:(BOOL)animated{
    [self setChurch];
}

- (IBAction)backButtonPressed:(id)sender {
    [self changeDate];
    
    [self dismissViewControllerAnimated:YES completion: nil];
    
}

- (IBAction)selectChurchPressed:(id)sender {
    //open church selection screen...
}

- (IBAction)changeSize:(id)sender {
    //changes the font size
    NSInteger val = _fontStepper.value;
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setInteger:val forKey:@"fontSize"];
    _exampleLabel.font = [UIFont systemFontOfSize: val];
    _exampleLabel.sizeToFit;
    
    
}

- (void) changeDate {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSDate *inputDate = _dateSelector.date;
    NSDateComponents *inputDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:inputDate];
    
    //NSLog(@"%ld", (long)inputDateComponents.day);
    //NSLog(@"%ld", (long)inputDateComponents.month);
    //NSLog(@"%ld", (long)inputDateComponents.year);
    [settings setInteger:inputDateComponents.day forKey:@"selectedDay"];
    [settings setInteger:inputDateComponents.month forKey:@"selectedMonth"];
    [settings setInteger:inputDateComponents.year forKey:@"selectedYear"];
}

- (void) setChurch {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *churchName = [settings objectForKey:@"church"];
    _churchNameLabel.text = churchName;
}

@end







