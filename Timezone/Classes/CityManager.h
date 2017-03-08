//
//  CityManager.h
//  Timezone
//
//  Created by Stéphane Chrétien on 30/04/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@class City;

@interface CityManager : NSObject {
	NSMutableArray*		m_CityList;
}

@property (nonatomic, readonly) NSMutableArray* cityList;
@property NSInteger currentCityIndex;

- (City*)currentCity;
- (void)populate;

@end
