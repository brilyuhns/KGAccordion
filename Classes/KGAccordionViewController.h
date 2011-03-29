//
//  KGAccordionViewController.h
//  KGAccordion
//
//  Created by Kyle Goddard on 11-02-12.
//  Copyright 2011 Kyle Goddard. All rights reserved.
//
//
//  This is the main class for the KGAccordion. This class determines
//	the outaward size of the accordion view and the number of blades in
//  the accordion.

#import <UIKit/UIKit.h>
#import "KGBladeViewController.h"

@protocol KGAccordionViewControllerDelegate <NSObject>


@end


@interface KGAccordionViewController : UIViewController <KGBladeViewControllerDelegate> {
	
	NSMutableArray *_blades;
	
	int _bladeCount;
	float _triggerWidth;
	float bladeSize;

	id <KGAccordionViewControllerDelegate> _delegate;
	
	UIColor *_evenTriggerColor;
	UIColor *_oddTriggerColor;
	UIColor *_contentBackgroundColor;
	
	UIColor *_triggerColor;
}

@property (nonatomic, assign)int bladeCount;
@property (nonatomic, assign)float triggerWidth;
@property (nonatomic, retain)id <KGAccordionViewControllerDelegate> delegate;
@property (nonatomic, retain)NSMutableArray *blades;

@property (nonatomic, retain) UIColor *evenTriggerColor;
@property (nonatomic, retain) UIColor *oddTriggerColor;
@property (nonatomic, retain) UIColor *contentBackgroundColor;

@property (nonatomic, readonly, retain) UIColor *triggerColor;

- (id)initWithNumberOfBlades:(int)numberOfBlades triggerWidth:(float)width;

@end
