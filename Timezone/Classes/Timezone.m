//
//  Timezone.m
//  Timezone
//
//  Created by Stéphane Chrétien on 23/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "Timezone.h"


@implementation Timezone

@synthesize imgFileName = m_ImgFileName;
@synthesize minLimit	= m_MinLimit;
@synthesize maxLimit	= m_MaxLimit;
@synthesize image		= m_Image;
@synthesize nsTimezone	= m_NSTimezone;

- (void)dealloc {
	self.imgFileName = nil;
	self.image		 = nil;
	self.nsTimezone  = nil;
	
	[super dealloc];	
}


#pragma mark Setters / Getters
- (void)setImgFileName:(NSString*)fileName {
	[fileName retain];
	[m_ImgFileName release];
	m_ImgFileName = fileName;
	
	self.image = [UIImage imageNamed:m_ImgFileName];
}

#pragma mark Specific methods
- (BOOL)isInside:(CGPoint)point {
	BOOL isInside = NO;
	
	CGFloat x = point.x;

	if (x < 0)    x+= 480;
	if (x >= 480) x-= 480; 
	
	if (m_MinLimit < m_MaxLimit) {
		if ((x >= m_MinLimit) && (x < m_MaxLimit)) {
			isInside = YES;
		}
	} else {
		if ( ((x < m_MaxLimit) && (x >= 0)) || ((x >= m_MinLimit) && (x < 480))) {
			isInside = YES;
		}
	}
	return isInside;
}

@end
