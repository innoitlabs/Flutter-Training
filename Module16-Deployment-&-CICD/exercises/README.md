# Deployment & CI/CD Exercises

This section contains practical exercises to reinforce your learning of Flutter deployment and CI/CD concepts.

## Exercise Categories

### 🟢 Beginner Exercises
Basic concepts and simple configurations

### 🟡 Intermediate Exercises  
More complex scenarios and integrations

### 🔴 Advanced Exercises
Real-world deployment challenges

---

## 🟢 Beginner Exercises

### Exercise 1: Version Management
**Objective**: Learn proper versioning practices

**Tasks**:
1. Update your app's version in `pubspec.yaml`
2. Implement semantic versioning (MAJOR.MINOR.PATCH)
3. Create a version history log
4. Test version display in your app

**Expected Outcome**:
- Proper version format (e.g., `1.0.0+1`)
- Version history documentation
- App displays current version

**Files to Modify**:
- `pubspec.yaml`
- `lib/screens/settings_screen.dart`
- `VERSION_HISTORY.md`

---

### Exercise 2: Basic Android Build
**Objective**: Build a signed Android APK

**Tasks**:
1. Generate a keystore for your app
2. Configure `key.properties` file
3. Update `build.gradle` for signing
4. Build a release APK
5. Verify the APK is signed

**Expected Outcome**:
- Signed APK file
- Proper keystore configuration
- Build success without errors

**Commands to Use**:
```bash
keytool -genkey -v -keystore ~/my-release-key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
flutter build apk --release
```

---

### Exercise 3: iOS Simulator Testing
**Objective**: Test app on iOS Simulator

**Tasks**:
1. Open iOS Simulator
2. Run your app in debug mode
3. Test all app features
4. Verify app performance
5. Document any issues found

**Expected Outcome**:
- App runs successfully on simulator
- All features work correctly
- Performance is acceptable
- Issue documentation

**Commands to Use**:
```bash
flutter run -d ios
flutter devices
```

---

## 🟡 Intermediate Exercises

### Exercise 4: GitHub Actions Workflow
**Objective**: Create a basic CI/CD pipeline

**Tasks**:
1. Create `.github/workflows/flutter.yml`
2. Configure automated testing
3. Add code analysis
4. Set up build artifacts
5. Test the workflow

**Expected Outcome**:
- Automated test execution
- Code quality checks
- Build artifacts generation
- Successful workflow runs

**Files to Create**:
- `.github/workflows/flutter.yml`
- `test/widget_test.dart`
- `test/integration_test/`

---

### Exercise 5: Environment Configuration
**Objective**: Set up different build configurations

**Tasks**:
1. Create development, staging, and production flavors
2. Configure environment-specific variables
3. Set up different app icons for each environment
4. Test builds for each environment
5. Document configuration differences

**Expected Outcome**:
- Three different app builds
- Environment-specific configurations
- Visual distinction between builds
- Configuration documentation

**Files to Modify**:
- `lib/main.dart`
- `android/app/build.gradle`
- `ios/Runner.xcodeproj/project.pbxproj`

---

### Exercise 6: Automated Testing
**Objective**: Implement comprehensive testing

**Tasks**:
1. Write unit tests for business logic
2. Create widget tests for UI components
3. Implement integration tests
4. Set up test coverage reporting
5. Configure automated test execution

**Expected Outcome**:
- 80%+ test coverage
- Automated test execution
- Test reports generation
- CI/CD integration

**Files to Create**:
- `test/unit/`
- `test/widget/`
- `test/integration/`
- `coverage/`

---

## 🔴 Advanced Exercises

### Exercise 7: Complete CI/CD Pipeline
**Objective**: Build a production-ready deployment pipeline

**Tasks**:
1. Set up automated Android builds
2. Configure iOS builds with code signing
3. Implement automated testing
4. Add security scanning
5. Configure deployment to stores
6. Set up monitoring and notifications

**Expected Outcome**:
- End-to-end automated pipeline
- Secure code signing
- Automated store deployment
- Monitoring and alerting

**Technologies to Use**:
- GitHub Actions
- Fastlane
- Firebase App Distribution
- Slack notifications

---

### Exercise 8: Multi-Platform Deployment
**Objective**: Deploy to multiple platforms simultaneously

**Tasks**:
1. Configure Android Play Store deployment
2. Set up iOS App Store deployment
3. Implement web deployment (if applicable)
4. Configure automated release notes
5. Set up staged rollouts
6. Monitor deployment success

**Expected Outcome**:
- Multi-platform deployment
- Automated release management
- Rollout monitoring
- Success metrics tracking

**Platforms to Cover**:
- Google Play Store
- Apple App Store
- Web deployment (optional)

---

### Exercise 9: Performance Optimization
**Objective**: Optimize app for production deployment

**Tasks**:
1. Analyze app size and performance
2. Implement code splitting
3. Optimize images and assets
4. Configure ProGuard/R8 for Android
5. Set up performance monitoring
6. Implement crash reporting

**Expected Outcome**:
- Reduced app size
- Improved performance
- Production monitoring
- Crash reporting

**Tools to Use**:
- Flutter Inspector
- Firebase Performance
- Crashlytics
- ProGuard/R8

---

## 🏆 Challenge Exercise

### Exercise 10: Enterprise Deployment
**Objective**: Set up enterprise-grade deployment infrastructure

**Tasks**:
1. Implement blue-green deployment strategy
2. Set up automated rollback mechanisms
3. Configure A/B testing infrastructure
4. Implement feature flags
5. Set up comprehensive monitoring
6. Create disaster recovery procedures

**Expected Outcome**:
- Enterprise-grade deployment
- Zero-downtime deployments
- Comprehensive monitoring
- Disaster recovery plan

**Advanced Features**:
- Feature toggles
- A/B testing
- Blue-green deployment
- Automated rollbacks

---

## 📋 Exercise Submission Guidelines

### What to Submit
1. **Code**: All modified source files
2. **Documentation**: README with setup instructions
3. **Screenshots**: Evidence of successful completion
4. **Logs**: Build and deployment logs
5. **Configuration**: All configuration files

### Submission Format
```
exercise-submission/
├── exercise-1-version-management/
│   ├── README.md
│   ├── pubspec.yaml
│   ├── screenshots/
│   └── logs/
├── exercise-2-android-build/
│   ├── README.md
│   ├── android/
│   ├── screenshots/
│   └── build-output/
└── ...
```

### Evaluation Criteria
- **Completeness**: All tasks completed
- **Quality**: Code follows best practices
- **Documentation**: Clear and comprehensive
- **Functionality**: Everything works as expected
- **Security**: Proper security practices followed

---

## 🛠️ Tools and Resources

### Required Tools
- Flutter SDK
- Android Studio / Xcode
- Git
- GitHub account
- Apple Developer account (for iOS)
- Google Play Console account (for Android)

### Recommended Tools
- Fastlane
- Firebase Console
- Slack (for notifications)
- VS Code / Android Studio

### Learning Resources
- [Flutter Documentation](https://docs.flutter.dev)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Fastlane Documentation](https://docs.fastlane.tools)
- [Apple Developer Documentation](https://developer.apple.com)

---

## 🎯 Next Steps

After completing these exercises:

1. **Review**: Go through all completed exercises
2. **Reflect**: Identify areas for improvement
3. **Practice**: Apply concepts to real projects
4. **Share**: Contribute to open source projects
5. **Continue**: Explore advanced deployment topics

Remember: Practice makes perfect! Start with beginner exercises and gradually work your way up to advanced challenges.
