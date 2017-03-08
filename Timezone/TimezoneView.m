//
//  CustomImageView.m
//  Timezone
//
//  Created by Stéphane Chrétien on 24/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

//#import "TimezoneView.h"
//#import "TimezoneNotifications.h"
//
//@implementation TimezoneView
//
//@synthesize normalImage    = m_NormalImage;
//@synthesize highlightImage = m_HighlightImage;
//@synthesize highlighted    = m_Highlighted;
//
//- (void)dealloc {
//	self.normalImage    = nil;
//	self.highlightImage = nil;
//	
//    [super dealloc];
//}
//
//#pragma mark Secific methods
///*
//- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event { 
//	long startByte = (int)((point.y * m_Size.width) + point.x) * 4; 
//	int alpha = (unsigned char) m_Bitmap[startByte]; 
//	return (alpha > 0.1);
//} 
//*/
//- (void)setHighlighted:(BOOL)highlighted {
//	if ((m_Highlighted != highlighted) || (nil == self.image)) {
//		m_Highlighted = highlighted;
//		if (m_Highlighted) {
//			self.image = m_HighlightImage;
//		} else {
//			self.image = m_NormalImage;
//		}
//	}
//}
//
///*
//- (void)setImage:(UIImage *)anImage { 
//	[super setImage:anImage];
//	if (m_Bitmap != NULL) {
//		free(m_Bitmap);
//	}
//	m_Bitmap = [TimezoneView RequestImagePixelData:anImage];
//	m_Size = [anImage size];
//} 
//*/
///*
//#pragma mark Alpha hit testing
//// Return Image Pixel data as an ARGB bitmap 
//+ (void*)RequestImagePixelData:(UIImage*)inImage { 
//	CGImageRef img = [inImage CGImage]; 
//	CGSize size = [inImage size]; 
//	CGContextRef cgctx = [TimezoneView CreateARGBBitmapContext:img]; 
//	if (cgctx == NULL) return NULL; 
//	CGRect rect = {{0,0},{size.width, size.height}}; 
//	CGContextDrawImage(cgctx, rect, img); 
//	unsigned char *data = CGBitmapContextGetData (cgctx); 
//	CGContextRelease(cgctx); 
//	return data; 
//} 
//
//// Return a bitmap context using alpha/red/green/blue byte values 
//+ (CGContextRef)CreateARGBBitmapContext:(CGImageRef)inImage { 
//	CGContextRef    context = NULL;
//	CGColorSpaceRef colorSpace;
//	void *          bitmapData; 
//	int             bitmapByteCount; 
//	int             bitmapBytesPerRow; 
//	size_t pixelsWide = CGImageGetWidth(inImage); 
//	size_t pixelsHigh = CGImageGetHeight(inImage); 
//	bitmapBytesPerRow   = (pixelsWide * 4); 
//	bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh); 
//	colorSpace = CGColorSpaceCreateDeviceRGB(); 
//	if (colorSpace == NULL) { 
//		fprintf(stderr, "Error allocating color space\n"); 
//		return NULL; 
//	} 
//	// allocate the bitmap & create context 
//	bitmapData = malloc(bitmapByteCount); 
//	if (bitmapData == NULL) {
//		fprintf (stderr, "Memory not allocated!"); 
//		CGColorSpaceRelease( colorSpace ); 
//		return NULL; 
//	} 
//	
//	context = CGBitmapContextCreate (bitmapData, pixelsWide, pixelsHigh, 8, bitmapBytesPerRow, colorSpace, kCGImageAlphaPremultipliedFirst); 
//	if (context == NULL) { 
//		free (bitmapData); 
//		fprintf (stderr, "Context not created!"); 
//	} 
// 
//	CGColorSpaceRelease(colorSpace); 
//	return context;
//} 
//*/
//@end
