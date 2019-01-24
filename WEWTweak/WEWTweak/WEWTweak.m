//
//  WEWTweak.m
//  WEWTweak
//
//  Created by Xinyu Zhao on 2018/11/23.
//  Copyright © 2018 Xinyu Zhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <Cocoa/Cocoa.h>
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


    [self.class swizzleClassMethod:objc_getClass("WEWOpenAPIBrowserWindowController") originSelector:NSSelectorFromString(@"openUrl:appId:source:delay:isForceUserSysBrowser:sourceMsg:") otherSelector:@selector(openUrl:appId:source:delay:isForceUserSysBrowser:sourceMsg:)];
}

+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector {
    Method originMehtod = class_getClassMethod(class, originSelector);
    Method otherMehtod = class_getClassMethod(self, otherSelector);
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)openUrl:(id)url
          appId:(unsigned long long)appId
         source:(int)source
          delay:(double)delay
isForceUserSysBrowser:(char)isForceUserSysBrowser
      sourceMsg:(id)sourceMsg {
    [[NSWorkspace sharedWorkspace] openURL:[NSURL URLWithString:url]];
}

- (NSString *)wew_executablePath {
    return @"/Applications/企业微信.app/Contents/MacOS/企业微信.bak";
}

- (BOOL)wew_isConversationSupportWaterMark {
    return NO;
}

@end
