    //
//  KGBladeViewController.m
//  KGAccordion
//
//  Created by Kyle Goddard on 11-02-12.
//  Copyright 2011 Kyle Goddard. All rights reserved.
//

#import "KGBladeViewController.h"

@interface KGBladeViewController()

- (void)attachTapGestureRecognizerToView:(UIView *)theView;
- (void)openBlade:(UIView *)trigger;
- (UIColor *)randomUIColor;

@end

@implementation KGBladeViewController

@synthesize triggerView = _triggerView;
@synthesize contentView = _contentView;
@synthesize triggerWidth = _triggerWidth;
@synthesize alignment = _alignment;
@synthesize delegate = _delegate;
@synthesize triggerColor = _triggerColor;
@synthesize contentViewBackgroundColor = _contentViewBackgroundColor;

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (id)initWithFrame:(CGRect)theFrame andTriggerWidth:(float)width andAlignment:(int)align{
	self = [super init];
	if (self) {
		[self setTriggerWidth:width];
		[self setAlignment:align];
	}
	return self;
}

#pragma mark -
#pragma mark View Management
#pragma mark -

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	
	// Prepare the blade size.
	CGRect parentFrame = CGRectMake(0.0, 0.0, 320.0, 480.0); //if delegate not set size is the size of an iphone screen.
	if (self.delegate) {
		parentFrame = [self.delegate accordionContainer];
	}
	[self.view setFrame:parentFrame];
	
	// Prepare the trigger of the blade.
	
	CGRect triggerFrame = (self.alignment == 0) ? 
		CGRectMake(0, 0, self.triggerWidth, self.view.frame.size.height):
		CGRectMake(0, 0, self.view.frame.size.width, self.triggerWidth);
	NSLog(@"%f,%f,%f,%f",triggerFrame.origin.x,triggerFrame.origin.y,triggerFrame.size.width,triggerFrame.size.height);
	
	self.triggerView = [[UIView alloc] init];
	[self.triggerView setFrame:triggerFrame];
	[self.triggerView setBackgroundColor:[self triggerColor]];
	[self attachTapGestureRecognizerToView:self.triggerView];
	[self.view addSubview:self.triggerView];
	[self.triggerView release];

	// Prepare the content area of the blade.
	CGRect contentFrame = (self.alignment == 0) ? 
		CGRectMake(self.triggerWidth, 0, self.view.frame.size.width - self.triggerWidth, self.view.frame.size.height):
		CGRectMake(0, self.triggerWidth, self.view.frame.size.width, self.view.frame.size.height - self.triggerWidth);
	self.contentView = [[UIView alloc] init];
	[self.contentView setFrame:contentFrame];
	[self.contentView setBackgroundColor:[self contentViewBackgroundColor]];
	[self.view addSubview:self.contentView];
	[self.contentView release];
	
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}

#pragma mark -
#pragma mark UIGestureRecognizer Methods
#pragma mark -

- (void)attachTapGestureRecognizerToView:(UIView *)theView {
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureChangedState:)];
	[tapGesture setNumberOfTapsRequired:1];
	[tapGesture setNumberOfTouchesRequired:1];
	[theView addGestureRecognizer:tapGesture];
	[tapGesture release];
}


- (void)tapGestureChangedState:(UITapGestureRecognizer *)recognizer {
	switch (recognizer.state) {
		case UIGestureRecognizerStateBegan:
			NSLog(@"KGBladeViewController::Tap Gesture Began.");
			break;
		case UIGestureRecognizerStateEnded:
			NSLog(@"KGBladeViewController::Tap Gesture Ended.");
			[self openBlade:recognizer.view];
			break;
		case UIGestureRecognizerStateCancelled:
		case UIGestureRecognizerStateFailed:
			NSLog(@"KGBladeViewController::Tap Gesture failed or was cancelled by user.");
			break;
	}
}


- (void)openBlade:(UIView *)trigger {
	if(self.delegate && [self.delegate respondsToSelector:@selector(openBlade:)]) {
		[self.delegate openBlade:trigger];
	}
}


#pragma mark -
#pragma mark Background Color
#pragma mark -

- (UIColor *)triggerColor {
	// This returns a color for the trigger if the color
	// has not already been set.
	if ((_triggerColor == nil) && ([self.delegate performSelector:@selector(triggerColor)] == nil)) {
		NSLog(@"KGBladeViewController::Trigger Color is nil.");
		_triggerColor = [self randomUIColor];
	} else {
		_triggerColor = [self.delegate performSelector:@selector(triggerColor)];
	}
	return _triggerColor;
}

- (UIColor *)contentViewBackgroundColor {
	if ((_contentViewBackgroundColor == nil) && ([self.delegate performSelector:@selector(contentBackgroundColor)] == nil)) {
		NSLog(@"KGBladeViewController::Content Background Color is nil.");
		_contentViewBackgroundColor = [self randomUIColor];
	} else {
		_contentViewBackgroundColor = [self.delegate performSelector:@selector(contentBackgroundColor)];
	}
	return _contentViewBackgroundColor;
}


- (UIColor *)randomUIColor {
	CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
	CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
	return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];	
}

#pragma mark -
#pragma mark Memory Management
#pragma mark -

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
	self.triggerView = nil;
	self.contentView = nil;
	self.delegate = nil;
}


- (void)dealloc {
	[self.triggerColor release];
	[self.contentViewBackgroundColor release];
	[self.triggerView release];
	[self.contentView release];
	[self.delegate release];
    [super dealloc];
}


@end
