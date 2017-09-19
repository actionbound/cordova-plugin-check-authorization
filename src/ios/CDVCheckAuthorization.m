
#import "CDVCheckAuthorization.h"
#import <Cordova/CDV.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@implementation CDVCheckAuthorization

- (void) goToAppSettings:(CDVInvokedUrlCommand*)command {
  // Acces to settings app is only available in iOS8+
  if([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
  {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
  }
}

- (void) checkCameraAuthorization:(CDVInvokedUrlCommand*)command {
    __block CDVPluginResult* pluginResult = nil;
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (authStatus) {
          case AVAuthorizationStatusAuthorized:
              pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
              break;
          case AVAuthorizationStatusDenied:
          case AVAuthorizationStatusRestricted:
              pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:false];
              break;
          case AVAuthorizationStatusNotDetermined:
              [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                  if(granted){
                      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
                  } else {
                      pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:false];
                  }
              }];
              break;
        }
    }
    else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) checkGeolocationAuthorization:(CDVInvokedUrlCommand*)command {
    __block CDVPluginResult* pluginResult = nil;
    CLAuthorizationStatus authStatus = [CLLocationManager authorizationStatus];
    switch (authStatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:true];
            break;
        case kCLAuthorizationStatusDenied:
        case kCLAuthorizationStatusRestricted:
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:false];
            break;
        case kCLAuthorizationStatusNotDetermined:
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            break;
        default:
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            break;
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

- (void) checkSplitView:(CDVInvokedUrlCommand*)command; {
    __block CDVPluginResult* pluginResult = nil;
    if(CGRectEqualToRect([UIApplication sharedApplication].delegate.window.frame, [UIApplication sharedApplication].delegate.window.screen.bounds)) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:false];
    }
    else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsBool:false];
    }
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

#pragma mark - PRIVATE METHODS

@end