//
//  RootViewController.h
//  Timezone
//
//  Created by Stéphane Chrétien on 28/04/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FrontViewController, BackViewController;

@interface RootViewController : NSObject {
	UIView*				 m_View;
	UIButton*			 m_InfoButton;
	FrontViewController* m_FrontViewController;
	BackViewController*  m_BackViewController;
	BOOL				 m_IsFront;
}

@property (nonatomic, retain) UIView* view;
@property (nonatomic, retain) UIButton* infoButton;
@property (nonatomic, retain) FrontViewController* frontViewController;
@property (nonatomic, retain) BackViewController* backViewController;

- (id)initWithDST:(BOOL)isDSTAvailable;
- (void)toggleViews;
- (void)applicationDidBecomeActive;

@end
