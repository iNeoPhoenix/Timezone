//
//  CustomFrontView.h
//  Timezone
//
//  Created by Stéphane Chrétien on 23/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomFrontView : UIView {
	UIImageView* m_WorldMapImageView;
	UIImageView* m_TimezoneView;
	CGPoint m_TouchedPoint;
}

@property (readonly) CGPoint touchedPoint;

- (void)setWorldMap:(UIImage*)map;
- (void)setTimezone:(UIImage*)timezone;
- (void)willToggleViews;
- (void)didToggleViews;
- (void)handleTouchEvent:(NSSet*)touches withEvent:(UIEvent *)event isPressed:(BOOL)pressed;

@end
