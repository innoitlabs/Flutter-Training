# Lesson 2: Firebase Project Setup

## 🎯 Learning Objectives
- Create a Firebase project
- Configure Android and iOS apps
- Add Google Services files
- Install necessary dependencies
- Enable Authentication in Firebase Console

## 📋 Prerequisites
- Flutter 3.32.6+ installed
- Android Studio or VS Code
- Google account
- Basic Flutter project created

## 🚀 Step 1: Create Firebase Project

### 1.1 Go to Firebase Console
1. Open your browser and go to [Firebase Console](https://console.firebase.google.com/)
2. Sign in with your Google account
3. Click **"Create a project"** or **"Add project"**

### 1.2 Project Configuration
1. **Project name:** `flutter-auth-app` (or your preferred name)
2. **Google Analytics:** Enable (recommended for learning)
3. **Analytics account:** Use default or create new
4. Click **"Create project"**

### 1.3 Wait for Setup
- Firebase will create your project
- This usually takes 1-2 minutes
- Click **"Continue"** when ready

## 📱 Step 2: Configure Android App

### 2.1 Add Android App
1. In your Firebase project, click **"Add app"**
2. Select **Android** icon
3. **Android package name:** `com.example.flutter_firebase_auth_app`
   - This should match your `android/app/build.gradle` file
4. **App nickname:** `Flutter Auth App (Android)`
5. **Debug signing certificate:** Leave blank for now
6. Click **"Register app"**

### 2.2 Download google-services.json
1. Download the `google-services.json` file
2. **Important:** Place it in `android/app/` directory
3. Your file structure should look like:
   ```
   android/
   └── app/
       ├── google-services.json  ← HERE
       ├── build.gradle
       └── src/
   ```

### 2.3 Update Android Configuration
1. Open `android/app/build.gradle`
2. Add the following at the **top** of the file:

```gradle
// Add this at the very top
apply plugin: 'com.google.gms.google-services'
```

3. Open `android/build.gradle` (project level)
4. Add the following in the `dependencies` block:

```gradle
buildscript {
    dependencies {
        // Add this line
        classpath 'com.google.gms:google-services:4.4.0'
    }
}
```

## 🍎 Step 3: Configure iOS App

### 3.1 Add iOS App
1. In Firebase Console, click **"Add app"** again
2. Select **iOS** icon
3. **iOS bundle ID:** `com.example.flutterFirebaseAuthApp`
   - This should match your `ios/Runner/Info.plist` file
4. **App nickname:** `Flutter Auth App (iOS)`
5. **App Store ID:** Leave blank for now
6. Click **"Register app"**

### 3.2 Download GoogleService-Info.plist
1. Download the `GoogleService-Info.plist` file
2. **Important:** Add it to your Xcode project:
   - Open `ios/Runner.xcworkspace` in Xcode
   - Right-click on `Runner` folder
   - Select **"Add Files to Runner"**
   - Choose the downloaded `GoogleService-Info.plist`
   - Make sure **"Copy items if needed"** is checked
   - Make sure **"Add to target: Runner"** is checked

### 3.3 Update iOS Configuration
1. Open `ios/Runner/Info.plist`
2. Add the following before the closing `</dict>` tag:

```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleURLName</key>
        <string>REVERSED_CLIENT_ID</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>YOUR_REVERSED_CLIENT_ID</string>
        </array>
    </dict>
</array>
```

**Note:** Replace `YOUR_REVERSED_CLIENT_ID` with the value from your `GoogleService-Info.plist` file.

## 📦 Step 4: Install Dependencies

### 4.1 Update pubspec.yaml
Open your `pubspec.yaml` file and add these dependencies:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Firebase Dependencies
  firebase_core: ^3.6.0
  firebase_auth: ^5.3.1
  
  # Google Sign-In
  google_sign_in: ^6.2.1
  
  # State Management
  provider: ^6.1.2
  
  # UI Dependencies
  cupertino_icons: ^1.0.8
  flutter_svg: ^2.0.10+1
  
  # Environment Variables
  flutter_dotenv: ^5.1.0
```

### 4.2 Install Dependencies
Run the following command in your terminal:

```bash
flutter pub get
```

## 🔐 Step 5: Enable Authentication

### 5.1 Go to Authentication
1. In Firebase Console, click **"Authentication"** in the left sidebar
2. Click **"Get started"**

### 5.2 Enable Sign-in Methods
1. Click **"Sign-in method"** tab
2. Enable **Email/Password:**
   - Click on **"Email/Password"**
   - Toggle **"Enable"**
   - Click **"Save"**

3. Enable **Google:**
   - Click on **"Google"**
   - Toggle **"Enable"**
   - Select a **Project support email**
   - Click **"Save"**

## 🛠️ Step 6: Initialize Firebase in Flutter

### 6.1 Update main.dart
Replace your `lib/main.dart` with the following:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/splash_screen.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp();
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
```

## 🧪 Step 7: Test Firebase Connection

### 7.1 Create Test File
Create `lib/test_firebase.dart`:

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTest {
  static Future<void> testConnection() async {
    try {
      // Test Firebase Core
      await Firebase.initializeApp();
      print('✅ Firebase Core initialized successfully');
      
      // Test Firebase Auth
      FirebaseAuth auth = FirebaseAuth.instance;
      print('✅ Firebase Auth instance created');
      
      // Test current user
      User? user = auth.currentUser;
      print('Current user: ${user?.email ?? 'No user logged in'}');
      
    } catch (e) {
      print('❌ Firebase connection failed: $e');
    }
  }
}
```

### 7.2 Run Test
Add this to your `main()` function temporarily:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  // Test Firebase connection
  await FirebaseTest.testConnection();
  
  runApp(MyApp());
}
```

## 🚨 Common Setup Issues and Solutions

### Issue 1: "Firebase not initialized"
**Solution:** Make sure you call `Firebase.initializeApp()` before using any Firebase services.

### Issue 2: "Google Services file not found"
**Solution:** 
- Check file location: `android/app/google-services.json`
- Verify file name (case-sensitive)
- Clean and rebuild: `flutter clean && flutter pub get`

### Issue 3: "iOS build fails"
**Solution:**
- Make sure `GoogleService-Info.plist` is added to Xcode project
- Check bundle ID matches in both places
- Clean iOS build: `cd ios && rm -rf Pods Podfile.lock && pod install`

### Issue 4: "Authentication not enabled"
**Solution:**
- Go to Firebase Console → Authentication → Sign-in method
- Enable Email/Password and Google
- Wait a few minutes for changes to propagate

## ✅ Verification Checklist

Before moving to the next lesson, verify:

- [ ] Firebase project created
- [ ] Android app configured with `google-services.json`
- [ ] iOS app configured with `GoogleService-Info.plist`
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Authentication methods enabled in Firebase Console
- [ ] Firebase initializes without errors
- [ ] App runs on both Android and iOS

## 🎯 What's Next?

Great! You've successfully set up Firebase in your Flutter project. In **Lesson 3**, we'll build beautiful login and registration screens.

### Key Takeaways
- Firebase setup requires configuration for both Android and iOS
- Google Services files are essential for Firebase to work
- Authentication must be enabled in Firebase Console
- Always test your setup before proceeding

---

**Ready to build some beautiful UIs? Let's go to Lesson 3! 🎨**
