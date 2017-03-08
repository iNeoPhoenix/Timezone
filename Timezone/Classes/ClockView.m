//
//  ClockView.m
//  Timezone
//
//  Created by Stéphane Chrétien on 04/06/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "ClockView.h"


@implementation ClockView

- (id)init {	
	if (self = [super initWithFrame:CGRectZero]) {
		self.multipleTouchEnabled = YES;
		
		// Check settings
		NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
		m_IsAMPMClock = [defaults boolForKey:@"clockSystem"];
		
		m_Back = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clockdst.png"]];
		m_Back.frame = CGRectMake(90, 260, 300, 45);
		[self addSubview:m_Back];
		
		m_DstHourDec	= [[UIImageView alloc] initWithFrame:CGRectMake(113, 267, 20, 30)]; [self addSubview:m_DstHourDec];
		m_DstHourUnit	= [[UIImageView alloc] initWithFrame:CGRectMake(138, 267, 20, 30)]; [self addSubview:m_DstHourUnit];
		m_DstDots		= [[UIImageView alloc] initWithFrame:CGRectMake(158, 267, 15, 30)]; [self addSubview:m_DstDots];
		m_DstMinDec		= [[UIImageView alloc] initWithFrame:CGRectMake(172, 267, 20, 30)]; [self addSubview:m_DstMinDec];
		m_DstMinUnit	= [[UIImageView alloc] initWithFrame:CGRectMake(197, 267, 20, 30)]; [self addSubview:m_DstMinUnit];
		
		m_StdHourDec	= [[UIImageView alloc] initWithFrame:CGRectMake(263, 267, 20, 30)]; [self addSubview:m_StdHourDec];
		m_StdHourUnit	= [[UIImageView alloc] initWithFrame:CGRectMake(288, 267, 20, 30)]; [self addSubview:m_StdHourUnit];
		m_StdDots		= [[UIImageView alloc] initWithFrame:CGRectMake(308, 267, 15, 30)]; [self addSubview:m_StdDots];
		m_StdMinDec		= [[UIImageView alloc] initWithFrame:CGRectMake(322, 267, 20, 30)]; [self addSubview:m_StdMinDec];
		m_StdMinUnit	= [[UIImageView alloc] initWithFrame:CGRectMake(347, 267, 20, 30)]; [self addSubview:m_StdMinUnit];

		// AM/PM
		if (m_IsAMPMClock) {
			m_AMPMDstHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(88, 275, 30, 15)];
			m_AMPMDstHourLabel.transform = CGAffineTransformMakeRotation(-90 * M_PI / 180);
			m_AMPMDstHourLabel.font = [UIFont systemFontOfSize:14];
			m_AMPMDstHourLabel.backgroundColor = [UIColor clearColor];
			m_AMPMDstHourLabel.textColor = [UIColor whiteColor];
			m_AMPMDstHourLabel.textAlignment = UITextAlignmentCenter;
			[self addSubview:m_AMPMDstHourLabel];
			
			m_AMPMStdHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(362, 275, 30, 15)];
			m_AMPMStdHourLabel.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
			m_AMPMStdHourLabel.font = [UIFont systemFontOfSize:14];
			m_AMPMStdHourLabel.backgroundColor = [UIColor clearColor];
			m_AMPMStdHourLabel.textColor = [UIColor whiteColor];
			m_AMPMStdHourLabel.textAlignment = UITextAlignmentCenter;
			[self addSubview:m_AMPMStdHourLabel];
		}
		
		// Chiffres
		m_Empty		= [[UIImage imageNamed:@"empty.png"]	 retain];
		m_Dots		= [[UIImage imageNamed:@"dots.png"]		 retain];
		m_DotsEmpty = [[UIImage imageNamed:@"dotsempty.png"] retain];
		m_Zero		= [[UIImage imageNamed:@"zero.png"]		 retain];
		m_Un		= [[UIImage imageNamed:@"un.png"]		 retain];
		m_Deux		= [[UIImage imageNamed:@"deux.png"]		 retain];
		m_Trois		= [[UIImage imageNamed:@"trois.png"]	 retain];
		m_Quatre	= [[UIImage imageNamed:@"quatre.png"]	 retain];
		m_Cinq		= [[UIImage imageNamed:@"cinq.png"]		 retain];
		m_Six		= [[UIImage imageNamed:@"six.png"]		 retain];
		m_Sept		= [[UIImage imageNamed:@"sept.png"]		 retain];
		m_Huit		= [[UIImage imageNamed:@"huit.png"]		 retain];
		m_Neuf		= [[UIImage imageNamed:@"neuf.png"]		 retain];
	}
	return self;
}

