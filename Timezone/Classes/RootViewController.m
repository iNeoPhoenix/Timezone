//
//  RootViewController.m
//  Timezone
//
//  Created by Stéphane Chrétien on 28/04/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "RootViewController.h"
#import "FrontViewController.h"
#import "BackViewController.h"
#import <math.h>


@implementation RootViewController

@synthesize view = m_View;
@synthesize frontViewController = m_FrontViewController;
@synthesize backViewController = m_BackViewController;
@synthesize infoButton = m_InfoButton;

- (id)initWithDST:(BOOL)isDSTAvailable {
	if (self = [super init]) {
		// Set up the Root view
		m_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		CGAffineTransform rotation    = CGAffineTransformMakeRotation(-M_PI/2);
		CGAffineTransform translation = CGAffineTransformMakeTranslation(-80, 80);
		CGAffineTransform transform   = CGAffineTransformConcat(rotation, translation);
		m_View.transform = transform; 
		
		// Front view controller
		m_FrontViewController = [[FrontViewController alloc] initWithDST:isDSTAvailable];
		
		// Back view controller
		m_BackViewController = [[BackViewController alloc] init];
		
		// Display front view at launch time
		[m_View addSubview:m_FrontViewController.view];
		m_IsFront = YES;
		
		// Info button
		m_InfoButton = [[UIButton buttonWithType:UIButtonTypeInfoLight] retain];
		m_InfoButton.frame = CGRectMake(440, 280, 32, 32);
		[m_InfoButton addTarget:self action:@selector(toggleViews) forControlEvents:UIControlEventTouchUpInside];
		[m_View insertSubview:m_InfoButton aboveSubview:m_FrontViewController.view];
	}
	return self;
}

- (void)dealloc {
	self.frontViewController = nil;
	self.backViewController  = nil;
	self.infoButton			 = nil;
	self.view				 = nil;
	
    [super dealloc];
}

#pragma mark Specific methods
- (void)toggleViews {    
    UIView *frontView = m_FrontViewController.view;
    UIView *backView  = m_BackViewController.view;
    
	[m_BackViewController viewWillAppear];
	[m_FrontViewController willToggleViews];
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:1];
    [UIView setAnimationTransition:(m_IsFront ? UIViewAnimationTransitionFlipFromRight : UIViewAnimationTransitionFlipFromLeft) forView:m_View cache:YES];
    [UIView setAnimationDelegate:self]; 
	
    if (m_IsFront) {
        [frontView removeFromSuperview];
        [m_InfoButton removeFromSuperview];
		[m_BackViewController viewWillAppear];
        [m_View addSubview:backView];
		m_InfoButton.frame = CGRectMake(430, 270, 32, 32);
        [m_View insertSubview:m_InfoButton aboveSubview:backView];		
    } else {
        [backView removeFromSuperview];
        [m_InfoButton removeFromSuperview];
		//[m_FrontViewController viewWillAppear];
        [m_View addSubview:frontView];
		m_InfoButton.frame = CGRectMake(440, 280, 32, 32);
        [m_View insertSubview:m_InfoButton aboveSubview:frontView];
    }
    [UIView commitAnimations];
	m_IsFront = !m_IsFront;
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[m_FrontViewController didToggleViews];
}

- (void)applicationDidBecomeActive {
	[m_FrontViewController updateSunMap];
}

@end
