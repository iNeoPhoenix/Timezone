//
//  BackViewController.m
//  Timezone
//
//  Created by Stéphane Chrétien on 01/05/09.
//  Copyright 2009 NeoPhoenix. All rights reserved.
//

#import "BackViewController.h"

#import "TimezoneAppDelegate.h"
#import "City.h"
#import "CityManager.h"
#import "Map.h"
#import "MapManager.h"


@implementation BackViewController

@synthesize view = m_View;

- (id)init {
	if (self = [super init]) {
		m_View = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
				
		// Maps
		m_FirstPart = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)];
		[m_View addSubview:m_FirstPart];
		m_SecondPart = [[UIImageView alloc] initWithFrame:CGRectMake(480, 0, 480, 320)];
		[m_View addSubview:m_SecondPart];
		
		// Mirror of the maps
		CGAffineTransform transform =  CGAffineTransformMakeScale(1., -1.);
		m_FirstPart.transform = transform;
		m_SecondPart.transform = transform;
		
		// Background panel
		m_PanelBackGround = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 480, 300)];
		m_PanelBackGround.image = [UIImage imageNamed:@"VersoBack.png"];
		[m_View addSubview:m_PanelBackGround];
		
		// Legal therms
		m_LegalLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 220, 360, 40)];
		m_LegalLabel.text = NSLocalizedString(@"Legal", nil);
		m_LegalLabel.backgroundColor = [UIColor clearColor];
		m_LegalLabel.shadowColor = [UIColor grayColor];
		m_LegalLabel.shadowOffset = CGSizeMake(0, 1);
		m_LegalLabel.hidden = YES;
		[m_View addSubview:m_LegalLabel];
		
		// URL buttons
		m_LegalUrlBtn = [[UIButton buttonWithType:UIButtonTypeCustom]retain];
		[m_LegalUrlBtn setTitle:@"http://visibleearth.nasa.gov/" forState:UIControlStateNormal];
		[m_LegalUrlBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		m_LegalUrlBtn.frame = CGRectMake(60, 247, 220, 40);
		[m_LegalUrlBtn addTarget:self action:@selector(goToLegalUrl:) forControlEvents:UIControlEventTouchDown];
		m_LegalUrlBtn.hidden = YES;
		[m_View addSubview:m_LegalUrlBtn];
		
		// Root table view
		m_RootTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 40, 380, 200) style:UITableViewStyleGrouped];
		m_RootTableView.dataSource = self;
		m_RootTableView.delegate = self;
		m_RootTableView.scrollEnabled = NO;
		m_RootTableView.backgroundColor = [UIColor clearColor];
		[m_View addSubview:m_RootTableView];
		
		// City table view
		m_CityTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 40, 380, 260) style:UITableViewStyleGrouped];
		m_CityTableView.dataSource = self;
		m_CityTableView.delegate = self;
		m_CityTableView.backgroundColor = [UIColor clearColor];
		m_CityTableView.hidden = YES;
		[m_View addSubview:m_CityTableView];
		
		// Map table view
		m_MapTableView = [[UITableView alloc] initWithFrame:CGRectMake(50, 40, 380, 260) style:UITableViewStyleGrouped];
		m_MapTableView.dataSource = self;
		m_MapTableView.delegate = self;
		m_MapTableView.backgroundColor = [UIColor clearColor];
		m_MapTableView.hidden = YES;
		[m_View addSubview:m_MapTableView];
		
		// Settings button
		UIButton* settingsButton = [UIButton buttonWithType:UIButtonTypeCustom];
		settingsButton.frame = CGRectMake(18, 268, 32, 32);
		settingsButton.backgroundColor = [UIColor clearColor];
		[settingsButton setImage:[UIImage imageNamed:@"SettingsIcon.png"] forState:UIControlStateNormal];
		[settingsButton setImage:[UIImage imageNamed:@"SettingsIconHighlighted.png"] forState:UIControlStateHighlighted];
		[settingsButton addTarget:self action:@selector(displaySettings) forControlEvents:UIControlEventTouchUpInside];
		[m_View addSubview:settingsButton];
		
		[self updateAnimated:NO];
	}

	return self;
}

- (void)dealloc {
	[m_LegalLabel		release];
	[m_LegalUrlBtn		release];
	[m_RootTableView	release];
	[m_MapTableView		release];
	[m_CityTableView	release];
	[m_FirstPart		release];
	[m_SecondPart		release];
	[m_PanelBackGround  release];
	[m_View				release];
	
    [super dealloc];
}