- (void)dealloc {
	[m_Back			release];
	[m_StdHourDec	release];
	[m_StdHourUnit	release];
	[m_StdDots		release];
	[m_StdMinDec	release];
	[m_StdMinUnit	release];
	[m_DstHourDec	release];
	[m_DstHourUnit	release];
	[m_DstDots		release];
	[m_DstMinDec	release];
	[m_DstMinUnit	release];
	
	[m_Empty		release];
	[m_Dots			release];
	[m_DotsEmpty	release];
	[m_Zero			release];
	[m_Un			release];
	[m_Deux			release];
	[m_Trois		release];
	[m_Quatre		release];
	[m_Cinq			release];
	[m_Six			release];
	[m_Sept			release];
	[m_Huit			release];
	[m_Neuf			release];
	
	[m_AMPMStdHourLabel	release];
	[m_AMPMDstHourLabel	release];
	
	[m_Timer invalidate]; /*[m_Timer release];*/ m_Timer = nil;
	
    [super dealloc];
}

#pragma mark Specific methods
// TODO : surcharger les setters setHidden
- (void)hide {
	self.hidden = YES;

	m_DotsAreShown = NO;
	if (nil != m_Timer) {
		[m_Timer invalidate]; /*[m_Timer release];*/ m_Timer = nil;
	}
}

- (void)show {
	self.hidden = NO;
	if (nil == m_Timer)
		m_Timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateDots) userInfo:nil repeats:YES];
}

- (void)updateDots {
	m_DotsAreShown = !m_DotsAreShown;
	
	if(m_DotsAreShown) {
		m_StdDots.image = m_Dots;
		m_DstDots.image = m_Dots;
	} else {
		m_StdDots.image = m_DotsEmpty;
		m_DstDots.image = m_DotsEmpty;
	}
}

- (void)setStdHour:(NSInteger)hour min:(NSInteger)min {
	
	if (m_IsAMPMClock) {
		if (hour >= 12) {
			hour -= 12;
			m_AMPMStdHourLabel.text = @"PM";
		} else {
			m_AMPMStdHourLabel.text = @"AM";
		}
	}
	
	NSInteger hourUnit;
	if (hour >= 20) {
		m_StdHourDec.image	= m_Deux;
		hourUnit = hour - 20;
	} else if (hour >= 10) {
		m_StdHourDec.image	= m_Un;
		hourUnit = hour - 10;
	} else {
		m_StdHourDec.image	= m_Empty;
		hourUnit = hour;
	}
		
	if (hourUnit == 0) m_StdHourUnit.image = m_Zero;
	else if (hourUnit == 1) m_StdHourUnit.image = m_Un;
	else if (hourUnit == 2) m_StdHourUnit.image = m_Deux;
	else if (hourUnit == 3) m_StdHourUnit.image = m_Trois;
	else if (hourUnit == 4) m_StdHourUnit.image = m_Quatre;
	else if (hourUnit == 5) m_StdHourUnit.image = m_Cinq;
	else if (hourUnit == 6) m_StdHourUnit.image = m_Six;
	else if (hourUnit == 7) m_StdHourUnit.image = m_Sept;
	else if (hourUnit == 8) m_StdHourUnit.image = m_Huit;
	else if (hourUnit == 9) m_StdHourUnit.image = m_Neuf;
	
	// Min
	NSInteger minDec = min / 10;	
	if (minDec == 0) m_StdMinDec.image = m_Zero;
	else if (minDec == 1) m_StdMinDec.image = m_Un;
	else if (minDec == 2) m_StdMinDec.image = m_Deux;
	else if (minDec == 3) m_StdMinDec.image = m_Trois;
	else if (minDec == 4) m_StdMinDec.image = m_Quatre;
	else if (minDec == 5) m_StdMinDec.image = m_Cinq;
	else if (minDec == 6) m_StdMinDec.image = m_Six;
	else if (minDec == 7) m_StdMinDec.image = m_Sept;
	else if (minDec == 8) m_StdMinDec.image = m_Huit;
	else if (minDec == 9) m_StdMinDec.image = m_Neuf;
	
	NSInteger minUnit = min - 10*minDec;
	if (minUnit == 0) m_StdMinUnit.image = m_Zero;
	else if (minUnit == 1) m_StdMinUnit.image = m_Un;
	else if (minUnit == 2) m_StdMinUnit.image = m_Deux;
	else if (minUnit == 3) m_StdMinUnit.image = m_Trois;
	else if (minUnit == 4) m_StdMinUnit.image = m_Quatre;
	else if (minUnit == 5) m_StdMinUnit.image = m_Cinq;
	else if (minUnit == 6) m_StdMinUnit.image = m_Six;
	else if (minUnit == 7) m_StdMinUnit.image = m_Sept;
	else if (minUnit == 8) m_StdMinUnit.image = m_Huit;
	else if (minUnit == 9) m_StdMinUnit.image = m_Neuf;
}

