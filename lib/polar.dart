import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

part 'polar_api_observer.dart';
part 'polar_ble_api.dart';
part 'polar_device_info.dart';
part 'polar_hr_data.dart';

class Polar {
  static const MethodChannel _channel = const MethodChannel('polar');

  final PolarApiObserver _observer;

  Polar(this._observer) {
    _channel.setMethodCallHandler((call) {
      switch (call.method) {
        case 'blePowerStateChanged':
          _observer.blePowerStateChanged(call.arguments);
          break;
        case 'deviceConnected':
          _observer.deviceConnected(
              PolarDeviceInfo.fromJson(jsonDecode(call.arguments)));
          break;
        case 'deviceConnecting':
          _observer.deviceConnecting(
              PolarDeviceInfo.fromJson(jsonDecode(call.arguments)));
          break;
        case 'deviceDisconnected':
          _observer.deviceDisconnected(
              PolarDeviceInfo.fromJson(jsonDecode(call.arguments)));
          break;
        case 'streamingFeaturesReady':
          _observer.streamingFeaturesReady(
            call.arguments[0],
            (call.arguments[1] as List<String>)
                .map((e) =>
                    EnumToString.fromString(
                        DeviceStreamingFeature.values, e.toLowerCase()) ??
                    DeviceStreamingFeature.error)
                .toList(),
          );
          break;
        case 'sdkModeFeatureAvailable':
          _observer.sdkModeFeatureAvailable(call.arguments);
          break;
        case 'hrFeatureReady':
          _observer.hrFeatureReady(call.arguments);
          break;
        case 'disInformationReceived':
          _observer.disInformationReceived(
            call.arguments[0],
            call.arguments[1],
            call.arguments[2],
          );
          break;
        case 'batteryLevelReceived':
          _observer.batteryLevelReceived(
            call.arguments[0],
            call.arguments[1],
          );
          break;
        case 'hrNotificationReceived':
          _observer.hrNotificationReceived(
            call.arguments[0],
            PolarHrData.fromJson(jsonDecode(call.arguments[1])),
          );
          break;
        case 'polarFtpFeatureReady':
          _observer.polarFtpFeatureReady(call.arguments);
          break;
      }

      return Future.value();
    });
  }

  /// Connect to a device with the given [deviceId]
  void connectToDevice(String deviceId) async {
    if (Platform.isAndroid) {
      await Permission.location.request();
    }

    _channel.invokeMethod('connectToDevice', deviceId);
  }

  /// Disconnect from a device with the given [deviceId]
  void disconnectFromDevice(String deviceId) {
    _channel.invokeMethod('disconnectFromDevice', deviceId);
  }
}
