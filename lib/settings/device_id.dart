import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';

abstract class DeviceId {
  static Future<String> getDeviceId(BuildContext context) async {
    try {
      String deviceId = '';
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      if (Theme.of(context).platform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceId = androidInfo.id;
      } else if (Theme.of(context).platform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceId = iosInfo.identifierForVendor ?? 'Unknown IOs device ID';
      }
      return deviceId;
    } catch (e) {
      return 'Unknown device ID';
    }
  }
}
