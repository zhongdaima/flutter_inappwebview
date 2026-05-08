//
//  WKWebView+SchemeHandle.m
//  yjtProject
//
//  Created by wbx on 2023/2/13.
//

#import "WKWebView+SchemeHandle.h"
#import <objc/runtime.h>

@implementation WKWebView (SchemeHandle)

+ (void)load {
    NSLog(@"WKWebView------SchemeHandle");
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method originalMethod = class_getClassMethod(self, @selector(handlesURLScheme:));
        Method swizzledMethod = class_getClassMethod(self, @selector(uxin_handlesURLScheme:));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

+ (BOOL)uxin_handlesURLScheme:(NSString *)urlScheme {
    if ([urlScheme isEqualToString:@"http"] ||
        [urlScheme isEqualToString:@"https"]) { // || [urlScheme isEqualToString:@"file"]
        return  NO;
    } else {
        return [self handlesURLScheme:urlScheme];
    }
}

@end
