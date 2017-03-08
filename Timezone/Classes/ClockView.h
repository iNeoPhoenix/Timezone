//
//  ClockView.h
//  Timezone
//
//  Created by Stéphane Chrétien on 04/06/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClockView : UIView {
	BOOL			m_IsAMPMClock;
	
	NSTimer*		m_Timer;
	BOOL			m_DotsAreShown;
	
	UIImageView*	m_Back;
	
	UIImageView*	m_StdHourDec;
	UIImageView*	m_StdHourUnit;
	UIImageView*	m_StdDots;
	UIImageView*	m_StdMinDec;
	UIImageView*	m_StdMinUnit;
	
	UIImageView*	m_DstHourDec;
	UIImageView*	m_DstHourUnit;
	UIImageView*	m_DstDots;
	UIImageView*	m_DstMinDec;
	UIImageView*	m_DstMinUnit;
	
	UILabel*		m_AMPMStdHourLabel;
	UILabel*		m_AMPMDstHourLabel;
	
	UIImage*		m_Empty;
	UIImage*		m_Dots;
	UIImage*		m_DotsEmpty;
	UIImage*		m_Zero;
	UIImage*		m_Un;
	UIImage*		m_Deux;
	UIImage*		m_Trois;
	UIImage*		m_Quatre;
	UIImage*		m_Cinq;
	UIImage*		m_Six;
	UIImage*		m_Sept;
	UIImage*		m_Huit;
	UIImage*		m_Neuf;
}

- (void)hide;
- (void)show;

- (void)updateDots;

- (void)setStdHour:(NSInteger)hour min:(NSInteger)min;
- (void)setDstHour:(NSInteger)hour min:(NSInteger)min;

@end
