//
//  Timezone.h
//  Timezone
//
//  Created by Stéphane Chrétien on 23/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Timezone : NSObject {
	NSString*		m_ImgFileName;
	UIImage*		m_Image;
	CGFloat			m_MinLimit;
	CGFloat			m_MaxLimit;
	NSTimeZone*		m_NSTimezone;
}

@property (nonatomic, retain) NSString* imgFileName;
@property CGFloat minLimit;
@property CGFloat maxLimit;
@property (nonatomic, retain) UIImage* image;
@property (nonatomic, retain) NSTimeZone* nsTimezone;

- (BOOL)isInside:(CGPoint)point;

@end
