//
//  NativeVC.m
//  Runner
//
//  Created by 朱志清 on 2018/12/21.
//  Copyright © 2018 The Chromium Authors. All rights reserved.
//

#import "NativeVC.h"
#import <Flutter/Flutter.h>


@interface NativeVC ()<FlutterStreamHandler>{
    FlutterEventSink _eventSink;
}

@end

@implementation NativeVC

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.view.backgroundColor = [UIColor greenColor];
    FlutterEventChannel* chargingChannel = [FlutterEventChannel
                                            eventChannelWithName:@"iOSEventChannel"
                                            binaryMessenger:self];
    [chargingChannel setStreamHandler:self];
    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
//    [self dismissViewControllerAnimated:YES completion:nil];
    //向flutter发请求
    _eventSink(@"iOS发请求了");
}


- (FlutterError * _Nullable)onCancelWithArguments:(id _Nullable)arguments {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    return nil;
}

- (FlutterError * _Nullable)onListenWithArguments:(id _Nullable)arguments eventSink:(nonnull FlutterEventSink)events {
    _eventSink = events;
    

    return nil;
}

@end
