# Module 14 — Native Platform Integration (Dart 3.6.1)

## Learning Objectives

- **Access device features** via plugins and platform APIs
- **Implement camera functionality** (take a picture, preview)
- **Use location services** (get current location, listen for updates)
- **Handle permissions gracefully** (camera, location)
- **Understand platform channels** for custom native code integration

## Key Concepts

### 1. Platform Channels vs Plugins

**Plugins** are pre-built packages that provide cross-platform APIs for common device features. They handle the native implementation for you.

**Platform Channels** are lower-level communication bridges between Flutter and native code (Swift/Kotlin). Use them when:
- No plugin exists for your needs
- You need custom native functionality
- You want to optimize performance for platform-specific features

### 2. Camera Integration

The camera flow involves:
1. **Permission check** - Request camera access
2. **Camera initialization** - Set up camera controller
3. **Preview** - Show live camera feed
4. **Capture** - Take photo and save to file
5. **Cleanup** - Dispose controllers to prevent memory leaks

### 3. Location Services

Location functionality includes:
- **One-time location** - Get current position
- **Continuous updates** - Listen to location stream
- **Permission handling** - Request location access
- **Service status** - Check if GPS is enabled

### 4. Permission Handling

Permission states:
- **Granted** - Permission is available
- **Denied** - Permission was denied but can be requested again
- **Permanently Denied** - User must enable in settings
- **Restricted** - System restricts the permission

### 5. Platform Channels Architecture

```
Flutter (Dart) ↔ MethodChannel ↔ Native Code (Swift/Kotlin)
```

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   ├── app.dart             # Main app widget
│   └── theme.dart           # Material 3 theming
└── features/
    ├── camera/
    │   └── camera_page.dart  # Camera functionality
    ├── location/
    │   └── location_page.dart # GPS functionality
    ├── permissions/
    │   └── permissions_page.dart # Permission management
    └── platform/
        ├── battery_channel.dart # Platform channel
        └── battery_page.dart    # Battery demo
```

## Runnable Examples

### Example A: Permissions Page

The permissions page demonstrates proper permission handling:

```dart
// Check current permission status
final cameraStatus = await Permission.camera.status;
final locationStatus = await Permission.location.status;

// Request permission if needed
final status = await Permission.camera.request();

// Handle different permission states
if (status.isDenied) {
  // Show message to user
} else if (status.isPermanentlyDenied) {
  // Open app settings
}
```

**Key Features:**
- Real-time permission status display
- Request permissions with user feedback
- Handle permanently denied permissions
- Open app settings when needed

### Example B: Camera Page

The camera page shows full camera integration:

```dart
// Initialize camera controller
_controller = CameraController(
  _cameras[_selectedCameraIndex],
  ResolutionPreset.high,
  enableAudio: false,
);

// Show camera preview
CameraPreview(_controller!)

// Capture photo
final XFile image = await _controller!.takePicture();
```

**Key Features:**
- Camera preview with live feed
- Photo capture functionality
- Switch between front/back cameras
- Image preview after capture
- Graceful error handling

### Example C: Location Page

The location page demonstrates GPS functionality:

```dart
// Get current position
final position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.high,
);

// Listen to location updates
_positionStream = Geolocator.getPositionStream(
  locationSettings: locationSettings,
).listen((Position position) {
  // Handle position updates
});
```

**Key Features:**
- One-time location retrieval
- Continuous location tracking
- Location history with distance calculation
- Real-time coordinate display
- GPS service status checking

### Example D: Platform Channel (Battery)

The battery page demonstrates custom platform channel:

```dart
// Flutter side - call native method
final batteryLevel = await BatteryChannel.getBatteryLevel();

// Native iOS (Swift)
private func getBatteryLevel(result: FlutterResult) {
  let device = UIDevice.current
  let batteryLevel = Int(device.batteryLevel * 100)
  result(batteryLevel)
}

// Native Android (Kotlin)
private fun getBatteryLevel(): Int {
  val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
  return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
}
```

**Key Features:**
- Custom MethodChannel implementation
- Native iOS and Android code
- Battery level and status information
- Error handling and fallbacks

## Platform Configuration

### iOS Configuration

**Info.plist** - Add permission descriptions:

```xml
<!-- Camera Permission -->
<key>NSCameraUsageDescription</key>
<string>This app needs camera access to take photos and demonstrate camera functionality.</string>

<!-- Location Permission -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs location access to demonstrate GPS functionality and get your current coordinates.</string>
```

**AppDelegate.swift** - Platform channel setup:

```swift
let batteryChannel = FlutterMethodChannel(name: "samples.flutter.dev/battery",
                                          binaryMessenger: controller.binaryMessenger)

