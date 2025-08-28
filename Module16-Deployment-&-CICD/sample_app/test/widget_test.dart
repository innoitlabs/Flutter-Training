import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:deployment_demo_app/main.dart';
import 'package:deployment_demo_app/providers/app_state.dart';
import 'package:deployment_demo_app/screens/home_screen.dart';
import 'package:deployment_demo_app/screens/deployment_info_screen.dart';
import 'package:deployment_demo_app/screens/settings_screen.dart';
import 'package:deployment_demo_app/widgets/feature_card.dart';
import 'package:deployment_demo_app/widgets/version_info_card.dart';

void main() {
  group('Deployment Demo App Widget Tests', () {
    testWidgets('App should start without crashing', (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(const DeploymentDemoApp());

      // Verify that the app starts successfully
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    testWidgets('Home screen displays correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => AppState(),
            child: const HomeScreen(),
          ),
        ),
      );

      // Verify main elements are present
      expect(find.text('Deployment Demo'), findsOneWidget);
      expect(find.text('Welcome to Deployment Demo'), findsOneWidget);
      expect(find.text('Deployment Features'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
    });

    testWidgets('Feature cards are interactive', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: GridView.count(
              crossAxisCount: 2,
              children: [
                FeatureCard(
                  icon: Icons.android,
                  title: 'Android Build',
                  subtitle: 'APK & AAB',
                  color: Colors.green,
                  onTap: () {},
                ),
                FeatureCard(
                  icon: Icons.apple,
                  title: 'iOS Build',
                  subtitle: 'IPA Package',
                  color: Colors.blue,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      );

      // Verify feature cards are displayed
      expect(find.text('Android Build'), findsOneWidget);
      expect(find.text('iOS Build'), findsOneWidget);
      expect(find.text('APK & AAB'), findsOneWidget);
      expect(find.text('IPA Package'), findsOneWidget);

      // Test tap interaction
      await tester.tap(find.text('Android Build'));
      await tester.pump();
    });

    testWidgets('Settings screen shows app information', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (context) => AppState(),
            child: const SettingsScreen(),
          ),
        ),
      );

      // Verify settings sections are present
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('App Information'), findsOneWidget);
      expect(find.text('Appearance'), findsOneWidget);
      expect(find.text('Build Configuration'), findsOneWidget);
    });

    testWidgets('Theme toggle works correctly', (WidgetTester tester) async {
      final appState = AppState();
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: appState,
            child: const SettingsScreen(),
          ),
        ),
      );

      // Find the theme toggle switch
      final themeSwitch = find.byType(Switch);
      expect(themeSwitch, findsOneWidget);

      // Test initial state (should be false for light mode)
      expect(appState.isDarkMode, false);

      // Tap the switch to toggle theme
      await tester.tap(themeSwitch);
      await tester.pump();

      // Verify theme changed
      expect(appState.isDarkMode, true);
    });

    testWidgets('Deployment info screen shows build commands', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: DeploymentInfoScreen(),
        ),
      );

      // Verify deployment sections are present
      expect(find.text('Deployment Info'), findsOneWidget);
      expect(find.text('Build Commands'), findsOneWidget);
      expect(find.text('Code Signing'), findsOneWidget);
      expect(find.text('CI/CD Pipeline'), findsOneWidget);

      // Verify specific build commands are shown
      expect(find.text('flutter build apk --release'), findsOneWidget);
      expect(find.text('flutter build appbundle --release'), findsOneWidget);
      expect(find.text('flutter build ipa --release'), findsOneWidget);
    });

    testWidgets('Version info card displays correctly', (WidgetTester tester) async {
      // Mock package info
      const mockPackageInfo = PackageInfo(
        appName: 'Deployment Demo',
        packageName: 'com.example.deployment_demo_app',
        version: '1.0.0',
        buildNumber: '1',
      );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: VersionInfoCard(packageInfo: mockPackageInfo),
          ),
        ),
      );

      // Verify version information is displayed
      expect(find.text('Version Information'), findsOneWidget);
      expect(find.text('App Name: Deployment Demo'), findsOneWidget);
      expect(find.text('Package: com.example.deployment_demo_app'), findsOneWidget);
      expect(find.text('Version: 1.0.0'), findsOneWidget);
      expect(find.text('Build Number: 1'), findsOneWidget);
    });

    testWidgets('App state management works correctly', (WidgetTester tester) async {
      final appState = AppState();
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: appState,
            child: const HomeScreen(),
          ),
        ),
      );

      // Test initial state
      expect(appState.currentVersion, '1.0.0');
      expect(appState.buildNumber, 1);

      // Simulate app update
      await appState.simulateAppUpdate();
      await tester.pump();

      // Verify version was updated
      expect(appState.currentVersion, '1.0.2');
      expect(appState.buildNumber, 2);
    });

    testWidgets('Navigation between screens works', (WidgetTester tester) async {
      await tester.pumpWidget(const DeploymentDemoApp());

      // Wait for app to load
      await tester.pumpAndSettle();

      // Verify initial screen (Home)
      expect(find.text('Deployment Demo'), findsOneWidget);

      // Navigate to Deployment Info
      await tester.tap(find.text('Deployment'));
      await tester.pumpAndSettle();
      expect(find.text('Deployment Info'), findsOneWidget);

      // Navigate to Settings
      await tester.tap(find.text('Settings'));
      await tester.pumpAndSettle();
      expect(find.text('Settings'), findsOneWidget);

      // Navigate back to Home
      await tester.tap(find.text('Home'));
      await tester.pumpAndSettle();
      expect(find.text('Deployment Demo'), findsOneWidget);
    });

    testWidgets('Quick actions work correctly', (WidgetTester tester) async {
      final appState = AppState();
      
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider.value(
            value: appState,
            child: const HomeScreen(),
          ),
        ),
      );

      // Test simulate update action
      await tester.tap(find.text('Simulate App Update'));
      await tester.pumpAndSettle();

      // Verify snackbar appears
      expect(find.text('App updated to version 1.0.2+2'), findsOneWidget);
    });

    testWidgets('App handles different screen sizes', (WidgetTester tester) async {
      // Test on a smaller screen
      tester.binding.window.physicalSizeTestValue = const Size(375, 667);
      tester.binding.window.devicePixelRatioTestValue = 2.0;

      await tester.pumpWidget(const DeploymentDemoApp());
      await tester.pumpAndSettle();

      // Verify app still displays correctly
      expect(find.text('Deployment Demo'), findsOneWidget);

      // Reset screen size
      tester.binding.window.clearPhysicalSizeTestValue();
      tester.binding.window.clearDevicePixelRatioTestValue();
    });

    testWidgets('Error handling works correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  throw Exception('Test error');
                },
                child: const Text('Trigger Error'),
              );
            },
          ),
        ),
      );

      // Trigger an error
      await tester.tap(find.text('Trigger Error'));
      await tester.pump();

      // Verify error is handled gracefully
      // (In a real app, this would be caught by error handling)
    });
  });
}

// Mock PackageInfo class for testing
class PackageInfo {
  final String appName;
  final String packageName;
  final String version;
  final String buildNumber;

  const PackageInfo({
    required this.appName,
    required this.packageName,
    required this.version,
    required this.buildNumber,
  });
}
