import UIKit
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Set up platform channel for battery level
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                              binaryMessenger: controller.binaryMessenger)
    
    batteryChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      
      switch call.method {
      case "getBatteryLevel":
        self.getBatteryLevel(result: result)
      case "getBatteryInfo":
        self.getBatteryInfo(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    })
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func getBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    
    if device.batteryState == UIDevice.BatteryState.unknown {
      result(-1)
    } else {
      let batteryLevel = Int(device.batteryLevel * 100)
      result(batteryLevel)
    }
  }
  
  private func getBatteryInfo(result: FlutterResult) {
    let device = UIDevice.current
    device.isBatteryMonitoringEnabled = true
    
    let batteryLevel = Int(device.batteryLevel * 100)
    let isCharging = device.batteryState == .charging || device.batteryState == .full
    let isPluggedIn = device.batteryState != .unplugged
    
    let batteryInfo: [String: Any] = [
      "level": batteryLevel,
      "isCharging": isCharging,
      "isPluggedIn": isPluggedIn
    ]
    
    result(batteryInfo)
  }
}
