//
//  JFJSExport.m
//  JSCore
//
//  Created by 锦锋 on 17/2/7.
//  Copyright © 2017年 锦锋. All rights reserved.
//

#import "JFJSExport.h"

@protocol JFObjectJSExportDelegate <JSExport>
- (void)wxPay:(NSString *)number;
- (void )callBack:(NSString *)callBack;

- (void)ocAllocatejsCallBack:(NSString *)callBack;
@end
@interface JFJSExport ()<JFObjectJSExportDelegate,UIAlertViewDelegate>

@end
@implementation JFJSExport
- (void)wxPay:(NSString *)number{
    NSLog(@"js调用oc的订单号：%@",number);
    NSString *orderNo = [NSString stringWithFormat:@"js调用oc的订单号：%@",number];
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"温馨提示" message:orderNo delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
}
- (void )callBack:(NSString *)callBack{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"温馨提示" message:callBack delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    [alert show];

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 10) return;
    NSArray *dataArr = nil;
    NSString *option = @"否";
    if (buttonIndex == 0) {
        option = @"是";
    }else{
        option = @"否";
    }
    dataArr = @[option];
    JSValue *value = self.context[@"callBack"];
    [value callWithArguments:dataArr];
}


- (void)ocAllocatejsCallBack:(NSString *)callBack{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"温馨提示" message:callBack delegate:self cancelButtonTitle:@"是" otherButtonTitles:@"否", nil];
    alert.tag = 10;
    [alert show];
}
@end
