#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import <Flutter/Flutter.h>
#import "NativeVC.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  
    FlutterViewController *flutterVC = (FlutterViewController *)self.window.rootViewController;
    static NSString *channelName = @"FlutterChannel";
    static NSString *methodsName = @"iOSFlutter";
    //注册channel通道，需要和dart保持一致
    FlutterMethodChannel *methodChannel = [FlutterMethodChannel methodChannelWithName:channelName
                                                                      binaryMessenger:flutterVC];
//    __weak typeof(self) weakSelf = self;
    //设置接收到dart相关调用的回调方法
    [methodChannel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        NSLog(@"%@", [NSString stringWithFormat:@"methodName: %@",call.method]);
        if ([methodsName isEqualToString:call.method]) {
            NSLog(@"%@", [NSString stringWithFormat:@"methodArguments: %@",call.arguments]);
            NativeVC *nativeVC = [[NativeVC alloc] init];
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:nativeVC];
            [flutterVC presentViewController: navi
                                    animated:YES
                                  completion:^{
                                      //回调回给dart
                                      result(@"跳转成功--iOS回调");
                                  }];
        } else {
            //回调回给dart
            result(@"methodsName not found");
        }
        
    }];
    
    
    
    
    
    
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
