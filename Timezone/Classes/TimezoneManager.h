//
//  TimezoneManager.h
//  Timezone
//
//  Created by Stéphane Chrétien on 23/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Timezone;

@interface TimezoneManager : NSObject {
	NSMutableArray*	m_TimezoneList;
	BOOL m_IsDSTAvailable;
}

@property (nonatomic, readonly) NSMutableArray* timezoneList;

- (id)initWithDST:(BOOL)isDSTAvailable;
- (void)populate;
- (Timezone*)timezoneForHitPoint:(CGPoint)hitPoint;

@end
