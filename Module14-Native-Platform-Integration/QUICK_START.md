# DeviceHub - Quick Start Guide

## 🚀 Get Started in 5 Minutes

### Prerequisites
- Flutter SDK 3.24.0+
- Dart SDK 3.6.1+
- Xcode (for iOS)
- Android Studio (for Android)

### Step 1: Install Dependencies
```bash
flutter pub get
```

### Step 2: Launch Simulator/Emulator
**iOS Simulator:**
```bash
open -a Simulator
```

**Android Emulator:**
```bash
flutter emulators --launch <emulator_name>
```

### Step 3: Run the App
```bash
flutter run
```

## 📱 What You'll See

### Home Screen
- **4 Feature Cards**: Permissions, Camera, Location, Battery
- **Material 3 Design**: Modern UI with beautiful theming
- **Navigation**: Tap any card to explore features

### Permissions Page
- Check current permission status
- Request camera and location permissions
- See permission state changes in real-time
- Handle permanently denied permissions

### Camera Page
- Camera preview (fallback on simulator)
- Photo capture functionality
- Switch between front/back cameras
- Image preview after capture

### Location Page
- Get current GPS coordinates
- Start/stop location tracking
- View location history with timestamps
- Calculate distances between points

### Battery Page
- Get battery level via platform channel
- View charging status
- See how Flutter communicates with native code

## 🔧 Platform-Specific Setup

### iOS
The app is pre-configured with:
- ✅ Camera permission in Info.plist
- ✅ Location permission in Info.plist
- ✅ Platform channel in AppDelegate.swift

### Android
The app is pre-configured with:
- ✅ Camera permission in AndroidManifest.xml
- ✅ Location permissions in AndroidManifest.xml
- ✅ Platform channel in MainActivity.kt

## 🧪 Testing Checklist

### Permissions Testing
- [ ] Tap "Permissions" card
- [ ] Check current status (should show "Denied")
- [ ] Tap "Request Permission" for camera
- [ ] Allow permission in dialog
- [ ] Verify status changes to "Granted"

### Camera Testing
- [ ] Tap "Camera" card
- [ ] Grant camera permission when prompted
- [ ] See camera preview (or fallback message on simulator)
- [ ] Tap capture button
- [ ] View captured image

### Location Testing
- [ ] Tap "Location" card
- [ ] Grant location permission when prompted
- [ ] Tap "Get Location" to get coordinates
- [ ] Tap "Start Updates" for continuous tracking
- [ ] View location history

### Battery Testing
- [ ] Tap "Battery" card
- [ ] See battery level displayed
- [ ] Tap "Get Battery Info" for detailed info
- [ ] Verify platform channel is working

## 🐛 Troubleshooting

### Common Issues

**"Camera not working on simulator"**
- This is expected! iOS Simulator cannot access real camera
- Test on real device for full camera functionality

**"Location permission denied"**
- Check that location services are enabled on device
- Verify Info.plist has proper permission descriptions

**"Platform channel not working"**
- Ensure native code is properly registered
- Check console for error messages

**"Build errors"**
```bash
flutter clean
flutter pub get
flutter run
```

### Debug Commands
```bash
# Check Flutter installation
flutter doctor

# List available devices
flutter devices

# Run with verbose logging
flutter run -v

# Hot reload (while app is running)
r
```

## 📚 Learning Path

1. **Start with Permissions** - Understand permission handling
2. **Explore Camera** - Learn camera integration
3. **Test Location** - See GPS functionality
4. **Check Battery** - Understand platform channels

## 🎯 Next Steps

After running the app:
1. Read the full README.md for detailed explanations
2. Try the exercises in the README
3. Modify the code to add new features
4. Test on real devices for full functionality

## 💡 Tips

- **Simulator vs Real Device**: Some features work differently
- **Hot Reload**: Use `r` key to see changes instantly
- **Debug Console**: Check for error messages and logs
- **Permissions**: Test both granting and denying permissions

---

**Ready to explore?** Run `flutter run` and start with the Permissions page!
