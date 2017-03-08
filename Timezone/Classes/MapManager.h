//
//  MapManager.h
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Map;

@interface MapManager : NSObject {
	NSMutableArray*	m_MapList;
}

@property (nonatomic, readonly) NSMutableArray* mapList;
@property NSInteger currentMapIndex;

- (void)populate;
- (Map*)currentMap;

@end
