import 'package:flutter/services.dart';

/// Platform channel for battery level functionality
/// This demonstrates how to communicate with native platform code
class BatteryChannel {
  static const MethodChannel _channel = MethodChannel('samples.flutter.dev/battery');

  /// Get the current battery level from the native platform
  /// Returns a value between 0 and 100, or -1 if unable to get battery level
  static Future<int> getBatteryLevel() async {
    try {
      final int batteryLevel = await _channel.invokeMethod('getBatteryLevel');
      return batteryLevel;
    } on PlatformException catch (e) {
      // Handle platform-specific errors
      print('Failed to get battery level: ${e.message}');
      return -1;
    } catch (e) {
      // Handle other errors
      print('Unexpected error getting battery level: $e');
      return -1;
    }
  }

  /// Get battery status information (charging, plugged in, etc.)
  /// This is an example of how you could extend the platform channel
  static Future<Map<String, dynamic>> getBatteryInfo() async {
    try {
      final Map<String, dynamic> batteryInfo = await _channel.invokeMethod('getBatteryInfo');
      return batteryInfo;
    } on PlatformException catch (e) {
      print('Failed to get battery info: ${e.message}');
      return {
        'level': -1,
        'isCharging': false,
        'isPluggedIn': false,
        'error': e.message,
      };
    } catch (e) {
      print('Unexpected error getting battery info: $e');
      return {
        'level': -1,
        'isCharging': false,
        'isPluggedIn': false,
        'error': 'Unknown error',
      };
    }
  }
}
