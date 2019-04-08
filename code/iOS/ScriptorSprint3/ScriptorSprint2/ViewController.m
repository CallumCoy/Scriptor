//
//  ViewController.m
//  ScriptorSprint2
//
//  Created by Adrian Garcia on 2/20/19.
//  Copyright © 2019 Adrian Garcia. All rights reserved.
//

#import "ViewController.h"
#import <RestKit/RestKit.h>
#import "Songs.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *mainButton;
@property (weak, nonatomic) IBOutlet UIButton *secondaryButton;
@property (weak, nonatomic) IBOutlet UIButton *settingsButton;
@property (weak, nonatomic) IBOutlet UITextView *displayText;

- (void) getJSON;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    int stop = 0;
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    NSDate *initDate = [NSDate date]; //crashes here
    NSDateComponents *initDateComponents = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:initDate];
    [settings setInteger:initDateComponents.day forKey:@"selectedDay"];
    [settings setInteger:initDateComponents.month forKey:@"selectedMonth"];
    [settings setInteger:initDateComponents.year forKey:@"selectedYear"];
    
    //DEBUG DELETE LATER
    //[settings setObject:@"Our Lady Of the Sign" forKey:@"church"];
    
    
    [self setFontSize];
}


- (IBAction)mainButtonPressed:(id)sender {
    _mainButton.hidden = true;
    _secondaryButton.hidden = false;
    _displayText.hidden = false;
    [self getJSON];
    [self setFontSize];
    return;
}

- (IBAction)settingsButtonPressed:(id)sender {
    //changes to the settings page
    
    int freeze = 0;
    [self performSegueWithIdentifier:@"toSettings" sender:nil];
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    [self setFontSize];
}


- (IBAction)secondaryButtonPressed:(id)sender {
    [self getJSON];
    [self setFontSize];
    return;
}

- (void) setFontSize {
    NSInteger val = 0;
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    val = [settings integerForKey:@"fontSize"];
    _displayText.font = [UIFont systemFontOfSize: val];
}


- (void) getJSON {
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
   
    NSString *testURL = @"http://34.73.45.124:8080/getData";
    
    
    NSString *churchName = [settings objectForKey:@"church"];
    NSInteger *day = [settings integerForKey:@"selectedDay"];
    NSInteger *month = [settings integerForKey:@"selectedMonth"];
    NSInteger *year = [settings integerForKey:@"selectedYear"];
    NSMutableString *path = [NSMutableString stringWithFormat:@"/getData"];
    //get churchAddress
    NSString *churchAddress = [settings objectForKey:@"churchAddress"];
    
    //abort if church or churchAddress is nil
    if(churchName == nil || churchAddress == nil){
        _displayText.text = @"Please select a church in the settings menu.";
        return;
    }
    
    
    //set up the currDate in the correct format
    NSMutableString *tempDate = [NSMutableString stringWithFormat:@""];
    NSMutableString *tempTempMonth = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"", (long) month]];
    NSMutableString *tempTempDay = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"", (long) day]];
    if((long) month < 10){
        [tempTempMonth appendString:[NSString stringWithFormat:@"0%ld", (long) month]];
    } else {
        [tempTempMonth appendString:[NSString stringWithFormat:@"%ld", (long) month]];
    }
    if((long) day < 10){
        [tempTempDay appendString:[NSString stringWithFormat:@"0%ld", (long) day]];
    } else {
        [tempTempDay appendString:[NSString stringWithFormat:@"%ld", (long) day]];
    }
    NSString *tempMonth = [NSString stringWithFormat:@"%@", tempTempMonth];
    NSString *tempDay = [NSString stringWithFormat:@"_%@_", tempTempDay];
    NSString *tempYear = [NSString stringWithFormat:@"%ld", (long) year];
    [tempDate appendString:tempMonth];
    [tempDate appendString:tempDay];
    [tempDate appendString:tempYear];
    NSString *currDate = [NSString stringWithFormat:@"%@", tempDate];
    
    NSString *encodedChurchAddress = [churchAddress stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    
    
    NSMutableString *fullTestURL = [[NSMutableString alloc] initWithString:testURL];
    [path appendString:@"?church="];
    [fullTestURL appendString: @"?church="];
    NSString *encodedChurchName = [churchName stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    [path appendString: encodedChurchName];
    [path appendString: @"&currDate="];
    [fullTestURL appendString: encodedChurchName];
    [fullTestURL appendString: @"&currDate="];
    NSString *encodedCurrDate = [currDate stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
    [path appendString: encodedCurrDate];
    [path appendString: @"&churchAddress="];
    [fullTestURL appendString: encodedCurrDate];
    [fullTestURL appendString: @"&churchAddress="];
    [path appendString: encodedChurchAddress];
    [fullTestURL appendString: encodedChurchAddress];
    NSString *daURL = [[NSString alloc] initWithString:fullTestURL];
    
    NSString *staticPath = [[NSString alloc] initWithString:path];
    
    NSURL *connectionURL = [NSURL URLWithString:daURL];
    
    NSLog(@"%@", connectionURL);
    
    NSLog(@"-----------");
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:connectionURL];
    [req setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req
                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                    if (error != nil){
                                        NSLog(@"%@", error.localizedDescription);
                                        return;
                                    }
                                    int stopper = 0;
                                    NSData *localData = data;
                                    NSMutableString *toPrint = [NSMutableString stringWithFormat:@""];
                                    NSString *logger = [[NSString alloc] initWithData:localData encoding:NSUTF8StringEncoding];
                                    NSLog(@"%@", logger);
                                    if([logger isEqualToString:@"N/A"]){
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            self->_displayText.text = logger;
                                            
                                        });
                                    } else {
                                        //process the response...
                                        
                                        [[RKObjectManager sharedManager] getObjectsAtPath:staticPath parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            
                                            for(NSInteger i = 0; i < mappingResult.array.count; i++){
                                                Songs *song = mappingResult.array[i];
                                                [toPrint appendString: song.mainText];
                                                [toPrint appendString:@"\n\n"];
                                            }
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                if(toPrint != nil){
                                                    self->_displayText.text = toPrint;
                                                } else {
                                                    self->_displayText.text = @"An Error Occured...";
                                                }
                                            });
                                        } failure:^(RKObjectRequestOperation *operation,
                                                    NSError *error) {
                                            NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                            
                                        }];
                                        
                                       
                                    }
                                }];
                                
    [task resume];
    return;
    
    
}

@end
                                    
                                    
                                    
                                    /*
                                     NSData *localData = data;
                                     NSLog(@"%@", session);
                                     NSString *jsonString = [[NSString alloc] initWithData:localData encoding:NSASCIIStringEncoding];
                                     
                                     //jsonString contains the string-ed JSON
                                     NSError *err = nil;
                                     
                                     NSMutableString *toPrint = [NSMutableString stringWithFormat: @""];
                                     
                                     //---------
                                     [[RKObjectManager sharedManager] getObjectsAtPath:@"/getData" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                     
                                     for(NSInteger i = 0; i < mappingResult.array.count; i++){
                                     Songs *song = mappingResult.array[i];
                                     [toPrint appendString: song.mainText];
                                     }
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                     if(toPrint != nil){
                                     self->_displayText.text = toPrint;
                                     } else {
                                     self->_displayText.text = @"An Error Occured...";
                                     }
                                     });
                                     }
                                     failure:^(RKObjectRequestOperation *operation,
                                     NSError *error) {
                                     NSLog(@"What do you mean by 'there is no coffee?': %@", error);
                                     }];*/
                                    //------
                                    //ends the connection
