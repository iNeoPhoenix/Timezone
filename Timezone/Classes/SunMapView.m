//
//  SunMap.m
//  Timezone
//
//  Created by Stéphane Chrétien on 15/06/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "SunMapView.h"


@implementation SunMapView

@synthesize useNightMap = m_UseNightMap;

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		self.backgroundColor = [UIColor clearColor];
		self.userInteractionEnabled = NO;
		self.multipleTouchEnabled = YES;
		
		m_UseNightMap = NO;
		
		// Init
		m_Declinaison = 0;
		m_AngularHour = 0;
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark UIView methods
- (void)drawRect:(CGRect)rect {
	if (m_UseNightMap) {
		// A. USE NIGHT MAP
		
		// Create a new path 
		CGContextRef context = UIGraphicsGetCurrentContext(); 
		CGMutablePathRef path = CGPathCreateMutable(); 
		
		CGFloat degreeToRadian = M_PI / 180.;
		CGFloat tanLat, arcTanLat;
		// the size of the world map is 480x320 pix.
		CGFloat y0 = 160., x0 = 240.; // the center of the map is at x0, y0
		CGFloat y;
		CGFloat longitude;
		
		// First Point
		longitude = -180 + m_AngularHour;
		tanLat = - cosf(longitude*degreeToRadian) / tanf(m_Declinaison*degreeToRadian);						
		arcTanLat = atanf(tanLat) / degreeToRadian;
		y = y0 - arcTanLat * 160./90;
		
		CGPathMoveToPoint(path, NULL, x0 - 240, 320-y);
		
		// Curve
		for (NSInteger i = -180; i <= 180; i++) {
			longitude = i + m_AngularHour + 1;
			tanLat = - cosf(longitude*degreeToRadian) / tanf(m_Declinaison*degreeToRadian);		
			arcTanLat = atanf(tanLat) / degreeToRadian;
			y = y0 - arcTanLat * 160./90;
			
			CGPathAddLineToPoint(path, NULL, x0+(i+1)*240./180, 320-y);
		}
		if (m_Declinaison > 0) {
			CGPathAddLineToPoint(path, NULL, 480, 320);
			CGPathAddLineToPoint(path, NULL, 0, 320);
		} else if (m_Declinaison < 0) {
			CGPathAddLineToPoint(path, NULL, 480, -320);
			CGPathAddLineToPoint(path, NULL, 0, -320);
		}
		
		CGContextAddPath(context, path);
		
		CGContextClip(context); 
		[[UIImage imageNamed:@"Map_Night.png"] drawInRect:CGRectMake(0, 0, 480, 320)]; 
		CFRelease(path);
		
	} else {
		// B. NO NIGHT MAP
		
		CGContextRef context = UIGraphicsGetCurrentContext();
		CGContextSetRGBFillColor(context, 0., 0., 0., .3);	
		
		// Shadow
		/*
		 CGSize          shadowOffset = CGSizeMake (0, 10); 
		 float           colorValues[] = {0, 0, 0, 1.}; 
		 CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB (); 
		 CGColorRef color = CGColorCreate (colorSpace, colorValues); 
		 
		 CGContextSetShadowWithColor (context, shadowOffset, 3, color);
		 
		 CGColorRelease (color); 
		 CGColorSpaceRelease (colorSpace); 
		 CGContextRestoreGState(context); 
		 */
		
		// Useful
		CGFloat degreeToRadian = M_PI / 180.;
		CGFloat tanLat, arcTanLat;
		// the size of the world map is 480x320 pix.
		CGFloat y0 = 160., x0 = 240.; // the center of the map is at x0, y0
		CGFloat y;
		CGFloat longitude;
		
		// First Point
		longitude = -180 + m_AngularHour;
		tanLat = - cosf(longitude*degreeToRadian) / tanf(m_Declinaison*degreeToRadian);						
		arcTanLat = atanf(tanLat) / degreeToRadian;
		y = y0 - arcTanLat * 160./90;
		
		CGContextMoveToPoint(context, x0 - 240, 320-y);
		
		// Curve
		for (NSInteger i = -180; i <= 180; i++) {
			longitude = i + m_AngularHour + 1;
			tanLat = - cosf(longitude*degreeToRadian) / tanf(m_Declinaison*degreeToRadian);		
			arcTanLat = atanf(tanLat) / degreeToRadian;
			y = y0 - arcTanLat * 160./90;
			//NSLog(@"i: %d long: %f tanLat: %f arcTanLat: %f y: %f", i, longitude, tanLat, arcTanLat,  y);
			
			CGContextAddLineToPoint(context, x0+(i+1)*240./180, 320-y);
		}
		if (m_Declinaison > 0) {
			CGContextAddLineToPoint(context, 480, 320);
			CGContextAddLineToPoint(context, 0, 320);
		} else if (m_Declinaison < 0) {
			CGContextAddLineToPoint(context, 480, -320);
			CGContextAddLineToPoint(context, 0, -320);
		}
		CGContextFillPath(context);
		
	}
}

#pragma mark Specific methods
-(void)setUseNightMap:(BOOL)iUseNightMap {
	m_UseNightMap = iUseNightMap;
	[self setNeedsDisplay];
}

- (void)setGMTTimeInMin:(CGFloat)min {
	NSInteger minInADay = 60*24;
	m_AngularHour = (min / minInADay) * 360;
}

- (void)setMonth:(NSInteger)month andDay:(NSInteger)day {
	CGFloat degreeToRadian = M_PI / 180.;
	
	NSInteger dayInYear = month * 30.4 + day - 8.9;
	CGFloat	dayInAngle = dayInYear * 360. / 366 - 180;
	
	m_Declinaison = 23.4 * cosf(dayInAngle * degreeToRadian);
	
	if (m_Declinaison == 0) m_Declinaison += 0.01;
}

@end
