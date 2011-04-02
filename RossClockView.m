//
//  RossClockView.m
//  RossClock
//
//  Created by Charles Lehner on 2/12/11.
//  Copyright 2011 Charles Lehner. All rights reserved.
//

#import "RossClockView.h"


@implementation RossClockView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self == nil) {
        return nil;
    }
	
	clockString = @"";
	
    return self;
}

- (void)drawRect:(NSRect)rect {
	NSColor *textColor;
	if([_menuExtra isMenuDown]) {
		textColor = [NSColor selectedMenuItemTextColor];
		[_menuExtra drawMenuBackground:YES];
	} else {
		//[NSColor blackColor];
		textColor = [NSColor colorWithCalibratedWhite:0.1 alpha:1.0];
	}
	
	NSMutableDictionary *drawStringAttributes = [[NSMutableDictionary alloc] init];
	[drawStringAttributes setValue:textColor forKey:NSForegroundColorAttributeName];
	[drawStringAttributes setValue:[NSFont fontWithName:@"Lucida Grande" size:14] forKey:NSFontAttributeName];
	
	/*NSShadow *stringShadow = [[NSShadow alloc] init];
	[stringShadow setShadowColor:[NSColor colorWithDeviceWhite:1 alpha:0.3]];
	NSSize shadowOffset;
	shadowOffset.width = 0;
	shadowOffset.height = -1;
	[stringShadow setShadowOffset:shadowOffset];
	[stringShadow setShadowBlurRadius:1];
	[drawStringAttributes setValue:stringShadow forKey:NSShadowAttributeName];	
	[stringShadow release];*/
	
	NSSize stringSize = [clockString sizeWithAttributes:drawStringAttributes];
	[self setFrameSize:NSMakeSize(stringSize.width, [self frame].size.height)];
	[_menuExtra setLength:(double) stringSize.width];
	NSPoint centerPoint;
	centerPoint.x = 0; //(rect.size.width / 2) - (stringSize.width / 2);
	centerPoint.y = 3; //rect.size.height / 2 - (stringSize.height / 2);
	[clockString drawAtPoint:centerPoint withAttributes:drawStringAttributes];
	[drawStringAttributes release];
}

- (void)setClockString:(NSString*)str {
	[clockString release];
	clockString = [str copy];	
	[self setNeedsDisplay:YES];
}
@end
