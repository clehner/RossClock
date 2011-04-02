//
//  RossClock.h
//  RossClock
//
//  Created by Charles Lehner on 2/12/11.
//  Copyright 2011 Charles Lehner. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "NSMenuExtra.h"
#import "NSMenuExtraView.h"
@class RossClockView;


@interface RossClock : NSMenuExtra {
	RossClockView *theView;
	NSMenu *theMenu;
	NSTimer *timer;
	//int[][] schedule;
	NSArray *periods;
	NSString* periodTitle;
	NSMenuItem* periodTitleMenuItem;
	int period;
}

- (NSString*)getClockText;
- (void)updateClock;
- (void)_updateTimer:(NSTimer*)timer;


@end
