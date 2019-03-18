//
//  ChurchSelectorController.m
//  ScriptorSprint2
//
//  Created by Adrian Garcia on 3/16/19.
//  Copyright © 2019 Adrian Garcia. All rights reserved.
//

#import "ChurchSelectorController.h"
#import "Church.h"
#import "ChurchTableViewCell.h"
#import <RestKit/RestKit.h>
#import "SettingsViewController.h"

@interface ChurchSelectorController ()
@property (strong, nonatomic) IBOutlet UITableView *churchTable;
@property (strong, nonatomic) NSArray* churches;


@end

@implementation ChurchSelectorController

NSInteger numOfChurches;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getChurches];
    //get the church data
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source

- (void) getChurches {
    NSString *theURL = @"http://35.238.47.23/getchurches";
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
        NSString *localDataString = [[NSString alloc] initWithData:localData encoding:NSUTF8StringEncoding];

        
        NSLog(@"%@", localDataString);
        
        [[RKObjectManager sharedManager] getObjectsAtPath:@"/getchurches" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                numOfChurches = mappingResult.array.count;
                self.churches = (Church *) mappingResult.array;
                [self.churchTable reloadData];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return numOfChurches;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableChurchCell" forIndexPath:indexPath];
    
   // cell = [tableView dequeueReusableCellWithIdentifier:@"tableWebdbCell" forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[ChurchTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:@"tableChurchCell"];
    }
    
    ChurchTableViewCell *churchCell =(ChurchTableViewCell *) cell;
    Church *data = self.churches[indexPath.row];
    
    churchCell.name.text = data.name;
    churchCell.address.text = data.address;

    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Church *data = self.churches[indexPath.row];
    
    
    NSLog(@"Check Selected: %@",data.name );
    
    NSUserDefaults *settings = [NSUserDefaults standardUserDefaults];
    [settings setObject:data.name forKey:@"church"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
