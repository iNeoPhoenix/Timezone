//
//  MapManager.m
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "MapManager.h"

#import "TimezoneNotifications.h"
#import "Map.h"


@implementation MapManager

@synthesize mapList = m_MapList;

- (id)init {
	if (self = [super init]) {
		m_MapList = [[NSMutableArray array] retain];
	}
	return self;
}

- (void)dealloc {
	[m_MapList	release];
	[super		dealloc];
}

#pragma mark Setters / Getters
- (NSInteger)currentMapIndex {
	return [[NSUserDefaults standardUserDefaults] integerForKey:@"Map"];
}

- (void)setCurrentMapIndex:(NSInteger)newMapIndex {
	[[NSUserDefaults standardUserDefaults] setInteger:newMapIndex forKey:@"Map"];
	[[NSNotificationCenter defaultCenter] postNotificationName:newMapNtf object:nil];
}

#pragma mark Specific methods
- (Map*)currentMap {
	return [m_MapList objectAtIndex:self.currentMapIndex];
}

- (void)populate {
	// Get date
	NSDate* date = [NSDate date];
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDateComponents* components = [calendar components:NSMonthCalendarUnit fromDate:date];
	NSInteger month = components.month;
	if (month < 1 || month > 12) {
		month = 1;
	}
	NSString* dateTail = [@"_" stringByAppendingString:[[NSString stringWithFormat:@"%d", month] stringByAppendingString:@".png"]];
	
	Map* map;
	map = [[Map alloc] initWithName:NSLocalizedString(@"VectorBlue"			, nil) andFileName:@"Map_Design_Blue.png"								];					  [m_MapList addObject:map]; [map release];	
	map = [[Map alloc] initWithName:NSLocalizedString(@"VectorRed"			, nil) andFileName:@"Map_Design_Red.png"								];					  [m_MapList addObject:map];[map release];
	map = [[Map alloc] initWithName:NSLocalizedString(@"OldMap"				, nil) andFileName:@"Map_Old.png"										];					  [m_MapList addObject:map];[map release];
	map = [[Map alloc] initWithName:NSLocalizedString(@"NASABlueMarble"		, nil) andFileName:[@"Map_Satellite" stringByAppendingString:dateTail]	]; map.isLegal = YES; [m_MapList addObject:map];[map release];
	map = [[Map alloc] initWithName:NSLocalizedString(@"NASABlueMarbleOcean", nil) andFileName:[@"Map_BlueSat" stringByAppendingString:dateTail]	]; map.isLegal = YES; [m_MapList addObject:map];[map release];
	map = [[Map alloc] initWithName:NSLocalizedString(@"NASACityNight"		, nil) andFileName:@"Map_Night_Clear.png"								]; map.isLegal = YES; [m_MapList addObject:map];[map release];
}

@end
