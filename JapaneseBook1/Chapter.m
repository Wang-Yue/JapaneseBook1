//
//  Chapter.m
//  JapaneseBook1
//
//  Created by Yue Wang on 8/10/13.
//  Copyright (c) 2013 Yue Wang. All rights reserved.
//

#import "Chapter.h"
#import "Section.h"
@interface Chapter () {
    NSMutableArray * sections;
    NSString * title;
}
@end


@implementation Chapter

- (Chapter *) initWithPath:(NSString *) path andTitle: (NSString *) aTitle{
    self = [super init];
    if (self){
        sections = [NSMutableArray new];
        title = aTitle;

        NSArray * prefixes = @[@"pron1", @"pron2", @"pron3", @"pron4",
                             @"grammar",
                             @"word1", @"prologue",
                             @"word2", @"conversation",
                             @"word3", @"reading",
                             @"exercise" ];
        NSArray * titles = @[@"語音（一）", @"語音（二）", @"語音（三）", @"語音（四）",
                             @"語法",
                             @"單詞", @"前文",
                             @"單詞（續）", @"對話",
                             @"讀解文單詞", @"讀解文",
                             @"練習"];
        for (int i = 0; i < [prefixes count]; i ++){
            Section * section = [[Section alloc] initWithPath:path
                                                       prefix:[prefixes objectAtIndex:i]
                                                     andTitle:[titles objectAtIndex:i]];
            if (section) [sections addObject:section];
        }
    }
    return self;
}
- (NSArray *) sections{
    return [NSArray arrayWithArray: sections];
}
- (NSString *) title{
    return title;
}
@end
