//
//  UIButton+Tracking.m
//  DZMethodSwizzlingDemo
//
//  Created by Wenbing Zuo on 4/16/17.
//  Copyright © 2017 Wenbing Zuo. All rights reserved.
//

#import "UIButton+Tracking.h"
#import <objc/runtime.h>

@implementation UIButton (Tracking)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelector = @selector(sendAction:to:forEvent:);
        SEL swizzledSelector = @selector(__dz_tracking_sendAction:to:forEvent:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL success =  class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
    });
}

- (void)__dz_tracking_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self __dz_tracking_sendAction:action to:target forEvent:event];
    
    NSLog(@"Method Swizzling: %@", NSStringFromSelector(_cmd));
    NSLog(@"Method Swizzling: %s", __FUNCTION__);
}

@end
