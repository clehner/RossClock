/*
 *     Generated by class-dump 3.3.3 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2010 by Steve Nygard.
 */

@class NSImage, NSMenu, NSMenuExtra;

@interface NSMenuExtraView : NSView
{
    NSMenu *_menu;
    NSMenuExtra *_menuExtra;
    NSImage *_image;
    NSImage *_alternateImage;
}

- (id)initWithFrame:(NSRect)arg1 menuExtra:(id)arg2;
- (void)dealloc;
- (void)setMenu:(id)arg1;
- (id)image;
- (void)setImage:(id)arg1;
- (id)alternateImage;
- (void)setAlternateImage:(id)arg1;
- (void)drawRect:(NSRect)arg1;
- (void)mouseDown:(id)arg1;

@end

