//
//  WEWTweak.m
//  WEWTweak
//
//  Created by Xinyu Zhao on 2018/11/23.
//  Copyright © 2018 Xinyu Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <JRSwizzle/JRSwizzle.h>

@implementation NSObject (WEWTweak)

+ (void)load {
    [objc_getClass("WEWConversation")
     jr_swizzleMethod:NSSelectorFromString(@"isConversationSupportWaterMark")
     withMethod:@selector(wew_isConversationSupportWaterMark)
     error:nil];

    [NSBundle jr_swizzleMethod:@selector(executablePath)
                    withMethod:@selector(wew_executablePath)
                         error:nil];
}

- (NSString *)wew_executablePath {
    return @"/Applications/企业微信.app/Contents/MacOS/企业微信.bak";
}

- (BOOL)wew_isConversationSupportWaterMark {
    return NO;
}

@end
