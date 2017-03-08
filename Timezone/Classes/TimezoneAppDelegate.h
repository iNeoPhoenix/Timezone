//
//  TimezoneAppDelegate.h
//  Timezone
//
//  Created by Stéphane Chrétien on 27/04/09.
//  Copyright NeoPhoenix 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController, CityManager, MapManager, TimezoneManager;

@interface TimezoneAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow*			m_Window;
	RootViewController* m_RootViewController;
	CityManager*		m_CityManager;
	MapManager*			m_MapManager;
	TimezoneManager*	m_TimezoneManager;
}

@property (nonatomic, retain) UIWindow* window;
@property (nonatomic, readonly) CityManager* cityManager;
@property (nonatomic, readonly) MapManager* mapManager;
@property (nonatomic, readonly) TimezoneManager* timezoneManager;

+ (TimezoneAppDelegate*)instance;
- (void)checkFirstTimeInit;

@end
