# Code Signing Guide

This guide covers secure code signing practices for both Android and iOS Flutter applications.

## Overview

Code signing is essential for:
- **Security**: Ensures app integrity and authenticity
- **Distribution**: Required for app store deployment
- **Trust**: Users can verify app source
- **Updates**: Enables seamless app updates

## Android Code Signing

### 1. Keystore Generation

Generate a keystore for signing your Android app:

```bash
keytool -genkey -v -keystore ~/my-release-key.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias my-key-alias \
  -storepass your_keystore_password \
  -keypass your_key_password
```

**Important**: Store keystore securely and backup multiple locations.

### 2. Keystore Properties

Create `android/key.properties`:

```properties
storePassword=your_keystore_password
keyPassword=your_key_password
keyAlias=my-key-alias
storeFile=../my-release-key.jks
```

### 3. Build Configuration

Update `android/app/build.gradle`:

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

### 4. Security Best Practices

- **Never commit keystore files** to version control
- **Use strong passwords** for keystore and key
- **Backup keystore** in multiple secure locations
- **Rotate keys** periodically
- **Use different keystores** for different environments

## iOS Code Signing

### 1. Apple Developer Account Setup

1. Enroll in Apple Developer Program ($99/year)
2. Create App ID in Developer Portal
3. Generate distribution certificate
4. Create provisioning profile

### 2. Xcode Configuration

1. Open project in Xcode:
   ```bash
   cd ios
   open Runner.xcworkspace
   ```

2. Configure signing:
   - Select "Runner" project
   - Go to "Signing & Capabilities"
   - Set Team and Bundle Identifier
   - Select provisioning profile

### 3. Manual Certificate Management

#### Distribution Certificate
```bash
# Export certificate
openssl pkcs12 -export -in certificate.pem -inkey private_key.pem -out certificate.p12

# Import in Xcode
# Keychain Access → Import → Select certificate.p12
```

#### Provisioning Profile
1. Download from Apple Developer Portal
2. Double-click to install
3. Verify in Xcode project settings

### 4. Automated Code Signing with Fastlane

#### Match Setup
```bash
# Initialize match
fastlane match init

# Generate certificates and profiles
fastlane match appstore
fastlane match development
```

#### Matchfile Configuration
```ruby
git_url("https://github.com/your-org/certificates.git")
storage_mode("git")

type("appstore")
app_identifier(["com.example.deploymentDemoApp"])
team_id("ABC123DEF4")
```

## CI/CD Integration

### 1. GitHub Actions Secrets

Store sensitive information as GitHub secrets:

```yaml
# Android
KEYSTORE_BASE64: <base64-encoded-keystore>
KEYSTORE_PASSWORD: your_keystore_password
KEY_PASSWORD: your_key_password
KEY_ALIAS: my-key-alias

# iOS
IOS_P12_BASE64: <base64-encoded-p12>
IOS_P12_PASSWORD: your_p12_password
IOS_PROVISIONING_PROFILE_BASE64: <base64-encoded-profile>
```

### 2. Workflow Configuration

#### Android Build with Signing
```yaml
- name: Decode Keystore
  run: |
    echo "${{ secrets.KEYSTORE_BASE64 }}" | base64 -d > android/app/keystore.jks
    
- name: Create key.properties
  run: |
    cat > android/key.properties << EOF
    storePassword=${{ secrets.KEYSTORE_PASSWORD }}
    keyPassword=${{ secrets.KEY_PASSWORD }}
    keyAlias=${{ secrets.KEY_ALIAS }}
    storeFile=app/keystore.jks
    EOF
```

#### iOS Build with Signing
```yaml
- name: Setup Code Signing
  uses: apple-actions/import-codesigning-certs@v1
  with:
    p12-file-base64: ${{ secrets.IOS_P12_BASE64 }}
    p12-password: ${{ secrets.IOS_P12_PASSWORD }}
    
- name: Install Provisioning Profile
  run: |
    mkdir -p ~/Library/MobileDevice/Provisioning\ Profiles
    echo "${{ secrets.IOS_PROVISIONING_PROFILE_BASE64 }}" | base64 -d > ~/Library/MobileDevice/Provisioning\ Profiles/profile.mobileprovision
```

## Security Best Practices

### 1. Key Management

- **Use strong passwords** (minimum 12 characters)
- **Store keys securely** (hardware security modules if possible)
- **Limit access** to signing keys
- **Monitor key usage** and access logs

### 2. Environment Separation

- **Development**: Use debug certificates
- **Staging**: Use ad-hoc distribution
- **Production**: Use app store distribution

### 3. Backup Strategy

- **Multiple locations**: Cloud storage, local backup, secure vault
- **Encrypted backups**: Use strong encryption
- **Regular testing**: Verify backup integrity
- **Documentation**: Maintain recovery procedures

### 4. Key Rotation

- **Regular rotation**: Every 1-2 years
- **Gradual rollout**: Update certificates before expiration
- **Testing**: Verify new certificates work
- **Communication**: Notify team of changes

## Troubleshooting

### Common Android Issues

#### Keystore Not Found
```bash
# Verify keystore location
ls -la android/app/keystore.jks

# Check key.properties path
cat android/key.properties
```

#### Password Mismatch
```bash
# Verify keystore integrity
keytool -list -v -keystore android/app/keystore.jks
```

### Common iOS Issues

#### Certificate Expired
```bash
# Check certificate validity
security find-identity -v -p codesigning

# Renew certificate in Developer Portal
```

#### Provisioning Profile Mismatch
```bash
# Verify bundle identifier
grep -r "PRODUCT_BUNDLE_IDENTIFIER" ios/

# Update provisioning profile
```

## Tools and Resources

### Android Tools
- **keytool**: Java key and certificate management
- **jarsigner**: JAR signing utility
- **apksigner**: APK signing utility

### iOS Tools
- **Xcode**: Integrated development environment
- **Fastlane**: Automation toolkit
- **Match**: Code signing automation

### Security Tools
- **OpenSSL**: Certificate management
- **Keychain Access**: macOS key management
- **Certificate Manager**: Windows certificate management

## Next Steps

- [Android Deployment Guide](../deployment_guides/android.md)
- [iOS Deployment Guide](../deployment_guides/ios.md)
- [CI/CD Workflows](../ci_cd_workflows/)
- [Exercises](../exercises/)
