//
//  KGAccordionAppDelegate.h
//  KGAccordion
//
//  Created by Kyle Goddard on 11-02-12.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KGAccordionViewController.h"

@interface KGAccordionAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	
	UIViewController *rootViewController;
	KGAccordionViewController *accordion;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

