//
//  TimezoneAppDelegate.m
//  Timezone
//
//  Created by Stéphane Chrétien on 27/04/09.
//  Copyright NeoPhoenix 2009. All rights reserved.
//

#import "TimezoneAppDelegate.h"
#import "RootViewController.h"
#import "CityManager.h"
#import "MapManager.h"
#import "TimezoneManager.h"

@implementation TimezoneAppDelegate

@synthesize window = m_Window;
@synthesize mapManager = m_MapManager;
@synthesize cityManager = m_CityManager;
@synthesize timezoneManager = m_TimezoneManager;

+ (TimezoneAppDelegate*)instance {
	return [UIApplication sharedApplication].delegate;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
	[[UIApplication sharedApplication] setStatusBarOrientation:UIInterfaceOrientationLandscapeLeft];
	
	// Check for DST in London
	NSTimeZone* GMTTimezone = [NSTimeZone timeZoneWithName:@"Europe/London"];
	BOOL isDSTAvailableForNorthHemisphere = [GMTTimezone isDaylightSavingTimeForDate:[NSDate date]];

	
	// Datas : Cities + Maps + Timezones
	m_CityManager = [[CityManager alloc] init];
	[m_CityManager populate];
	
	m_MapManager = [[MapManager alloc] init];
	[m_MapManager populate];
	
	m_TimezoneManager = [[TimezoneManager alloc] initWithDST:isDSTAvailableForNorthHemisphere];
	[m_TimezoneManager populate];
	
	
	// First launch
	[self checkFirstTimeInit];
	
	
	// Views
	m_Window.backgroundColor = [UIColor blackColor]; 
	
	m_RootViewController = [[RootViewController alloc] initWithDST:isDSTAvailableForNorthHemisphere];
	[m_Window addSubview:m_RootViewController.view];
	
	
    // Override point for customization after application launch
    [m_Window makeKeyAndVisible];
}

- (void)applicationDidBecomeActive:(UIApplication*)application {
	[m_RootViewController applicationDidBecomeActive];
}

- (void)dealloc {
	[m_RootViewController	release];
    [m_Window				release];
	[m_MapManager			release];
	[m_CityManager			release];
	[m_TimezoneManager		release];
	
    [super dealloc];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
	NSLog(@"Memory Warning...");
}

- (void)checkFirstTimeInit {
	if( 0 == [[NSUserDefaults standardUserDefaults] integerForKey:@"AlreadyLaunched"]) {
		
		[[NSUserDefaults standardUserDefaults] setFloat:240. forKey:@"CustomPositionKey"];
		
		// select a default city to center the map on
		m_CityManager.currentCityIndex = 12;
		
		// display the welcome / settings detection panel
		NSTimeZone* localTimezone = [NSTimeZone localTimeZone];//systemTimeZone 
		NSDate* date = [NSDate date];
		NSCalendar* calendar = [NSCalendar currentCalendar];
		NSDateComponents* components = [calendar components:kCFCalendarUnitHour fromDate:date];
		NSInteger hour = components.hour;
		NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
		if ([defaults boolForKey:@"clockSystem"]) {
			if (hour >= 12) {
				hour -= 12;
			}
		}
		components = [calendar components:kCFCalendarUnitMinute fromDate:date];
		NSInteger minute = components.minute;
		
		NSString* hourString = @"";
		if (hour < 10) {
			hourString = [hourString stringByAppendingString:@"0"];
		}
		hourString = [hourString stringByAppendingString:[NSString stringWithFormat:@"%d", hour]];
		
		NSString* minString = @"";
		if (minute < 10) {
			minString = [minString stringByAppendingString:@"0"];
		}
		minString = [minString stringByAppendingString:[NSString stringWithFormat:@"%d", minute]];
		
		UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DetectionPanelTitleInit", nil)
														message:[NSString stringWithFormat:NSLocalizedString(@"DetectionPanelMessage", nil), localTimezone.name, hourString, minString]
														delegate:nil 
														cancelButtonTitle:@"Ok" 
														otherButtonTitles:nil];
		[alert show];
		[alert release];	
		
		[[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"AlreadyLaunched"];
	}
}

@end