#pragma mark UIViewController methods
- (void)viewWillAppear {
	m_RootTableView.hidden = NO;
	m_MapTableView.hidden  = YES;
	m_CityTableView.hidden = YES;
	[self updateAnimated:NO];
}

#pragma mark Specific methods
- (void)onGetFullVersion {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=311822529&mt=8"]];
}
		
// Enter map selection
- (void)map {
	m_RootTableView.hidden = YES;
	m_MapTableView.hidden  = NO;
	
	m_LegalLabel.hidden    = YES;
	m_LegalUrlBtn.hidden   = YES;
}

// Enter city selection
- (void)city {
	m_RootTableView.hidden = YES;
	m_CityTableView.hidden = NO;
	
	m_LegalLabel.hidden    = YES;
	m_LegalUrlBtn.hidden   = YES;
}

// Close the appli and open the NASA URL
- (void)goToLegalUrl:(id)iSender {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://visibleearth.nasa.gov/"]];
}

// Update the maps after selection
- (void)updateAnimated:(BOOL)animated {
	// 1. Update map
	MapManager*  mapManager = [TimezoneAppDelegate instance].mapManager;
	Map* currentMap = [mapManager currentMap];
	BOOL displayLegal = currentMap.isLegal;
	m_LegalLabel.hidden  = !displayLegal;
	m_LegalUrlBtn.hidden = !displayLegal;
	
	UIImage* fileName = [UIImage imageNamed:currentMap.mapFileName];
	m_FirstPart.image = fileName;
	m_SecondPart.image = fileName;
	
	if (animated) {
		[[UIApplication sharedApplication] beginIgnoringInteractionEvents];
		
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.5];
		[UIView setAnimationDelegate:self];
	}
	// 2. Update city
	CityManager* cityManager = [TimezoneAppDelegate instance].cityManager;
	City* currentCity = [cityManager currentCity];
	
	NSInteger delta;
	if (currentCity.offset > 240.) {
		delta = currentCity.offset - 240.;
	} else {
		delta = currentCity.offset + 240.;
	}
	m_FirstPart.frame  = CGRectMake(-delta, 0, 480, 320);
	m_SecondPart.frame = CGRectMake(480 - delta, 0, 480, 320);
	
	if (animated) {
		[UIView commitAnimations];
	}
		
	// Update table
	[m_MapTableView  reloadData];
	[m_CityTableView reloadData];
	[m_RootTableView reloadData];
}

- (void)animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
	[[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)displaySettings {
	// display the welcome / settings detection panel
	NSTimeZone* localTimezone = [NSTimeZone localTimeZone];//systemTimeZone 
	NSDate* date = [NSDate date];
	NSCalendar* calendar = [NSCalendar currentCalendar];
	NSDateComponents* components = [calendar components:kCFCalendarUnitHour fromDate:date];
	NSInteger hour = components.hour;
	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults boolForKey:@"clockSystem"]) {
		if (hour >= 12) {
			hour -= 12;
		}
	}
	components = [calendar components:kCFCalendarUnitMinute fromDate:date];
	NSInteger minute = components.minute;
	
	NSString* hourString = @"";
	if (hour < 10) {
		hourString = [hourString stringByAppendingString:@"0"];
	}
	hourString = [hourString stringByAppendingString:[NSString stringWithFormat:@"%d", hour]];
	
	NSString* minString = @"";
	if (minute < 10) {
		minString = [minString stringByAppendingString:@"0"];
	}
	minString = [minString stringByAppendingString:[NSString stringWithFormat:@"%d", minute]];
	
	UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DetectionPanelTitleSetting", nil)
													message:[NSString stringWithFormat:NSLocalizedString(@"DetectionPanelMessage", nil), localTimezone.name, hourString, minString]
												   delegate:nil 
										  cancelButtonTitle:@"Ok" 
										  otherButtonTitles:nil];
	
	[alert show];
	[alert release];		
}

