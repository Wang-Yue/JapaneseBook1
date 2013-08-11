//
//  AppDelegate.m
//  JapaneseBook1
//
//  Created by Yue Wang on 8/10/13.
//  Copyright (c) 2013 Yue Wang. All rights reserved.
//

#import "AppDelegate.h"
#import "Book.h"
#import "Chapter.h"
#import "Section.h"
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate(){
    Book * book;
    AVAudioPlayer* audioPlayer;
    NSTimer * timer;
}
@end

@implementation AppDelegate

- (void) awakeFromNib{
    self.window.collectionBehavior = NSWindowCollectionBehaviorFullScreenPrimary;
    book = [Book sharedStore];
    [self setText:@""];
    [self setMp3:@""];
}

- (void) setText:(NSString *)text{
    [_textView setString:text];
}

- (void) setMp3:(NSString *)mp3{
    [_button setTitle:@"Play"];
    BOOL hasAudio = ![mp3 isEqualTo:@""];
    [_button setEnabled:hasAudio];
    [_slider setEnabled:hasAudio];
    [_slider setFloatValue:0.0f];
    if (hasAudio){
        NSURL* file = [NSURL URLWithString:mp3];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:file error:nil];
        [audioPlayer prepareToPlay];
        [_slider setMaxValue:[audioPlayer duration]];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(updateTime:)
                                               userInfo:nil
                                                repeats:YES];
        
    }else{
        [timer invalidate];
        timer = nil;
    }
}


- (IBAction)slide:(id)sender{
    [audioPlayer setCurrentTime:[_slider floatValue]];
}

- (void)updateTime:(NSTimer *)timer {
    [_slider setFloatValue:[audioPlayer currentTime]];
}



- (IBAction) play:(id)sender{
    if ([audioPlayer isPlaying]) {
        [audioPlayer pause];
        [_button setTitle:@"Play"];
    } else {
        [audioPlayer play];
        [_button setTitle:@"Pause"];
    }
    
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item{
    if (item == nil)
        return [[book chapters] count];
    if ([item isMemberOfClass:[Chapter class]])
        return [[(Chapter*)item sections] count];
    return 0;
}
- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item{
    if ([item isMemberOfClass:[Chapter class]])
        return YES;
    return NO;
}
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item{
    if (item == nil)
        return [[book chapters] objectAtIndex:index];
    if ([item isMemberOfClass:[Chapter class]])
        return [[(Chapter*)item sections] objectAtIndex:index];
    return nil;
}
- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    return [item title];
}
- (NSView *)outlineView:(NSOutlineView *)outlineView viewForTableColumn:(NSTableColumn *)tableColumn item:(id)item {
    NSTableCellView *result = nil;
    if ([item isMemberOfClass:[Chapter class]])
        result = [outlineView makeViewWithIdentifier:@"HeaderCell" owner:self];
    else
        result = [outlineView makeViewWithIdentifier:@"DataCell" owner:self];
    
    [[result textField] setStringValue: [item title]];
    return result;
}
- (BOOL)outlineView:(NSOutlineView *)outlineView shouldSelectItem:(id)item{
    if ([item isMemberOfClass:[Chapter class]]) return NO;
    return YES;
}

- (void)outlineViewSelectionDidChange:(NSNotification *)notification {
    NSOutlineView *  outlineView = [notification object];
    Section *section = [outlineView itemAtRow:[outlineView selectedRow]];
    [self setText:[section text]];
    [self setMp3:[section mp3]];
    [[notification object] reloadData];
}

@end