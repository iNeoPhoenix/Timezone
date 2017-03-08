//
//  City.h
//  Timezone
//
//  Created by Stéphane Chrétien on 30/04/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject {
	NSString*	m_Name;
	CGFloat		m_Offset;
}

@property (nonatomic, retain) NSString* name;
@property CGFloat offset;

- (id)initWithName:(NSString*)iName andOffset:(CGFloat)iOffset;

@end
