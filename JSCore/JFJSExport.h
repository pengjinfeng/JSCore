//
//  JFJSExport.h
//  JSCore
//
//  Created by 锦锋 on 17/2/7.
//  Copyright © 2017年 锦锋. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>
@interface JFJSExport : NSObject
@property(nonatomic,strong)UIWebView *web;
@property(nonatomic,strong)JSContext *context;
@end