batteryChannel.setMethodCallHandler({
  (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
  // Handle method calls
})
```

### Android Configuration

**AndroidManifest.xml** - Add permissions:

```xml
<!-- Camera Permission -->
<uses-permission android:name="android.permission.CAMERA" />

<!-- Location Permissions -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

**MainActivity.kt** - Platform channel setup:

```kotlin
MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
  when (call.method) {
    "getBatteryLevel" -> {
      val batteryLevel = getBatteryLevel()
      result.success(batteryLevel)
    }
  }
}
```

## Run & Verify — iOS Simulator

### Prerequisites

1. **Flutter SDK** - Ensure you have Flutter 3.24.0+ installed
2. **Xcode** - Latest version with iOS Simulator
3. **Dart SDK** - Version 3.6.1 or higher

### Setup Steps

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Launch iOS Simulator:**
   ```bash
   open -a Simulator
   ```

3. **Run the app:**
   ```bash
   flutter run -d ios
   ```

### Verification Checklist

#### ✅ Permissions Page
- [ ] Check current permission status for camera and location
- [ ] Request camera permission (will show iOS permission dialog)
- [ ] Request location permission (will show iOS permission dialog)
- [ ] Verify permission status updates in UI
- [ ] Test "Settings" button for permanently denied permissions

#### ✅ Camera Page
- [ ] Camera controller initializes (may show fallback on simulator)
- [ ] Permission request dialog appears
- [ ] Camera preview loads (or shows appropriate error message)
- [ ] Capture button is functional
- [ ] Switch camera button works (if multiple cameras available)

#### ✅ Location Page
- [ ] Location permission request works
- [ ] "Get Location" button retrieves coordinates
- [ ] "Start Updates" begins continuous location tracking
- [ ] Location history displays with timestamps
- [ ] Distance calculations work between points

#### ✅ Battery Page
- [ ] Platform channel returns battery level
- [ ] Battery info shows charging status
- [ ] Error handling works for unsupported features
- [ ] UI updates with battery level changes

### Simulator Limitations

**iOS Simulator:**
- ❌ Cannot access real camera (shows fallback UI)
- ✅ Can provide mock location data
- ✅ Can simulate battery level changes
- ✅ Permission dialogs work normally

**Real Device Testing:**
- ✅ Full camera functionality
- ✅ Real GPS coordinates
- ✅ Actual battery level
- ✅ All permissions work as expected

## Best Practices

### 1. Permission Handling
- **Always check permissions** before accessing device features
- **Request permissions** at the right time (when user needs the feature)
- **Handle denial gracefully** with clear messaging
- **Provide fallbacks** for permanently denied permissions

### 2. Resource Management
- **Dispose controllers** in `dispose()` method
- **Cancel streams** to prevent memory leaks
- **Handle lifecycle** properly (pause/resume camera)

### 3. Error Handling
- **Catch platform exceptions** with specific error messages
- **Provide user-friendly error messages**
- **Implement retry mechanisms** where appropriate

### 4. Platform Differences
- **Test on both iOS and Android**
- **Handle platform-specific behaviors**
- **Use platform-specific configurations**

### 5. Performance
- **Use platform channels sparingly** - prefer plugins when available
- **Optimize camera resolution** for your use case
- **Limit location update frequency** to save battery

## Exercises

### Easy: Gallery Picker
Add image picker functionality using the `image_picker` package:
```dart
final ImagePicker picker = ImagePicker();
final XFile? image = await picker.pickImage(source: ImageSource.gallery);
```

### Intermediate: Map Integration
Extend the location page with Google Maps:
```dart
// Add google_maps_flutter dependency
// Display current location on map
// Show location history as markers
```

### Advanced: Custom Platform Channel
Create a new platform channel for device information:
```dart
// Get device model, OS version, etc.
// Implement in both iOS and Android
// Display in a new "Device Info" page
```

## Troubleshooting

### Common Issues

1. **Camera not working on simulator:**
   - This is expected behavior
   - Test on real device for full functionality

2. **Location permission denied:**
   - Check Info.plist configuration
   - Ensure location services are enabled

3. **Platform channel errors:**
   - Verify channel name matches in native code
   - Check method name spelling
   - Ensure native code is properly registered

4. **Build errors:**
   - Run `flutter clean` and `flutter pub get`
   - Check Dart SDK version compatibility
   - Verify all dependencies are compatible

### Debug Tips

- Use `print()` statements to debug platform channel communication
- Check console logs for permission-related messages
- Test permissions manually in device settings
- Use Flutter Inspector to debug UI issues

## Conclusion

This module demonstrates comprehensive native platform integration in Flutter. You've learned:

- How to properly handle device permissions
- Camera integration with preview and capture
- Location services with continuous updates
- Platform channels for custom native functionality
- Best practices for production apps

The DeviceHub app serves as a complete reference implementation that you can extend and customize for your own projects.

---

**Next Steps:**
- Experiment with additional device features
- Integrate with other native APIs
- Build production-ready apps with proper error handling
- Explore advanced platform channel patterns
