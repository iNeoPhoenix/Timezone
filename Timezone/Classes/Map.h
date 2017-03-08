//
//  Map.h
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Map : NSObject {
	NSString*	m_Name;
	NSString*	m_MapFileName;
	BOOL		m_IsLegal;
}

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* mapFileName;
@property BOOL isLegal;

- (id)initWithName:(NSString*)iName andFileName:(NSString*)iFileName;

@end