#pragma mark UITableViewDataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	NSInteger numberOfSections;
	if (m_RootTableView == tableView) {
		numberOfSections = 2;
	} else if (m_MapTableView == tableView) {
		numberOfSections = 1;
	} else if (m_CityTableView == tableView) {
		numberOfSections = 1;
	}
    return numberOfSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	NSString* title = @"";
	if (m_RootTableView == tableView) {
		switch (section) {
			case 0:
				title = NSLocalizedString(@"CenterOn", nil);
				break;
			case 1:
				title = NSLocalizedString(@"Map", nil);
				break;
			default :
				title = @"";
		}
	} else if (m_MapTableView == tableView) {
		title = @"Map";
	} else if (m_CityTableView == tableView) {
		title = @"CenterOn";
	}
	return title;
}

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section {
	NSInteger rowsInSection = 0;
	if (m_RootTableView == table) {
		rowsInSection = 1;
	} else if (m_CityTableView == table) {
		CityManager* cityManager= [TimezoneAppDelegate instance].cityManager;
		rowsInSection = cityManager.cityList.count;
	} else if (m_MapTableView == table) {
		MapManager*  mapManager = [TimezoneAppDelegate instance].mapManager;
		rowsInSection = mapManager.mapList.count;
	}
	return rowsInSection;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
    }
	
    CityManager* cityManager= [TimezoneAppDelegate instance].cityManager;
	City* currentCity = [cityManager currentCity];
	
	MapManager*  mapManager = [TimezoneAppDelegate instance].mapManager;
	Map* currentMap = [mapManager currentMap];
	
	NSInteger section = indexPath.section;
	NSInteger row = indexPath.row;
	
	NSString* string = @"";
	
	if (m_RootTableView == tableView) {
		switch (section) {
			case 0:
				string = currentCity.name;
				break;
			case 1:
				string = currentMap.name;
				break;
			default :
				string = @"";
		}
	} else if (m_MapTableView == tableView) {
		if (row == [mapManager currentMapIndex]) {
			cell.imageView.image = [UIImage imageNamed:@"tick.png"];
		} else {
			cell.imageView.image = [UIImage imageNamed:@"tickempty.png"];
		}
		Map* map = [mapManager.mapList objectAtIndex:row];
		string = map.name;
	} else if (m_CityTableView == tableView) {
		if (row == [cityManager currentCityIndex]) {
			cell.imageView.image = [UIImage imageNamed:@"tick.png"];
		} else {
			cell.imageView.image = [UIImage imageNamed:@"tickempty.png"];
		}
		City* city = [cityManager.cityList objectAtIndex:row];
		string = city.name;
	}
	
	cell.textLabel.text = string;

    return cell;
}

#pragma mark UITableViewDelegate methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:NO]; 

	NSInteger section = indexPath.section;
	NSInteger row = indexPath.row;
	
	if (m_RootTableView == tableView) {
		switch (section) {
			case 0:
				[self city];
				break;
			case 1:
				[self map];
				break;
		}
	} else if (m_MapTableView == tableView) {
		m_MapTableView.hidden = YES;
		m_RootTableView.hidden = NO;
		MapManager* mapManager= [TimezoneAppDelegate instance].mapManager;
		mapManager.currentMapIndex = row;
		[self updateAnimated:YES];
	} else if (m_CityTableView == tableView) {
		m_CityTableView.hidden = YES;
		m_RootTableView.hidden = NO;
		CityManager* cityManager= [TimezoneAppDelegate instance].cityManager;
		cityManager.currentCityIndex = row;
		[self updateAnimated:YES];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UILabel* hdr = [[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 380, 40)] autorelease];
	hdr.textAlignment = UITextAlignmentLeft;
	hdr.font = [UIFont systemFontOfSize:18.0];
	hdr.opaque = YES ;
	hdr.textColor = [UIColor blackColor];
	hdr.shadowColor = [UIColor lightGrayColor];
	hdr.shadowOffset = CGSizeMake(0, 1);
	hdr.backgroundColor = [UIColor clearColor];

	
	NSString* title = @"";
	if (m_RootTableView == tableView) {
		switch (section) {
			case 0:
				title = [@"    " stringByAppendingString:NSLocalizedString(@"CenterOn", nil)];
				break;
			case 1:
				title = [@"    " stringByAppendingString:NSLocalizedString(@"Map", nil)];
				break;
			default :
				title = @"";
		}
	} else if (m_MapTableView == tableView) {
		title = [@"    " stringByAppendingString:NSLocalizedString(@"Map", nil)];
	} else if (m_CityTableView == tableView) {
		title = [@"    " stringByAppendingString:NSLocalizedString(@"CenterOn", nil)];
	}
	
	hdr.text = title;
	
	return hdr ;
}

@end
