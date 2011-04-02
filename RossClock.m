//
//  RossClock.m
//  RossClock
//
//  Created by Charles Lehner on 2/12/11.
//  Copyright 2011 Charles Lehner. All rights reserved.
//

#import "RossClock.h"
#import "RossClockView.h"

@implementation RossClock

- (id)initWithBundle:(NSBundle *)bundle
{
    self = [super initWithBundle:bundle];
    if(self == nil)
        return nil;
	
    // we will create and set the MenuExtraView
    theView = [[RossClockView alloc] initWithFrame:
			   [[self view] frame] menuExtra:self];
    [self setView:theView];
	
	// init menu stuff
	theMenu = [[NSMenu alloc] initWithTitle: @""];
    
	//[theMenu addItem:[NSMenuItem separatorItem]];
	//[theMenu setAutoenablesItems: NO];
	
	periodTitleMenuItem = [theMenu addItemWithTitle: @"Ross Clock"
														 action: nil
												  keyEquivalent: @""];
	[periodTitleMenuItem setEnabled:false];
	periodTitle = @"";
	
	[self setMenu:theMenu];
	[self setHighlightMode:YES];

	periods = [[NSArray arrayWithObjects:
				[NSArray arrayWithObjects:[NSNumber numberWithInt:27000], [NSNumber numberWithInt:29100], @"Breakfast",  nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:29400], [NSNumber numberWithInt:32100], @"1st Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:32400], [NSNumber numberWithInt:35100], @"2nd Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:35400], [NSNumber numberWithInt:38100], @"3rd Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:38400], [NSNumber numberWithInt:41100], @"4th Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:41400], [NSNumber numberWithInt:44100], @"5th Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:44400], [NSNumber numberWithInt:47100], @"6th Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:47400], [NSNumber numberWithInt:50100], @"7th Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:50400], [NSNumber numberWithInt:53100], @"8th Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:53400], [NSNumber numberWithInt:56100], @"9th Period", nil],
				[NSArray arrayWithObjects:[NSNumber numberWithInt:56400], [NSNumber numberWithInt:59100], @"10th Period", nil],
				nil] retain];
	
	[self updateClock];
	
	timer = [[NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)1
											  target:self
											selector:@selector(_updateTimer:)
											userInfo:nil repeats:YES] retain];
    return self;
}

- (void)dealloc
{
    [theView release];
    [theMenu release];
	[timer release];
	[periods release];
    [super dealloc];
}

- (NSString*)getClockText
{
	NSDate *now = [[NSDate alloc] init];
	NSCalendar *gregorian = [[NSCalendar alloc]
							 initWithCalendarIdentifier:NSGregorianCalendar];
	[gregorian setTimeZone:[NSTimeZone timeZoneWithName:@"America/New_York"]];
	NSDateComponents *comps =
		[gregorian components:(NSHourCalendarUnit | NSMinuteCalendarUnit |
							   NSSecondCalendarUnit) fromDate:now];
	[now release];
	[gregorian release];
	int seconds = ([comps hour] * 60 + [comps minute]) * 60 + [comps second];
	
	//return [NSString stringWithFormat:@"%d:%02d:%02d", [comps hour], [comps minute], [comps second]];
	
	// figure out what period we are in
	int numPeriods = [periods count];
	
	int p = period;
	int i = 0;
	int periodEnd = [[[periods objectAtIndex:p] objectAtIndex:1] intValue];
	while (seconds > periodEnd) {
		if (i++ > 100) return @"!!";
		p++;
		if (p >= numPeriods) {
			periodTitle = @"After school";
			return @".";
		}
		periodEnd = [[[periods objectAtIndex:p] objectAtIndex:1] intValue];
	}
	
	int periodStart = [[[periods objectAtIndex:p] objectAtIndex:0] intValue];
	while (seconds < periodStart) {
		if (i++ > 100) return @"!";
		int prevPeriodEnd;
		if (p == 0) {
			// no previous period. use 10 minute lead.
			prevPeriodEnd = periodStart - 60 * 10;
		} else {
			prevPeriodEnd = [[[periods objectAtIndex:(p - 1)] objectAtIndex:1] intValue];
		}
		if (seconds < prevPeriodEnd) {
			p--;
			if (p < 0) {
				periodTitle = @"Before school";
				return @".";
			}
			periodStart = [[[periods objectAtIndex:p] objectAtIndex:0] intValue];
		} else {
			break;
		}
	}
	
	period = p;
	
	int periodSeconds;
	if (seconds < periodStart) {
		// time since beginning of period (negative)
		periodSeconds = seconds - periodStart;
	} else {
		int periodEnd = [[[periods objectAtIndex:p] objectAtIndex:1] intValue];
		// seconds until end of period
		periodSeconds = periodEnd - seconds;
	}
	
	int secs = abs(periodSeconds % 60);
	int mins = abs(periodSeconds / 60);
	BOOL isNegative = periodSeconds < 0;
	NSString *str = [NSString stringWithFormat:@"%s%d:%02d", isNegative ? "-" : "", mins, secs];
	
	//[periodTitle release];
	periodTitle = [[periods objectAtIndex:p] objectAtIndex:2];
	
	return str;
}

- (void)updateClock
{
	[theView setClockString:[self getClockText]];
	[periodTitleMenuItem setTitle:periodTitle];
}

- (void)_updateTimer:(NSTimer*)timer
{
	[self updateClock];
}

@end
