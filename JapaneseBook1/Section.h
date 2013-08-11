//
//  Section.h
//  JapaneseBook1
//
//  Created by Yue Wang on 8/10/13.
//  Copyright (c) 2013 Yue Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Section : NSObject
- (Section *) initWithPath: (NSString *) path prefix: (NSString *) prefix andTitle: (NSString *) title;
- (NSString *) title;
- (NSString *) text;
- (NSString *) mp3;
@end
