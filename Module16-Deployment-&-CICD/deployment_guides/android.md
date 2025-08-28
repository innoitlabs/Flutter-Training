# Android Deployment Guide

This guide covers the complete process of building and deploying a Flutter app to the Google Play Store.

## Prerequisites

- Flutter SDK (latest stable version)
- Android Studio
- Google Play Console account
- Google Play Developer account ($25 one-time fee)

## Step 1: App Configuration

### 1.1 Update pubspec.yaml

Ensure your app has proper versioning:

```yaml
name: deployment_demo_app
description: A sample Flutter application demonstrating deployment and CI/CD practices.
version: 1.0.0+1  # Format: version_name+version_code
```

### 1.2 Configure Android Settings

Update `android/app/build.gradle`:

```gradle
android {
    namespace "com.example.deployment_demo_app"
    compileSdkVersion flutter.compileSdkVersion
    
    defaultConfig {
        applicationId "com.example.deployment_demo_app"
        minSdkVersion flutter.minSdkVersion
        targetSdkVersion flutter.targetSdkVersion
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }
}
```

## Step 2: Code Signing Setup

### 2.1 Generate Keystore

Create a keystore for signing your app:

```bash
keytool -genkey -v -keystore ~/my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
```

**Important**: Keep your keystore file and passwords secure. Losing them means you can't update your app.

### 2.2 Configure key.properties

Create `android/key.properties`:

```properties
storePassword=your_keystore_password
keyPassword=your_key_password
keyAlias=my-key-alias
storeFile=../my-release-key.jks
```

**Security**: Add `key.properties` to `.gitignore` to prevent committing secrets.

### 2.3 Update build.gradle

Modify `android/app/build.gradle` to use the keystore:

```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile keystoreProperties['storeFile'] ? file(keystoreProperties['storeFile']) : null
            storePassword keystoreProperties['storePassword']
        }
    }
    
    buildTypes {
        release {
            signingConfig signingConfigs.release
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }
}
```

## Step 3: Build Release APK/AAB

### 3.1 Build App Bundle (Recommended)

For Google Play Store, use App Bundle format:

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

### 3.2 Build APK (Alternative)

For direct distribution or testing:

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### 3.3 Build Split APKs

For testing on specific architectures:

```bash
flutter build apk --split-per-abi --release
```

Outputs:
- `app-arm64-v8a-release.apk`
- `app-armeabi-v7a-release.apk`
- `app-x86_64-release.apk`

## Step 4: Google Play Console Setup

### 4.1 Create App

1. Go to [Google Play Console](https://play.google.com/console)
2. Click "Create app"
3. Fill in app details:
   - App name
   - Default language
   - App or game
   - Free or paid

### 4.2 App Information

Complete the app information section:

- **App name**: Your app's display name
- **Short description**: Brief app description
- **Full description**: Detailed app description
- **App category**: Choose appropriate category
- **Content rating**: Complete content rating questionnaire

### 4.3 Store Listing

Upload required assets:

- **App icon**: 512x512 PNG
- **Feature graphic**: 1024x500 PNG
- **Screenshots**: At least 2 screenshots per device type
- **Video**: Optional promotional video

## Step 5: Upload and Release

### 5.1 Internal Testing

1. Go to "Testing" → "Internal testing"
2. Click "Create new release"
3. Upload your AAB file
4. Add release notes
5. Save and review release
6. Start rollout to internal testers

### 5.2 Closed Testing

1. Go to "Testing" → "Closed testing"
2. Create a new track (Alpha/Beta)
3. Upload AAB file
4. Add testers via email or Google Groups
5. Start rollout

### 5.3 Production Release

1. Go to "Production" → "Releases"
2. Click "Create new release"
3. Upload AAB file
4. Add release notes
5. Review and roll out

## Step 6: Release Management

### 6.1 Staged Rollout

Use staged rollout for production releases:

1. Start with 10% of users
2. Monitor crash reports and feedback
3. Gradually increase to 100%

### 6.2 Rollback Plan

If issues arise:

1. Pause the rollout
2. Investigate issues
3. Fix and upload new version
4. Resume rollout

## Step 7: Post-Release Monitoring

### 7.1 Analytics

Monitor key metrics:

- Installations
- Uninstallations
- Crash reports
- User ratings and reviews

### 7.2 Performance Monitoring

Use tools like:

- Firebase Performance Monitoring
- Crashlytics
- Google Analytics for Firebase

## Common Issues and Solutions

### Issue: Build Fails with Signing Error

**Solution**: Ensure keystore file exists and passwords are correct in `key.properties`.

### Issue: App Rejected by Google Play

**Common reasons**:
- Missing privacy policy
- Inappropriate content
- Technical issues
- Policy violations

**Solution**: Review [Google Play Policy](https://play.google.com/about/developer-content-policy/) and fix issues.

### Issue: App Size Too Large

**Solutions**:
- Use App Bundle instead of APK
- Enable R8/ProGuard optimization
- Remove unused resources
- Use vector graphics where possible

## Best Practices

1. **Version Management**: Always increment version code for each release
2. **Testing**: Test thoroughly on multiple devices before release
3. **Security**: Never commit keystore or passwords to version control
4. **Monitoring**: Set up crash reporting and analytics
5. **Documentation**: Maintain clear release notes and changelog

## Automation with CI/CD

For automated deployment, see the [CI/CD Workflows](../ci_cd_workflows/) section for GitHub Actions examples.

## Next Steps

- [iOS Deployment Guide](../ios.md)
- [CI/CD Workflows](../ci_cd_workflows/)
- [Code Signing Guide](../signing_configs/)
