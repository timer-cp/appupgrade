#import "AppupgradePlugin.h"

@implementation AppupgradePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"appupgrade"
            binaryMessenger:[registrar messenger]];
  AppupgradePlugin* instance = [[AppupgradePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getAppInfo" isEqualToString:call.method]) {
      NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
      NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
      NSString *bundleIdentifier = [infoDictionary objectForKey:@"CFBundleIdentifier"];
      NSMutableDictionary *map = [NSMutableDictionary dictionary];
      [map setObject:majorVersion forKey:@"versionName"];
      [map setObject:bundleIdentifier forKey:@"packageName"];
      [map setObject:@"0" forKey:@"versionCode"];
      result(map);
  } else if ([@"toAppStore" isEqualToString:call.method]){
      NSDictionary *args = call.arguments;
      NSString *urlString = [[NSString alloc] initWithFormat:@"itms-apps://itunes.apple.com/app/%@?mt=8", args[@"id"]];
      NSURL *url = [NSURL URLWithString:urlString];
      if (@available(iOS 10.0, *)){
          [[UIApplication sharedApplication]openURL:url options:@{UIApplicationOpenURLOptionsSourceApplicationKey:@YES} completionHandler:^(BOOL success) {
              if (success) {
                  NSLog(@"10以后可以跳转url");
              }else{
                  NSLog(@"10以后不可以跳转url");
              }
          }];
      }else{
          BOOL success = [[UIApplication sharedApplication]openURL:url];
          if (success) {
              NSLog(@"10以前可以跳转url");
          }else{
              NSLog(@"10以前不可以跳转url");
          }
      }
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
