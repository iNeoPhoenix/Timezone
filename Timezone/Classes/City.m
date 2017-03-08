//
//  City.m
//  Timezone
//
//  Created by Stéphane Chrétien on 30/04/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "City.h"


@implementation City

@synthesize name   = m_Name;
@synthesize offset = m_Offset;

- (id)initWithName:(NSString*)iName andOffset:(CGFloat)iOffset {
	if (self = [super init]) {
		self.name   = iName;
		self.offset = iOffset;
	}
	return self;
}

- (void)dealloc {
	self.name = nil;
	
	[super dealloc];
}

- (void)setOffset:(CGFloat)iOffset {
	if (iOffset < 0)   iOffset = 0.;
	if (iOffset > 479) iOffset = 479.;
	
	m_Offset = iOffset;
}

@end
