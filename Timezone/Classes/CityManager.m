//
//  CityManager.m
//  Timezone
//
//  Created by Stéphane Chrétien on 30/04/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "CityManager.h"

#import "TimezoneNotifications.h"
#import "City.h"


@implementation CityManager
	
@synthesize cityList = m_CityList;

- (id)init {
	if (self = [super init]) {
		m_CityList = [[NSMutableArray array] retain];
	}
	return self;
}

- (void)dealloc {
	[m_CityList release];
	[super dealloc];
}

#pragma mark Setters / Getters
- (NSInteger)currentCityIndex {
	return [[NSUserDefaults standardUserDefaults] integerForKey:@"City"];
}

- (void)setCurrentCityIndex:(NSInteger)newCityIndex {
	[[NSUserDefaults standardUserDefaults] setInteger:newCityIndex forKey:@"City"];
	[[NSNotificationCenter defaultCenter] postNotificationName:newCityNtf object:nil];
}

#pragma mark Specific methods
- (City*)currentCity {
	return [m_CityList objectAtIndex:self.currentCityIndex];
}

- (void)populate {
	// Try to retrieve a custom offset
	CGFloat customOffset = [[NSUserDefaults standardUserDefaults] floatForKey:@"CustomPositionKey"];

	City* city;
	city = [[City alloc] initWithName:NSLocalizedString(@"CustomPositio", nil) andOffset:customOffset]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Apia"			, nil) andOffset:  0.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Honolulu"		, nil) andOffset: 25.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Anchorage"	, nil) andOffset: 40.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"LosAngeles"	, nil) andOffset: 81.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Calgary"		, nil) andOffset: 84.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Mexico"		, nil) andOffset:104.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"NewYork"		, nil) andOffset:141.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Santiago"		, nil) andOffset:143.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"SaoPaulo"		, nil) andOffset:179.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Fernando"		, nil) andOffset:198.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Praia"		, nil) andOffset:204.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"London"		, nil) andOffset:240.]; [m_CityList addObject:city]; [city release];	
	city = [[City alloc] initWithName:NSLocalizedString(@"Paris"		, nil) andOffset:242.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Cairo"		, nil) andOffset:280.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Moscow"		, nil) andOffset:290.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Dubai"		, nil) andOffset:312.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Karachi"		, nil) andOffset:328.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Mumbai"		, nil) andOffset:337.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Kathmandu"	, nil) andOffset:354.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Dhaka"		, nil) andOffset:360.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Yangon"		, nil) andOffset:368.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Jakarta"		, nil) andOffset:282.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"HongKong"		, nil) andOffset:392.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Tokyo"		, nil) andOffset:426.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Adelaide"		, nil) andOffset:424.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Sydney"		, nil) andOffset:442.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Nouméa"		, nil) andOffset:462.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Auckland"		, nil) andOffset:472.]; [m_CityList addObject:city]; [city release];
	city = [[City alloc] initWithName:NSLocalizedString(@"Nukualofa"	, nil) andOffset:479.]; [m_CityList addObject:city]; [city release];
}

@end
