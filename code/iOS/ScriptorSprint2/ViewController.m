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
    NSString *theURL = @"http://35.238.47.23/getData";
    NSURL *connectionURL = [NSURL URLWithString:theURL];
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:connectionURL];
    [req setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:req
                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                    if (error != nil){
                                        NSLog(@"%@", error.localizedDescription);
                                        return;
                                    }
                                    NSData *localData = data;
                                    
                                    NSString *jsonString = [[NSString alloc] initWithData:localData encoding:NSASCIIStringEncoding];
                                    
                                    //jsonString contains the string-ed JSON
                                    NSError *err = nil;
                                    
                                    NSMutableString *toPrint = [NSMutableString stringWithFormat: @""];
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
                                        }];
                                    //ends the connection
                                }];
    [task resume];
    return;
    
    
}

@end


//                                                for(int i = 0; i < array.count; i++){
//                                                NSString *temp = [[array objectAtIndex: i] componentsJoinedByString:@""];
//                                                [toPrint appendString:temp];
//                                                }

