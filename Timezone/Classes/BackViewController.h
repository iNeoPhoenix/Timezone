//
//  BackViewController.h
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BackViewController : NSObject <UITableViewDataSource, UITableViewDelegate> {
	UIView*      m_View;
	
	UIImageView* m_PanelBackGround;
	
	// World maps
	UIImageView* m_FirstPart;
	UIImageView* m_SecondPart;
	
	// Table views
	UITableView* m_RootTableView;
	UITableView* m_MapTableView;
	UITableView* m_CityTableView;
	
	// Nasa legal
	UILabel*     m_LegalLabel;
	UIButton*    m_LegalUrlBtn;
}

@property (nonatomic, retain) UIView* view;

- (void)viewWillAppear;
- (void)onGetFullVersion;
- (void)city;
- (void)map;
- (void)goToLegalUrl:(id)iSender;
- (void)updateAnimated:(BOOL)animated;
- (void)displaySettings;

@end
