class ZendeskFields {
  //Device Information
  String deviceType;
  String deviceOSVersion;
  String appBrand;
  String appVersionName;
  String appVersionCode;
  String device;
  // User Information
  String accountEmail;
  String fullName;
  String phoneNumber;
  String country;
  // App Information
  String currentSite;
  String mealPlanName;

  ZendeskFields({
    required this.deviceType,
    required this.deviceOSVersion,
    required this.appBrand,
    required this.appVersionName,
    required this.appVersionCode,
    required this.device,
    required this.accountEmail,
    required this.fullName,
    required this.phoneNumber,
    required this.country,
    required this.currentSite,
    required this.mealPlanName,
  });
}
