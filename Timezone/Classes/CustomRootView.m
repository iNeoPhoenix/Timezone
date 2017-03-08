//
//  CustomRootView.m
//  Timezone
//
//  Created by Stéphane Chrétien on 03/02/10.
//  Copyright 2010 Cokoala. All rights reserved.
//

#import "CustomRootView.h"
#import "City.h"
#import "CityManager.h"
#import "TimezoneAppDelegate.h"
#import "TimezoneNotifications.h"

@implementation CustomRootView


- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.multipleTouchEnabled = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (void)dealloc {
    [super dealloc];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet* allTouches = [event allTouches];
	NSInteger count = [allTouches count];
		
	if (count == 2) {
		CityManager* cityManager = [TimezoneAppDelegate instance].cityManager;
		City* currentCity = [cityManager currentCity];
		cityManager.currentCityIndex = 0;
		[cityManager currentCity].offset = currentCity.offset;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet* allTouches = [event allTouches];
	NSInteger count = [allTouches count];
		
	if (count == 2) {
		NSArray* touchArray = [allTouches allObjects];
		UITouch* first   = [touchArray objectAtIndex:0];
		UITouch* second	 = [touchArray objectAtIndex:1];
		
		CGPoint firstCurrent	= [first locationInView:self];
		CGPoint firstPrevious	= [first previousLocationInView:self];
		
		CGPoint secondCurrent	= [second locationInView:self];
		CGPoint secondPrevious	= [second previousLocationInView:self];
		
		CGFloat deltaFirst = firstCurrent.x - firstPrevious.x;
		CGFloat deltaSecond = secondCurrent.x - secondPrevious.x;
		
		CGFloat delta = (deltaFirst + deltaSecond)/2;
		
		CityManager* cityManager = [TimezoneAppDelegate instance].cityManager;
		City* currentCity = [cityManager currentCity];
			
		currentCity.offset = currentCity.offset - delta;
		[[NSNotificationCenter defaultCenter] postNotificationName:newCityNtf object:nil];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSSet* allTouches = [event allTouches];
	NSInteger count = [allTouches count];
	
	if (count == 2) {
		CityManager* cityManager = [TimezoneAppDelegate instance].cityManager;
		if (cityManager.currentCityIndex == 0) {
			[[NSUserDefaults standardUserDefaults] setFloat:[cityManager currentCity].offset forKey:@"CustomPositionKey"];
		}
	}
}

@end
