var exec = require('cordova/exec');

module.exports = {
  goToAppSettings: function(success, fail) {
    cordova.exec(success, fail, 'CheckAuthorization', 'goToAppSettings', ["", ""]);
  },

  checkCameraAuthorization: function(success, fail) {
    cordova.exec(success, fail, 'CheckAuthorization', 'checkCameraAuthorization', ["", ""]);
  },

  checkGeolocationAuthorization: function(gps_required, success, fail)  {
    cordova.exec(success, fail, 'CheckAuthorization', 'checkGeolocationAuthorization', [gps_required, ""]);
  },

  checkSplitView: function(success, fail) {
    cordova.exec(success, fail, 'CheckAuthorization', 'checkSplitView')
  }
}