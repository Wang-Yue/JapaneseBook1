//
//  Section.m
//  JapaneseBook1
//
//  Created by Yue Wang on 8/10/13.
//  Copyright (c) 2013 Yue Wang. All rights reserved.
//

#import "Section.h"
@interface Section (){
    NSString * text;
    NSString * mp3;
    NSString * title;
}
@end

@implementation Section
- (Section *) initWithPath: (NSString *) path prefix: (NSString *) prefix andTitle: (NSString *) aTitle{
    NSString * textPath = [path stringByAppendingPathComponent:[prefix stringByAppendingPathExtension:@"text"]];
    if(![[NSFileManager defaultManager] fileExistsAtPath:textPath]) return nil;
    self =  [super init];
    if (self){
        title = aTitle;
        text = [NSString stringWithContentsOfFile:textPath encoding:NSUTF8StringEncoding error:nil];
        mp3 = [path stringByAppendingPathComponent:[prefix stringByAppendingPathExtension:@"mp3"]];
        if(![[NSFileManager defaultManager] fileExistsAtPath:mp3]) mp3 = @"";
    }
    return self;
}
- (NSString *) text{
    return text;
}
- (NSString *) mp3{
    return mp3;
}
- (NSString *) title{
    return title;
}
@end
