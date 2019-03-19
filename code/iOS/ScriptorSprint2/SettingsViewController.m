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

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger val = 17;
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    val = [settings integerForKey:@"fontSize"];
    _exampleLabel.font = [UIFont systemFontOfSize:val];
    _fontStepper.value = val;
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void) viewDidAppear:(BOOL)animated{
    [self setChurch];
}

- (IBAction)backButtonPressed:(id)sender {

    
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

- (void) setChurch {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSString *churchName = [settings objectForKey:@"church"];
    _churchNameLabel.text = churchName;
}

@end







