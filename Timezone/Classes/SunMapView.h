//
//  SunMap.h
//  Timezone
//
//  Created by Stéphane Chrétien on 15/06/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SunMapView : UIView {
	CGFloat		m_Declinaison;
	CGFloat		m_AngularHour;
	BOOL		m_UseNightMap;
}

@property (assign) BOOL useNightMap;

- (void)setGMTTimeInMin:(CGFloat)min;
- (void)setMonth:(NSInteger)month andDay:(NSInteger)day;

@end
