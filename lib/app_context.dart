import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:zendesk_messaging_flutter/zendesk_fields.dart';
import 'app_constants.dart';

class AppContext {

  ZendeskFields getInfoToZendesk() {
    String? versionCode;
    String? appBrandName;
    String? versionName;
    String? model;
    String? iDevice;

    PackageInfo.fromPlatform().then((value) {
      versionCode = value.buildNumber;
      appBrandName = value.appName;
      versionName = value.version;
    });

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if(Platform.isAndroid){
      deviceInfo.androidInfo.then((info) {
        model = info.model;
        iDevice = info.device;
      });
    }

    String? deviceType = iDevice;
    String? deviceOSVersion = Platform.operatingSystemVersion;
    String? appBrand = appBrandName;
    String? appVersionName = versionName;
    String? appVersionCode = versionCode;
    String? device = model;
    String? accountEmail = "";
    String? fullName = "";
    String? phoneNumber = "";
    String? country = "";
    String? currentSite = "";
    String? mealPlanName = "";

    return ZendeskFields(
        deviceType: deviceType != null ? deviceType : '',
        deviceOSVersion: deviceOSVersion != null ? deviceOSVersion : '',
        appBrand: appBrand != null ? appBrand : '',
        appVersionName: appVersionName != null ? appVersionName : '',
        appVersionCode: appVersionCode != null ? appVersionCode : '',
        device: device != null ? device : '',
        accountEmail: accountEmail != null ? accountEmail : '',
        fullName: fullName != null ? fullName : '',
        phoneNumber: phoneNumber != null ? phoneNumber : '',
        country: _getCountryCode(country),
        currentSite: currentSite != null ? currentSite : '',
        mealPlanName: mealPlanName != null ? mealPlanName : '',
    );
  }

  String _getCountryCode(String? country){
    switch(country){
      case AppConstants.CA:
        return AppConstants.CAN;
      case AppConstants.US:
        return AppConstants.USA;
      default:
        return '';
    }
  }

  ZendeskFields getFakeInfoToZendesk() {
    const String deviceType = "Pixel 6 Pro";
    const String deviceOSVersion = "14";
    const String appBrand = "Thrive";
    const String appVersionName = "7.9.4";
    const String appVersionCode = "329";
    const String device = "Pixel 6 Pro";
    const String accountEmail = "user@gmail.com";
    const String fullName = "Gilson Junior";
    const String phoneNumber = "999999999";
    const String country = "CA";
    const String currentSite = "Gilson Food Truck";
    const String mealPlanName = "";

    return ZendeskFields(
        deviceType: deviceType,
        deviceOSVersion: deviceOSVersion,
        appBrand: appBrand,
        appVersionName: appVersionName,
        appVersionCode: appVersionCode,
        device: device,
        accountEmail: accountEmail,
        fullName: fullName,
        phoneNumber: phoneNumber,
        country: _getCountryCode(country),
        currentSite: currentSite,
        mealPlanName: mealPlanName
    );
  }

  String getDeviceOs(){
    if(Platform.isAndroid){
      return 'Android';
    }else{
      return 'iOS';
    }
  }
}