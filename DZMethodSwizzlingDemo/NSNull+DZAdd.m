//
//  NSNull+DZAdd.m
//  DZMethodSwizzlingDemo
//
//  Created by Wenbing Zuo on 4/17/17.
//  Copyright © 2017 Wenbing Zuo. All rights reserved.
//

#import "NSNull+DZAdd.h"
#import <objc/runtime.h>

#define DZNullObjects @[@0, @"", @[], @{}]

@implementation NSNull (DZAdd)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        Class class = [self class];
        
        SEL originalSelectors[] = {
            @selector(methodSignatureForSelector:),
            @selector(forwardInvocation:)
        };
        
        for (NSUInteger index = 0; index < sizeof(originalSelectors)/sizeof(SEL); index++) {
            SEL originalSelector = originalSelectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"__dz_DZAdd_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            
            Method originalMethod = class_getInstanceMethod(class, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
            
            BOOL success  = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
            if (success) {
                class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod);
            }
        }
        
    });
}

- (NSMethodSignature *)__dz_DZAdd_methodSignatureForSelector:(SEL)aSelector {
    for (id obj in DZNullObjects) {
        NSMethodSignature *signature = [obj methodSignatureForSelector:aSelector];
        if (signature) return signature;
    }
    
    return [self __dz_DZAdd_methodSignatureForSelector:aSelector];
}

- (void)__dz_DZAdd_forwardInvocation:(NSInvocation *)anInvocation {
    for (id obj in DZNullObjects) {
        if ([obj respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:obj];
            return;
        }
    }
    [self __dz_DZAdd_forwardInvocation:anInvocation];
}

@end
