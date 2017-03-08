//
//  Map.m
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "Map.h"


@implementation Map

@synthesize name        = m_Name;
@synthesize mapFileName = m_MapFileName;
@synthesize isLegal     = m_IsLegal;

- (id)initWithName:(NSString*)iName andFileName:(NSString*)iFileName{
	if (self = [super init]) {
		self.name		 = iName;
		self.mapFileName = iFileName;
		self.isLegal	 = NO;
	}
	return self;
}

- (void)dealloc {
	self.name		 = nil;
	self.mapFileName = nil;
	
	[super dealloc];
}
	
@end
