//
//  KGBladeViewController.h
//  KGAccordion
//
//  Created by Kyle Goddard on 11-02-12.
//  Copyright 2011 Kyle Goddard. All rights reserved.
//
//	The blades contain the trigger to slide the content into space.

#import <UIKit/UIKit.h>

@protocol KGBladeViewControllerDelegate <NSObject>

- (void)openBlade:(UIView *)triggerView;
- (CGRect)accordionContainer;

@end



@interface KGBladeViewController : UIViewController <UIGestureRecognizerDelegate> {
	
	UIView *_triggerView;
	UIView *_contentView;
	UIColor *_triggerColor;
	UIColor *_contentViewBackgroundColor;
	
	float _triggerWidth;
	
	id <KGBladeViewControllerDelegate> _delegate;

}

@property (nonatomic, retain)UIView *triggerView;
@property (nonatomic, retain)UIView *contentView;
@property (nonatomic, assign)float triggerWidth;
@property (nonatomic, retain)id <KGBladeViewControllerDelegate> delegate;
@property (nonatomic, retain)UIColor *triggerColor;
@property (nonatomic, retain)UIColor *contentViewBackgroundColor;

- (id)initWithFrame:(CGRect)theFrame andTriggerWidth:(float)width;

@end
