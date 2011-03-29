//
//  KGAccordionViewController.m
//  KGAccordion
//
//  Created by Kyle Goddard on 11-02-12.
//  Copyright 2011 Kyle Goddard. All rights reserved.
//

#import "KGAccordionViewController.h"

@interface KGAccordionViewController()

- (void)revealBlade:(KGBladeViewController *)bladeView;

@end


@implementation KGAccordionViewController

@synthesize bladeCount = _bladeCount;
@synthesize triggerWidth = _triggerWidth;
@synthesize delegate = _delegate;
@synthesize blades = _blades;

@synthesize evenTriggerColor = _evenTriggerColor;
@synthesize oddTriggerColor = _oddTriggerColor;
@synthesize contentBackgroundColor = _contentBackgroundColor;

@synthesize triggerColor = _triggerColor;

#pragma mark -
#pragma mark Initialization
#pragma mark -

- (id)initWithNumberOfBlades:(int)numberOfBlades triggerWidth:(float)width {
	self = [super init];
	if (self) {
		NSLog(@"KGAccordionViewController::Init Data: numberOfBlades => %d, width => %f", numberOfBlades, width);
		[self setBladeCount:numberOfBlades];
		[self setTriggerWidth:width];
		if (self.blades == nil) {
			self.blades = [[NSMutableArray alloc] init];
		}
	}
	return self;
}


#pragma mark -
#pragma mark View Management
#pragma mark -


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	[super loadView];
	NSLog(@"KGAccordionViewController::Loading View With Data: bladeCount => %d, triggerWidth => %f", self.bladeCount, self.triggerWidth);
	
	float maxWidth = self.view.frame.size.width;
	float totalTriggerSize = self.triggerWidth * self.bladeCount;
	bladeSize = maxWidth - (totalTriggerSize - self.triggerWidth);
	
	for (int i = 0; i < self.bladeCount; i++) {
		
		if (i % 2 == 0) {
			if (self.evenTriggerColor != nil) {
				NSLog(@"KGAccordionViewController::Even Trigger Color Assigned.");				
				_triggerColor = self.evenTriggerColor;
			}
		} else {
			if (self.oddTriggerColor != nil) {
				NSLog(@"KGAccordionViewController::Odd Trigger Color Assigned.");
				_triggerColor = self.oddTriggerColor;
			}
		}		
		
		KGBladeViewController *bladeView = [[KGBladeViewController alloc] initWithFrame:self.view.frame andTriggerWidth:self.triggerWidth];
		[bladeView setDelegate:self];
		
		// Calculate the frame of this blade. if the number of blades will cause the x-size in the blade to be less than the trigger width
		// throw an exception.
		
		CGRect bladeFrame = CGRectMake(self.triggerWidth * i, 0, bladeSize, self.view.frame.size.height);
		
		[bladeView.view setFrame:bladeFrame];
		
		[self.blades addObject:bladeView];
		[self.view addSubview:bladeView.view];
		[bladeView release];
	}
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


#pragma mark -
#pragma mark KGBladeViewControllerDelegate Methods
#pragma mark -

- (void)openBlade:(UIView *)triggerView {
	for (KGBladeViewController *bladeView in self.blades) {
		if ([bladeView.view.subviews containsObject:triggerView]) {
			NSLog(@"KGAccordionViewController::Found blade containing target trigger");
			[self revealBlade:bladeView];
		}
	}
}

#pragma mark -
#pragma mark Blade Animations
#pragma mark -

- (void)revealBlade:(KGBladeViewController *)bladeView {	
	float currentOrigin = bladeView.view.frame.origin.x;
	
	NSLog(@"KGAccordionViewController::Current Origin: %f", currentOrigin);
	
	void (^revealBlock)(void) = ^{
		// Close the blades that precede the target blade.
		for (int i = 0; i < [self.blades indexOfObject:bladeView]; i++) {
			KGBladeViewController *closedBlade = [self.blades objectAtIndex:i];
			[closedBlade.view setFrame:CGRectMake(self.triggerWidth * i, 
												  closedBlade.view.frame.origin.y, 
												  closedBlade.triggerView.frame.size.width, 
												  closedBlade.triggerView.frame.size.height)];
			NSLog(@"KGAccordionViewController::Pre ClosedBlade Frame: %@", NSStringFromCGRect(closedBlade.view.frame));
		}
		
		// Get the index of the bladeView in the blades array.
		[bladeView.view setFrame:CGRectMake(self.triggerWidth * [self.blades indexOfObject:bladeView], 
											bladeView.view.frame.origin.y, 
											bladeSize, 
											self.view.frame.size.height)];
		NSLog(@"KGAccordionViewController::BladeView Frame: %@", NSStringFromCGRect(bladeView.view.frame));
		
		// Close the blades that follow the target blade.
		for (int j = [self.blades indexOfObject:bladeView] + 1; j < [self.blades count]; j++) {
			KGBladeViewController *closedBlade = [self.blades objectAtIndex:j];
			NSLog(@"KGAccordionViewController::Following ClosedBlade: %@ Incrementer Value: %d", closedBlade, j);
			
			CGRect tmpRect = CGRectMake(self.view.frame.size.width - (self.triggerWidth * ([self.blades count] - j)), 
										closedBlade.view.frame.origin.y, 
										self.triggerWidth, 
										closedBlade.triggerView.frame.size.height);
			
			[closedBlade.view setFrame:tmpRect];
			[self.view bringSubviewToFront:closedBlade.view];
			
			NSLog(@"KGAccordionViewController::Following ClosedBlade Frame: %@", NSStringFromCGRect(closedBlade.view.frame));
		}
	};
	
	[UIView animateWithDuration:0.3 
					 animations:revealBlock
					 completion:NULL];
	
}


- (CGRect)accordionContainer {
	return self.view.frame;
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
	self.delegate = nil;
	self.blades = nil;
}


- (void)dealloc {
	[self.contentBackgroundColor release];
	[self.evenTriggerColor release];
	[self.oddTriggerColor release];
	[self.triggerColor release];
	[self.delegate release];
	[self.blades release];
    [super dealloc];
}


@end
