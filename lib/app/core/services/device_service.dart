import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class DeviceService extends GetxService {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  String deviceName = 'Unknown Device';
  String deviceType = 'unknown';
  String deviceId = 'unknown-id';

  Future<DeviceService> init() async {
    debugPrint('Initializing DeviceService...');
    await refreshDeviceInfo();
    return this;
  }

  Future<void> refreshDeviceInfo({bool forceRefresh = false}) async {
    try {
      if (kIsWeb) {
        final webInfo = await _deviceInfo.webBrowserInfo;
        deviceName = '${webInfo.browserName.name} (${webInfo.platform})';
        deviceType = 'web';
        deviceId = webInfo.userAgent ?? 'web-id';
      } else if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        deviceName = '${androidInfo.brand} ${androidInfo.model}';
        deviceType = 'android';
        deviceId = androidInfo.id;
      } else if (Platform.isIOS) {
        final iosInfo = await _deviceInfo.iosInfo;
        deviceName = iosInfo.name;
        deviceType = 'ios';
        deviceId = iosInfo.identifierForVendor ?? 'ios-id';
      } else if (Platform.isWindows) {
        final winInfo = await _deviceInfo.windowsInfo;
        deviceName = winInfo.computerName;
        deviceType = 'windows';
        deviceId = winInfo.deviceId;
      }
    } catch (e) {
      debugPrint('DeviceService Plugin Error: $e');
      await _loadFallbackInfo();
    }
    
    // Final check: if deviceId is still default/unknown, use persistent UUID
    if (deviceId == 'unknown-id' || deviceId.isEmpty) {
      deviceId = await _getPersistentId();
    }

    debugPrint('Final Device Info: $deviceName, $deviceType, $deviceId');
  }

  Future<void> _loadFallbackInfo() async {
    if (!kIsWeb) {
      deviceType = Platform.operatingSystem;
      deviceName = '${Platform.operatingSystem.capitalizeFirst} Device';
    }
  }

  Future<String> _getPersistentId() async {
    final prefs = await SharedPreferences.getInstance();
    const key = 'app_device_id';
    String? id = prefs.getString(key);
    
    if (id == null) {
      id = const Uuid().v4();
      await prefs.setString(key, id);
      debugPrint('Generated new persistent Device ID: $id');
    } else {
      debugPrint('Loaded existing persistent Device ID: $id');
    }
    return id;
  }
}