- (void)setDstHour:(NSInteger)hour min:(NSInteger)min {

	if (hour == 24) hour = 0;
	
	if (m_IsAMPMClock) {
		if (hour >= 12) {
			hour -= 12;
			m_AMPMDstHourLabel.text = @"PM";
		} else {
			m_AMPMDstHourLabel.text = @"AM";
		}
	}
	
	NSInteger hourUnit;
	if (hour >= 20) {
		m_DstHourDec.image	= m_Deux;
		hourUnit = hour - 20;
	} else if (hour >= 10) {
		m_DstHourDec.image	= m_Un;
		hourUnit = hour - 10;
	} else {
		m_DstHourDec.image	= m_Empty;
		hourUnit = hour;
	} 
	
	if (hourUnit == 0) m_DstHourUnit.image = m_Zero;
	else if (hourUnit == 1) m_DstHourUnit.image = m_Un;
	else if (hourUnit == 2) m_DstHourUnit.image = m_Deux;
	else if (hourUnit == 3) m_DstHourUnit.image = m_Trois;
	else if (hourUnit == 4) m_DstHourUnit.image = m_Quatre;
	else if (hourUnit == 5) m_DstHourUnit.image = m_Cinq;
	else if (hourUnit == 6) m_DstHourUnit.image = m_Six;
	else if (hourUnit == 7) m_DstHourUnit.image = m_Sept;
	else if (hourUnit == 8) m_DstHourUnit.image = m_Huit;
	else if (hourUnit == 9) m_DstHourUnit.image = m_Neuf;
	
	// Min
	NSInteger minDec = min / 10;	
	if (minDec == 0) m_DstMinDec.image = m_Zero;
	else if (minDec == 1) m_DstMinDec.image = m_Un;
	else if (minDec == 2) m_DstMinDec.image = m_Deux;
	else if (minDec == 3) m_DstMinDec.image = m_Trois;
	else if (minDec == 4) m_DstMinDec.image = m_Quatre;
	else if (minDec == 5) m_DstMinDec.image = m_Cinq;
	else if (minDec == 6) m_DstMinDec.image = m_Six;
	else if (minDec == 7) m_DstMinDec.image = m_Sept;
	else if (minDec == 8) m_DstMinDec.image = m_Huit;
	else if (minDec == 9) m_DstMinDec.image = m_Neuf;
	
	NSInteger minUnit = min - 10*minDec;
	if (minUnit == 0) m_DstMinUnit.image = m_Zero;
	else if (minUnit == 1) m_DstMinUnit.image = m_Un;
	else if (minUnit == 2) m_DstMinUnit.image = m_Deux;
	else if (minUnit == 3) m_DstMinUnit.image = m_Trois;
	else if (minUnit == 4) m_DstMinUnit.image = m_Quatre;
	else if (minUnit == 5) m_DstMinUnit.image = m_Cinq;
	else if (minUnit == 6) m_DstMinUnit.image = m_Six;
	else if (minUnit == 7) m_DstMinUnit.image = m_Sept;
	else if (minUnit == 8) m_DstMinUnit.image = m_Huit;
	else if (minUnit == 9) m_DstMinUnit.image = m_Neuf;
}

@end
