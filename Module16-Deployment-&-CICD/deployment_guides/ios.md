# iOS Deployment Guide

This guide covers the complete process of building and deploying a Flutter app to the Apple App Store.

## Prerequisites

- Flutter SDK (latest stable version)
- Xcode (latest version)
- Apple Developer Account ($99/year)
- macOS (required for iOS development)

## Step 1: App Configuration

### 1.1 Update pubspec.yaml

Ensure your app has proper versioning:

```yaml
name: deployment_demo_app
description: A sample Flutter application demonstrating deployment and CI/CD practices.
version: 1.0.0+1  # Format: version_name+version_code
```

### 1.2 Configure iOS Settings

Update `ios/Runner/Info.plist`:

```xml
<key>CFBundleDisplayName</key>
<string>Deployment Demo</string>
<key>CFBundleIdentifier</key>
<string>com.example.deploymentDemoApp</string>
<key>CFBundleShortVersionString</key>
<string>1.0.0</string>
<key>CFBundleVersion</key>
<string>1</string>
```

## Step 2: Apple Developer Account Setup

### 2.1 Enroll in Apple Developer Program

1. Go to [Apple Developer](https://developer.apple.com)
2. Click "Enroll" and pay the $99 annual fee
3. Complete the enrollment process

### 2.2 Create App ID

1. Go to "Certificates, Identifiers & Profiles"
2. Click "Identifiers" → "+"
3. Select "App IDs" → "App"
4. Fill in:
   - Description: Your app name
   - Bundle ID: com.example.deploymentDemoApp
   - Capabilities: Select required capabilities

### 2.3 Create Distribution Certificate

1. Go to "Certificates" → "+"
2. Select "iOS Distribution (App Store and Ad Hoc)"
3. Follow the certificate creation process
4. Download and install the certificate

### 2.4 Create Provisioning Profile

1. Go to "Profiles" → "+"
2. Select "App Store"
3. Choose your App ID
4. Select your distribution certificate
5. Name the profile and download it

## Step 3: Xcode Configuration

### 3.1 Open Project in Xcode

```bash
cd ios
open Runner.xcworkspace
```

### 3.2 Configure Signing

1. Select "Runner" project
2. Select "Runner" target
3. Go to "Signing & Capabilities"
4. Configure:
   - Team: Your Apple Developer Team
   - Bundle Identifier: com.example.deploymentDemoApp
   - Provisioning Profile: Select your App Store profile

### 3.3 Build Settings

Ensure these settings are correct:

- **Deployment Target**: iOS 12.0 or higher
- **Architectures**: Standard Architectures (arm64)
- **Build Active Architecture Only**: No (for Release)

## Step 4: Build Release IPA

### 4.1 Build from Command Line

```bash
flutter build ipa --release
```

Output: `build/ios/ipa/deployment_demo_app.ipa`

### 4.2 Build from Xcode

1. Open Xcode
2. Select "Any iOS Device (arm64)" as target
3. Product → Archive
4. Follow the archive process

### 4.3 Verify Build

Check the build output:

```bash
flutter build ipa --release --analyze-size
```

This will show the app size breakdown.

## Step 5: App Store Connect Setup

### 5.1 Create App

1. Go to [App Store Connect](https://appstoreconnect.apple.com)
2. Click "My Apps" → "+"
3. Select "New App"
4. Fill in:
   - Platform: iOS
   - Name: Your app name
   - Bundle ID: Select your App ID
   - SKU: Unique identifier

### 5.2 App Information

Complete the app information:

- **App Name**: Display name in App Store
- **Subtitle**: Brief description
- **Keywords**: Search keywords
- **Description**: Detailed app description
- **Support URL**: Your support website
- **Marketing URL**: Your app website

### 5.3 App Review Information

Provide review information:

- **Contact Information**: Your contact details
- **Demo Account**: Test account for reviewers
- **Notes**: Additional information for reviewers

## Step 6: Upload and Submit

### 6.1 Using Transporter App

1. Download [Transporter](https://apps.apple.com/us/app/transporter/id1450874784)
2. Add your app
3. Drag and drop your IPA file
4. Click "Upload"

### 6.2 Using Xcode Organizer

1. Open Xcode
2. Window → Organizer
3. Select your archive
4. Click "Distribute App"
5. Choose "App Store Connect"
6. Follow the upload process

### 6.3 Using Command Line

```bash
# Install altool (comes with Xcode)
xcrun altool --upload-app --type ios --file build/ios/ipa/deployment_demo_app.ipa --username "your-apple-id" --password "app-specific-password"
```

## Step 7: TestFlight Testing

### 7.1 Internal Testing

1. Go to App Store Connect → Your App → TestFlight
2. Click "Internal Testing"
3. Add internal testers
4. Upload build and start testing

### 7.2 External Testing

1. Go to "External Testing"
2. Create a new group
3. Add external testers
4. Submit for Beta App Review
5. Once approved, start testing

## Step 8: App Store Review

### 8.1 Prepare for Review

1. Complete all required metadata
2. Upload screenshots and videos
3. Set pricing and availability
4. Add app privacy information

### 8.2 Submit for Review

1. Go to "App Store" → "Prepare for Submission"
2. Review all information
3. Click "Submit for Review"
4. Wait for Apple's review (typically 1-3 days)

### 8.3 Review Process

Apple will review:
- App functionality
- Content appropriateness
- Technical requirements
- Privacy compliance

## Step 9: Release Management

### 9.1 Manual Release

After approval:
1. Go to "App Store" → "Prepare for Submission"
2. Click "Release This Version"
3. App goes live immediately

### 9.2 Scheduled Release

1. Set release date in App Store Connect
2. App will automatically release on that date

### 9.3 Phased Release

1. Enable "Phased Release"
2. App releases to 1% of users initially
3. Gradually increases to 100% over 7 days

## Step 10: Post-Release Monitoring

### 10.1 Analytics

Monitor in App Store Connect:
- Downloads
- Revenue
- Ratings and reviews
- Crash reports

### 10.2 Performance Monitoring

Use tools like:
- Firebase Performance Monitoring
- Crashlytics
- App Store Connect Analytics

## Common Issues and Solutions

### Issue: Code Signing Errors

**Solutions**:
- Verify certificates are valid
- Check provisioning profile matches bundle ID
- Ensure team ID is correct

### Issue: App Rejected

**Common reasons**:
- Missing privacy policy
- Inappropriate content
- Technical issues
- Policy violations

**Solution**: Review [App Store Review Guidelines](https://developer.apple.com/app-store/review/guidelines/)

### Issue: Build Size Too Large

**Solutions**:
- Enable bitcode
- Use asset catalogs
- Optimize images
- Remove unused code

## Best Practices

1. **Testing**: Test thoroughly on multiple devices
2. **Documentation**: Provide clear app descriptions
3. **Screenshots**: Use high-quality screenshots
4. **Privacy**: Be transparent about data usage
5. **Updates**: Regular updates improve app ranking

## Automation with CI/CD

For automated deployment, see the [CI/CD Workflows](../ci_cd_workflows/) section for GitHub Actions examples.

## Next Steps

- [Android Deployment Guide](../android.md)
- [CI/CD Workflows](../ci_cd_workflows/)
- [Code Signing Guide](../signing_configs/)
