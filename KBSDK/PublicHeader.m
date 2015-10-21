//
//  PublicHeader.m
//  KBSDK
//
//  Created by DamonLiu on 15/8/12.
//  Copyright (c) 2015年 DamonLiu. All rights reserved.
//

#import "PublicHeader.h"
#import "Aspects.h"
#import <UIKit/UIKit.h>

@implementation PublicHeader

static NSString* fileName = @"KBInfo";

+(void)initSDK{
    //add the trace for View Controllers
    [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo,BOOL animated){
        [self log:[NSString stringWithFormat:@"KibBugInfo ViewController: %@",aspectInfo.instance]];
//        [self log:[NSString stringWithFormat:@"KibBugInfo Invocation: %@",[aspectInfo originalInvocation]]];
        [self log:[NSString stringWithFormat:@"KibBugInfo Arguments: %@",[aspectInfo arguments][0]]];
    }error:nil];
}

+(void)log:(NSString*)info{
    NSArray* documentPaths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask,YES);
    NSString* path = documentPaths[0];
//    NSString *sandboxPath = NSHomeDirectory();
//    NSString *documentPath = [sandboxPath stringByAppendingPathComponent:@"Documents"];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
//    [info writeToFile:filePath atomically:YES encoding:encoding:NSUTF8StringEncoding error:nil];
    [info writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    NSLog(info);
}



@end
