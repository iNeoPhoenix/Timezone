//
//  TimezoneManager.m
//  Timezone
//
//  Created by Stéphane Chrétien on 23/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "TimezoneManager.h"

#import "Timezone.h"


@implementation TimezoneManager

@synthesize timezoneList = m_TimezoneList;

- (id)initWithDST:(BOOL)isDSTAvailable {
	if (self = [super init]) {
		m_IsDSTAvailable = isDSTAvailable;
		m_TimezoneList	 = [[NSMutableArray array] retain];
	}
	return self;
}

- (void)dealloc {
	[m_TimezoneList release];
	[super			dealloc];
}

#pragma mark Specific methods
- (void)populate {
	// UTC -11 : Apia, Upolu, Samoa
	Timezone* timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm11.png";
	else timezone.imgFileName = @"dstSouthUTCm11.png";
	timezone.minLimit = 10.;
	timezone.maxLimit = 30.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Pacific/Apia"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -10 : Honolulu, Oahu, Hawaii, USA
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm10.png";
	else timezone.imgFileName = @"dstSouthUTCm10.png";
	timezone.minLimit = 30.;
	timezone.maxLimit = 50.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Pacific/Honolulu"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -09 : Anchorage, Alaska, USA
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm09.png";
	else timezone.imgFileName = @"dstSouthUTCm09.png";
	timezone.minLimit = 50.;
	timezone.maxLimit = 70.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"America/Anchorage"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -08 : Los Angeles, California, USA
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm08.png";
	else timezone.imgFileName = @"dstSouthUTCm08.png";
	timezone.minLimit = 70.;
	timezone.maxLimit = 90.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"America/Los_Angeles"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -07 : Calgary, Alberta, Canada
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm07.png";
	else timezone.imgFileName = @"dstSouthUTCm07.png";
	timezone.minLimit = 90.;
	timezone.maxLimit = 110.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"America/Edmonton"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -06 : Mexico City, Mexico
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm06.png";
	else timezone.imgFileName = @"dstSouthUTCm06.png";
	timezone.minLimit = 110.;
	timezone.maxLimit = 130.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"America/Mexico_City"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -05 : New York City, USA
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm05.png";
	else timezone.imgFileName = @"dstSouthUTCm05.png";
	timezone.minLimit = 130.;
	timezone.maxLimit = 150.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"America/New_York"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -04 : Santiago, Chile
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm04.png";
	else timezone.imgFileName = @"dstSouthUTCm04.png";
	timezone.minLimit = 150.;
	timezone.maxLimit = 170.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"America/Santiago"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -03 : São Paulo, Brazil
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm03.png";
	else timezone.imgFileName = @"dstSouthUTCm03.png";
	timezone.minLimit = 170.;
	timezone.maxLimit = 190.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"America/Sao_Paulo"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -02 : Fernando de Noronha, Brazil
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm02.png";
	else timezone.imgFileName = @"dstSouthUTCm02.png";
	timezone.minLimit = 190.;
	timezone.maxLimit = 210.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Atlantic/South_Georgia"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC -01 : Praia, Cape Verde
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCm01.png";
	else timezone.imgFileName = @"dstSouthUTCm01.png";
	timezone.minLimit = 210.;
	timezone.maxLimit = 230.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Atlantic/Cape_Verde"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC : London, United Kingdom
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTC.png";
	else timezone.imgFileName = @"dstSouthUTC.png";
	timezone.minLimit = 230.;
	timezone.maxLimit = 250.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Europe/London"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +01 : Paris, France
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp01.png";
	else timezone.imgFileName = @"dstSouthUTCp01.png";
	timezone.minLimit = 250.;
	timezone.maxLimit = 270.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Europe/Paris"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +02 : Cairo, Egypt
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp02.png";
	else timezone.imgFileName = @"dstSouthUTCp02.png";
	timezone.minLimit = 270.;
	timezone.maxLimit = 290.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Africa/Cairo"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +03 : Moscow, Russia
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp03.png";
	else timezone.imgFileName = @"dstSouthUTCp03.png";
	timezone.minLimit = 290.;
	timezone.maxLimit = 310.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Europe/Moscow"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +04 : Dubai, United Arab Emirates
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp04.png";
	else timezone.imgFileName = @"dstSouthUTCp04.png";
	timezone.minLimit = 310.;
	timezone.maxLimit = 330.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Asia/Dubai"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +05 : Karachi, Pakistan
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp05.png";
	else timezone.imgFileName = @"dstSouthUTCp05.png";
	timezone.minLimit = 330.;
	timezone.maxLimit = 350.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Asia/Karachi"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +06 : Dhaka, Bangladesh
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp06.png";
	else timezone.imgFileName = @"dstSouthUTCp06.png";
	timezone.minLimit = 350.;
	timezone.maxLimit = 370.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Asia/Dhaka"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +07 : Jakarta, Indonesia
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp07.png";
	else timezone.imgFileName = @"dstSouthUTCp07.png";
	timezone.minLimit = 370.;
	timezone.maxLimit = 390.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Asia/Jakarta"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +08 : Hong Kong, China
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp08.png";
	else timezone.imgFileName = @"dstSouthUTCp08.png";
	timezone.minLimit = 390.;
	timezone.maxLimit = 410.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Asia/Hong_Kong"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +09 : Tokyo, Japan
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp09.png";
	else timezone.imgFileName = @"dstSouthUTCp09.png";
	timezone.minLimit = 410.;
	timezone.maxLimit = 430.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Asia/Tokyo"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +10 : Sydney, Australia
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp10.png";
	else timezone.imgFileName = @"dstSouthUTCp10.png";
	timezone.minLimit = 430.;
	timezone.maxLimit = 450.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Australia/Sydney"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +11 : Nouméa, New Caledonia
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp11.png";
	else timezone.imgFileName = @"dstSouthUTCp11.png";
	timezone.minLimit = 450.;
	timezone.maxLimit = 470.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Pacific/Noumea"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
	
	// UTC +12 : Auckland, New Zealand
	timezone = [[Timezone alloc] init];
	if (m_IsDSTAvailable) timezone.imgFileName = @"dstNorthUTCp12.png";
	else timezone.imgFileName = @"dstSouthUTCp12.png";
	timezone.minLimit = 470.;
	timezone.maxLimit = 10.;
	timezone.nsTimezone = [NSTimeZone timeZoneWithName:@"Pacific/Auckland"];
	[m_TimezoneList addObject:timezone];
	[timezone release];
}

- (Timezone*)timezoneForHitPoint:(CGPoint)hitPoint {
	NSInteger nbTimezone = [m_TimezoneList count];
	
	Timezone* foundTimezone = nil;
	Timezone* timezone;
	for (NSInteger index = 0; index < nbTimezone; index++) {
		timezone = [m_TimezoneList objectAtIndex:index];
		
		if ([timezone isInside:hitPoint]) {
			foundTimezone = timezone;
			break;
		}
	}
	
	return foundTimezone;
}

@end
