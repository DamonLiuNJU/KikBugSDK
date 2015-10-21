//
//  UIViewController+KBAnalysis.m
//  KBSDK
//
//  Created by DamonLiu on 15/10/8.
//  Copyright © 2015年 DamonLiu. All rights reserved.
//

#import "UIViewController+KBAnalysis.h"
#import <objc/runtime.h>
@implementation UIViewController (KBAnalysis)




-(void)initSDK{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self swizzleSelector:@selector(viewDidLoad) withSelector:@selector(KB_viewDidLoad)];
        [self swizzleSelector:@selector(viewWillAppear:) withSelector:@selector(KB_viewWillAppear:)];
    });
}


-(void)swizzleSelector:(SEL )originalSelector withSelector:(SEL )swizzledSeclector
{
    Class cls = [self class];
    
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSeclector);
    
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod)
    {
        class_replaceMethod(cls, swizzledSeclector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}


-(void)KB_viewDidLoad{
    [self KB_viewDidLoad];
}

- (void)KB_viewDidAppear:(BOOL)animated{
    [self KB_viewDidAppear:animated];
}

- (void)KB_viewWillAppear:(BOOL)animated{
    [self KB_viewWillAppear:animated];
}



@end
