//
//  AppDelegate.m
//  ScriptorSprint2
//
//  Created by Adrian Garcia on 2/20/19.
//  Copyright © 2019 Adrian Garcia. All rights reserved.
//

#import "AppDelegate.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "Songs.h"
#import "Church.h"


@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)configureRestKit
{
    // initialize AFNetworking HTTPClient
    NSURL *baseURL = [NSURL URLWithString:@"http://34.73.45.124:8080"];
    AFRKHTTPClient *client = [[AFRKHTTPClient alloc] initWithBaseURL:baseURL];
    
    // initialize RestKit
    RKObjectManager *objectManager = [[RKObjectManager alloc] initWithHTTPClient:client];
    
    // setup object mappings
    RKObjectMapping *songsMapping = [RKObjectMapping mappingForClass:[Songs class]];
    [songsMapping addAttributeMappingsFromArray:@[@"mainText"]];

    RKObjectMapping *songschurches = [RKObjectMapping mappingForClass:[Church class]];
    [songschurches addAttributeMappingsFromArray:@[@"name"]];
    [songschurches addAttributeMappingsFromArray:@[@"address"]];

    // register mappings with the provider using a response descriptor
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:songsMapping
                    method:RKRequestMethodGET
               pathPattern:@"/getData"
                   keyPath:nil
               statusCodes:[NSIndexSet indexSetWithIndex:200]];

    RKResponseDescriptor *responseDescriptorChurches = [RKResponseDescriptor responseDescriptorWithMapping:songschurches
                                method:RKRequestMethodGET
                           pathPattern:@"/getchurches"
                               keyPath:nil
                           statusCodes:[NSIndexSet indexSetWithIndex:200]];

    [objectManager addResponseDescriptor:responseDescriptor];
    [objectManager addResponseDescriptor:responseDescriptorChurches];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self configureRestKit];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end