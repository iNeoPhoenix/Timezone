//
//  frontViewController.m
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "frontViewController.h"
#import "TimezoneNotifications.h"
#import "TimezoneAppDelegate.h"
#import "CityManager.h"
#import "MapManager.h"
#import "City.h"
#import "Map.h"
#import "CustomFrontView.h"
#import "Timezone.h"
#import "TimezoneManager.h"
#import "ClockView.h"
#import "SunMapView.h"
#import "CustomRootView.h"

@implementation FrontViewController

@synthesize view = m_View;
@synthesize touchedTimezone = m_TouchedTimezone;

- (id)initWithDST:(BOOL)isDSTAvailable {
	if (self = [super init]) {
		m_IsDSTAvailable = isDSTAvailable;
		
		// Content view
		m_View = [[CustomRootView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		
		// World maps
		m_FirstPart = [[CustomFrontView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[m_View addSubview:m_FirstPart];
		m_SecondPart = [[CustomFrontView alloc] initWithFrame:CGRectMake(480, 0, 480, 320)];
		[m_View addSubview:m_SecondPart];
	
		// Sun map
		m_FirstSunMap = [[SunMapView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[m_View addSubview:m_FirstSunMap];
		
		m_SecondSunMap = [[SunMapView alloc] initWithFrame:CGRectMake(480, 0, 480, 320)];
		[m_View addSubview:m_SecondSunMap];
		
		UIImageView* coin = [[UIImageView alloc] initWithFrame:CGRectMake(400, 240, 80, 80)];
		coin.image = [UIImage imageNamed:@"coin.png"];
		[m_View addSubview:coin];
		[coin release];
	
		// Timezone views
		m_FirstTimezone = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[m_View addSubview:m_FirstTimezone];
		
		m_SecondTimezone = [[UIImageView alloc] initWithFrame:CGRectMake(480, 0, 480, 320)];
		[m_View addSubview:m_SecondTimezone];
		
		// Clock
		m_Clock = [[ClockView alloc] init];
		[m_Clock hide];
		[m_View addSubview:m_Clock];
		
		[self updateMap];
		[self updateCity];
		
		// Notifications
		NSNotificationCenter* notificationCenter = [NSNotificationCenter defaultCenter];
		[notificationCenter addObserver:self selector:@selector(updateMap)			 name:newMapNtf				 object:nil];
		[notificationCenter addObserver:self selector:@selector(updateCity)			 name:newCityNtf			 object:nil];
		[notificationCenter addObserver:self selector:@selector(didSelectTimezone:)  name:didSelectTimezoneNtf   object:nil];
		[notificationCenter addObserver:self selector:@selector(didUnselectTimezone) name:didUnselectTimezoneNtf object:nil];
	}
	return self;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[m_Timer invalidate];
	[m_TouchedTimezone release];
	
	[m_Clock			release];
	[m_FirstPart		release];
	[m_SecondPart		release];
	[m_FirstSunMap		release];
	[m_SecondSunMap		release];
	[m_FirstTimezone	release];
	[m_SecondTimezone	release];
	[m_View				release];
	
    [super				dealloc];
}

#pragma mark Specific methods
- (void)updateMap {
	MapManager* mapManager = [TimezoneAppDelegate instance].mapManager;
	Map* currentMap = [mapManager currentMap];
	
	BOOL useNightMap = currentMap.isLegal;
	m_FirstSunMap.useNightMap = useNightMap;
	m_SecondSunMap.useNightMap = useNightMap;
	
	[m_FirstPart  setWorldMap:[UIImage imageNamed:currentMap.mapFileName]];
	[m_SecondPart setWorldMap:[UIImage imageNamed:currentMap.mapFileName]];
}

- (void)updateCity {
	CityManager* cityManager = [TimezoneAppDelegate instance].cityManager;
	City* currentCity = [cityManager currentCity];
	
	NSInteger delta;
	if (currentCity.offset > 240) {
		delta = currentCity.offset - 240;
	} else {
		delta = currentCity.offset + 240;
	}
	m_FirstPart.frame  = CGRectMake(-delta, 0, 480, 320);
	m_FirstSunMap.frame = m_FirstPart.frame;
	m_FirstTimezone.frame = m_FirstPart.frame;
	m_SecondPart.frame = CGRectMake(480 - delta, 0, 480, 320);
	m_SecondSunMap.frame = m_SecondPart.frame;
	m_SecondTimezone.frame = m_SecondPart.frame;
}

- (void)updateSunMap {
	// 1. Get local infos
	NSDate* date = [NSDate date];
	NSCalendar* calendar = [NSCalendar currentCalendar];
	//	  Hour
	NSDateComponents* components = [calendar components:kCFCalendarUnitHour fromDate:date];
	NSInteger hour = components.hour;
	//    Minute
	components = [calendar components:kCFCalendarUnitMinute fromDate:date];
	NSInteger minute = components.minute;
	//    Month
	NSDateComponents* monthComponent = [calendar components:NSMonthCalendarUnit fromDate:date];
	NSInteger month = monthComponent.month;
	//    Day
	NSDateComponents* dayComponent = [calendar components:NSDayCalendarUnit fromDate:date];
	NSInteger day = dayComponent.day;
	
	// 2. Get delta from local timezone to gmt (take daylight saving into account)
	NSTimeZone* localTimezone = [NSTimeZone localTimeZone];//systemTimeZone
	NSInteger secOffsetFromGMTToLocal    = [localTimezone secondsFromGMT]; //GMT without DST
	NSInteger minuteOffsetFromGMTToLocal = secOffsetFromGMTToLocal/60;
	NSInteger gmtTimeInMin = hour*60 + minute - minuteOffsetFromGMTToLocal;
	
	// 3. Update maps
	[m_FirstSunMap setGMTTimeInMin:gmtTimeInMin];
	[m_FirstSunMap setMonth:month andDay:day];
	
	[m_SecondSunMap setGMTTimeInMin:gmtTimeInMin];
	[m_SecondSunMap setMonth:month andDay:day];
}

- (void)willToggleViews {
	[m_FirstPart  willToggleViews];
	[m_SecondPart willToggleViews];
}

- (void)didToggleViews {
	[m_FirstPart  didToggleViews];
	[m_SecondPart didToggleViews];
}

- (void)didSelectTimezone:(id)object {
	NSNotification* notification = (NSNotification*)object;
	CustomFrontView* customFrontView = (CustomFrontView*)notification.object;
	
	CGPoint touchedPoint = customFrontView.touchedPoint;
	
	TimezoneAppDelegate* appDelegate = (TimezoneAppDelegate*) ([UIApplication sharedApplication].delegate);
	TimezoneManager* timezoneManager = appDelegate.timezoneManager;
	
	NSArray* allTimezones =  timezoneManager.timezoneList;
	
	NSInteger nbTimezones = [allTimezones count];
	Timezone* timezone;
	
	for (NSInteger index = 0; index < nbTimezones; index++) {
		
		timezone = (Timezone*) [allTimezones objectAtIndex:index];
		
		if ([timezone isInside:touchedPoint]) {
			if (m_CurrentTimezone != timezone) {
				m_CurrentTimezone = timezone;
				[self displayTimezone:timezone];
			}
			break;
		}
	}
}
	
- (void)didUnselectTimezone {
	[m_Clock hide];
	m_CurrentTimezone = nil;
	
	m_FirstTimezone.image = nil;
	m_SecondTimezone.image = nil;
}

- (void)displayTimezone:(Timezone*)timezone {
	// Update picture
	m_FirstTimezone.image  = [timezone image];
	m_SecondTimezone.image = [timezone image];
	
	self.touchedTimezone = timezone;
	
	if (nil == m_Timer)
		m_Timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateHour) userInfo:nil repeats:YES];
	
	[self updateHour];
}

- (void)updateHour {
	// 1. Get local hour and minute
	NSDate* date = [NSDate date];
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDateComponents* components = [calendar components:kCFCalendarUnitHour fromDate:date];
	NSInteger hour = components.hour;
	components = [calendar components:kCFCalendarUnitMinute fromDate:date];
	NSInteger minute = components.minute;
	
	// 2. Get delta from local timezone to gmt (take daylight saving into account)
	NSTimeZone* localTimezone = [NSTimeZone localTimeZone];//systemTimeZone
	
	NSInteger secOffsetFromGMTToLocal    = [localTimezone secondsFromGMT];
	NSInteger hourOffsetFromGMTToLocal   = secOffsetFromGMTToLocal/3600;
	NSInteger minuteOffsetFromGMTToLocal = (secOffsetFromGMTToLocal - hourOffsetFromGMTToLocal*3600)/60;
	
	// 3. Get delta from touched timezone to gmt
	NSTimeZone* touchedNSTimezone = m_TouchedTimezone.nsTimezone;
	
	NSInteger secOffsetFromGMTToTouchedTz    = [touchedNSTimezone secondsFromGMT];
	NSInteger hourOffsetFromGMTToTouchedTz   = secOffsetFromGMTToTouchedTz/3600;
	NSInteger minuteOffsetFromGMTToTouchedTz = (secOffsetFromGMTToTouchedTz - hourOffsetFromGMTToTouchedTz*3600)/60;
	
	if ([touchedNSTimezone isDaylightSavingTimeForDate:date]) hourOffsetFromGMTToTouchedTz--; //We need to know the time without DST
	
	// 4. Compute displayed time
	NSInteger displayedHour    = hour - hourOffsetFromGMTToLocal + hourOffsetFromGMTToTouchedTz;
	NSInteger displayedMinute = minute - minuteOffsetFromGMTToLocal + minuteOffsetFromGMTToTouchedTz;
	
	// 5. Rattrap
	if (displayedHour > 23) displayedHour-=24;
	else if (displayedHour < 0) displayedHour = 24 + displayedHour;
	
	[self displayClockWithHour:displayedHour andMin:displayedMinute];
}

- (void)displayClockWithHour:(NSInteger)hour andMin:(NSInteger)min {
	// Set displayed time
	[m_Clock setDstHour:hour+1 min:min];
	[m_Clock setStdHour:hour min:min];
	
	// Display clock
	[m_Clock show];
}

@end
