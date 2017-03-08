//
//  frontViewController.h
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CustomFrontView, Timezone, ClockView, SunMapView, CustomRootView;

@interface FrontViewController : NSObject {
	CustomRootView*	 m_View;
	
	NSTimer*		 m_Timer;
	Timezone*		 m_TouchedTimezone;
	
	// World map
	CustomFrontView* m_FirstPart;
	CustomFrontView* m_SecondPart;
	
	// Sun map
	SunMapView*		 m_FirstSunMap;
	SunMapView*		 m_SecondSunMap;
	
	// Timezones
	UIImageView*	 m_FirstTimezone;
	UIImageView*	 m_SecondTimezone;
	
	Timezone*		 m_CurrentTimezone;
	ClockView*		 m_Clock;
	BOOL			 m_IsDSTAvailable;

}

@property (nonatomic, retain) UIView* view;
@property (nonatomic, retain) Timezone* touchedTimezone;

- (id)initWithDST:(BOOL)isDSTAvailable;
//- (void)viewWillAppear;
- (void)updateHour;
- (void)updateMap;
- (void)updateCity;
- (void)updateSunMap;
- (void)willToggleViews;
- (void)didToggleViews;
- (void)didSelectTimezone:(id)object;  
- (void)didUnselectTimezone;
- (void)displayTimezone:(Timezone*)timezone;
- (void)displayClockWithHour:(NSInteger)hour andMin:(NSInteger)min;
@end
