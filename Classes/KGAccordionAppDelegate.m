//
//  KGAccordionAppDelegate.m
//  KGAccordion
//
//  Created by Kyle Goddard on 11-02-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "KGAccordionAppDelegate.h"

@implementation KGAccordionAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	
	rootViewController = [[UIViewController alloc] init];
	[rootViewController.view setFrame:self.window.frame];
	[rootViewController.view setBackgroundColor:[UIColor blueColor]];
	[self.window addSubview:rootViewController.view];
	
	accordion = [[KGAccordionViewController alloc] initWithNumberOfBlades:4 triggerWidth:50];
	accordion.evenTriggerColor = [UIColor darkGrayColor];
	accordion.oddTriggerColor = [UIColor grayColor];
	accordion.contentBackgroundColor = [UIColor lightGrayColor];
	[rootViewController.view addSubview:accordion.view];

    [self.window makeKeyAndVisible];
	
	UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 42)];
	testLabel.text = @"This is a test";
	
	[[[accordion.blades objectAtIndex:0] contentView] addSubview:testLabel];
	[testLabel release];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[accordion release];
	[rootViewController release];	
    [window release];
    [super dealloc];
}


@end
