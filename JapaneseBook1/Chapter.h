//
//  Chapter.h
//  JapaneseBook1
//
//  Created by Yue Wang on 8/10/13.
//  Copyright (c) 2013 Yue Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chapter : NSObject
- (Chapter *) initWithPath:(NSString *) path andTitle: (NSString *) title;
- (NSArray *) sections;
- (NSString *) title;
@end
