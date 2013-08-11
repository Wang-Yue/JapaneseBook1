//
//  AppDelegate.h
//  JapaneseBook1
//
//  Created by Yue Wang on 8/10/13.
//  Copyright (c) 2013 Yue Wang. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate, NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextView *textView;
@property (assign) IBOutlet NSButton *button;
@property (assign) IBOutlet NSSlider *slider;
- (IBAction) play:(id)sender;
- (IBAction) slide: (id)sender;
@end
