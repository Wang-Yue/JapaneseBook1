//
//  SharedStore.m
//  JapaneseBook1
//
//  Created by Yue Wang on 8/10/13.
//  Copyright (c) 2013 Yue Wang. All rights reserved.
//

#import "Book.h"
#import "Chapter.h"
@interface Book (){
    NSMutableArray * chapters;
}
@end



@implementation Book


- (id) init{
    self = [super init];
    if (self) {
        chapters = [NSMutableArray new];
        NSString * bookBundlePath =[[NSBundle mainBundle] pathForResource:@"Book" ofType:@"bundle"];
        NSBundle * bookBundle = [NSBundle bundleWithPath:bookBundlePath];
        NSURL * contentURL = [bookBundle URLForResource:@"content" withExtension:@"txt"];
        NSString * content = [NSString stringWithContentsOfURL:contentURL
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
        NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"(.*):(.*)"
                                                                                options:0
                                                                                  error:nil];
        NSArray * matches = [regex matchesInString:content options:0 range:NSMakeRange(0, [content length])];
        for (NSTextCheckingResult * match in matches){
            NSString * path = [bookBundlePath stringByAppendingPathComponent: [content substringWithRange:[match rangeAtIndex:1]]];
            NSString * title = [content substringWithRange:[match rangeAtIndex:2]];
            Chapter * chapter = [[Chapter alloc] initWithPath:path andTitle:title];
            [chapters addObject:chapter];
        }
    }
    return self;
}

+ (Book *) sharedStore{
    static Book * sharedStore = nil;
    if (!sharedStore) sharedStore = [[self alloc] init];
    return sharedStore;
}
- (NSArray *) chapters{
    return [NSArray arrayWithArray:chapters];
}

@end
