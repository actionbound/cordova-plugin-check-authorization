#import <Cordova/CDVPlugin.h>

@interface CDVCheckAuthorization : CDVPlugin

- (void) goToAppSettings:(CDVInvokedUrlCommand*)command;
- (void) checkCameraAuthorization:(CDVInvokedUrlCommand*)command;
- (void) checkGeolocationAuthorization:(CDVInvokedUrlCommand*)command;
- (void) checkSplitView:(CDVInvokedUrlCommand*)command;

@end