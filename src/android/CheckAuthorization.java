package de.actionbound.plugins;

import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

import org.json.JSONArray;
import org.json.JSONException;

import android.content.Context;
import android.content.Intent;
import android.location.LocationManager;
import android.provider.Settings;

/**
 * This class echoes a string called from JavaScript.
 */
public class CheckAuthorization extends CordovaPlugin {
  @Override
  public boolean execute(String action, JSONArray args, CallbackContext callbackContext) throws JSONException {
    Context context=this.cordova.getActivity().getApplicationContext();
    
  if(action.equals("checkCameraAuthorization")) {
    // there is no such android authorization / activation yet
    callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
    return true;
  }
  
  if(action.equals("goToAppSettings")) {
     
    Intent intent = new Intent(Settings.ACTION_LOCATION_SOURCE_SETTINGS);
    intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
    context.startActivity(intent);
    callbackContext.success();
    return true;
  }
  
  if(action.equals("checkGeolocationAuthorization")) {
    LocationManager manager = (LocationManager) context.getSystemService(Context.LOCATION_SERVICE);
    boolean gps_needed = false;
    
    if(args.length() > 0) {
      // first arg determines if network provider is enough or gps is needed
      if(args.getBoolean(0) == true) {
        gps_needed = true;
      }
    }
    
    if (gps_needed) {
      if (manager.isProviderEnabled(LocationManager.GPS_PROVIDER)) {
        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
      }
      else {
        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
      }     
    }
    else {
      if ( manager.isProviderEnabled(LocationManager.GPS_PROVIDER) ||
         manager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)) {
        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, true));
      }
      else {
        callbackContext.sendPluginResult(new PluginResult(PluginResult.Status.OK, false));
      }     
    }
    return true;
  }
  
    return false;
  }
}
