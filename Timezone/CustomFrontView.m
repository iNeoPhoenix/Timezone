//
//  CustomFrontView.m
//  Timezone
//
//  Created by Stéphane Chrétien on 23/05/09.
//  Copyright 2009 Dassault Systèmes. All rights reserved.
//

#import "CustomFrontView.h"
#import "TimezoneAppDelegate.h"
#import "TimezoneManager.h"
#import "Timezone.h"
#import "TimezoneNotifications.h"


@implementation CustomFrontView

@synthesize touchedPoint = m_TouchedPoint;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
		self.multipleTouchEnabled = YES;
		
        m_WorldMapImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[self addSubview:m_WorldMapImageView];
		
		m_TimezoneView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[self addSubview:m_TimezoneView];
		
		m_TouchedPoint = CGPointMake(-1., -1.);
    }
    return self;
}

- (void)dealloc {
	[m_WorldMapImageView release];
	// Don't release m_TouchedView
    [super dealloc];
}

#pragma mark Specific methods
- (void)setWorldMap:(UIImage*)map {
	m_WorldMapImageView.image = map;
}

- (void)setTimezone:(UIImage*)timezone {
	m_TimezoneView.image = timezone;
}

- (void)handleTouchEvent:(NSSet*)touches withEvent:(UIEvent *)event isPressed:(BOOL)pressed {
	if (pressed) {
		UITouch *touch = [touches anyObject];
		m_TouchedPoint = [touch locationInView:self];
		
		[[NSNotificationCenter defaultCenter] postNotificationName:didSelectTimezoneNtf object:self];
	} else {
		m_TouchedPoint = CGPointMake(-1., -1.);
		[[NSNotificationCenter defaultCenter] postNotificationName:didUnselectTimezoneNtf object:self];
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet* allTouches = [event allTouches];
	NSInteger count = [allTouches count];
	if (count == 1) {
		[self handleTouchEvent:touches withEvent:event isPressed:YES];
	}
	[self.superview touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet* allTouches = [event allTouches];
	NSInteger count = [allTouches count];
	if (count == 1) {
		[self handleTouchEvent:touches withEvent:event isPressed:YES];
	}
	[self.superview touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.superview touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self handleTouchEvent:touches withEvent:event isPressed:NO];
}

- (void)willToggleViews {
	/*
	NSArray* subviews = self.subviews;
	NSInteger nbSubViews = [subviews count];
	UIView* view;
	for (NSInteger index= 0; index < nbSubViews; index++) {
		view = (UIView*) [subviews objectAtIndex:index];
		if (view != m_WorldMapImageView) {
			view.hidden = YES;
		}
	}
	 */
}

- (void)didToggleViews {
	/*
	NSArray* subviews = self.subviews;
	NSInteger nbSubViews = [subviews count];
	UIView* view;
	for (NSInteger index= 0; index < nbSubViews; index++) {
		view = (UIView*) [subviews objectAtIndex:index];
		view.hidden = NO;
	}	
	 */
}

@end
