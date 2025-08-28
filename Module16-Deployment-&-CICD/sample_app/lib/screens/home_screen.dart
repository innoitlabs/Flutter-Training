import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../providers/app_state.dart';
import '../widgets/feature_card.dart';
import '../widgets/version_info_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _loadPackageInfo();
  }

  Future<void> _loadPackageInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = packageInfo;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deployment Demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showAppInfo(context);
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadPackageInfo,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Section
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to Deployment Demo',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'This app demonstrates Flutter deployment and CI/CD practices. Explore the features below to learn about app deployment.',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Version Information
              if (_packageInfo != null) VersionInfoCard(packageInfo: _packageInfo!),
              
              const SizedBox(height: 24),
              
              // Features Grid
              Text(
                'Deployment Features',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  FeatureCard(
                    icon: Icons.android,
                    title: 'Android Build',
                    subtitle: 'APK & AAB',
                    color: Colors.green,
                    onTap: () => _showBuildInfo('Android'),
                  ),
                  FeatureCard(
                    icon: Icons.apple,
                    title: 'iOS Build',
                    subtitle: 'IPA Package',
                    color: Colors.blue,
                    onTap: () => _showBuildInfo('iOS'),
                  ),
                  FeatureCard(
                    icon: Icons.security,
                    title: 'Code Signing',
                    subtitle: 'Keystore & Certificates',
                    color: Colors.orange,
                    onTap: () => _showSigningInfo(),
                  ),
                  FeatureCard(
                    icon: Icons.rocket_launch,
                    title: 'CI/CD Pipeline',
                    subtitle: 'GitHub Actions',
                    color: Colors.purple,
                    onTap: () => _showCICDInfo(),
                  ),
                ],
              ),
              
              const SizedBox(height: 24),
              
              // Quick Actions
              Text(
                'Quick Actions',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              
              Consumer<AppState>(
                builder: (context, appState, child) {
                  return Column(
                    children: [
                      ListTile(
                        leading: const Icon(Icons.brightness_6),
                        title: const Text('Toggle Theme'),
                        subtitle: Text(appState.isDarkMode ? 'Dark Mode' : 'Light Mode'),
                        trailing: Switch(
                          value: appState.isDarkMode,
                          onChanged: (value) => appState.toggleTheme(),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.update),
                        title: const Text('Simulate App Update'),
                        subtitle: Text('Current: ${appState.currentVersion}+${appState.buildNumber}'),
                        onTap: () => _simulateUpdate(context, appState),
                      ),
                      ListTile(
                        leading: const Icon(Icons.refresh),
                        title: const Text('Reset App Data'),
                        subtitle: const Text('Clear all settings'),
                        onTap: () => _resetAppData(context, appState),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAppInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('App Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_packageInfo != null) ...[
              Text('App Name: ${_packageInfo!.appName}'),
              Text('Package: ${_packageInfo!.packageName}'),
              Text('Version: ${_packageInfo!.version}'),
              Text('Build: ${_packageInfo!.buildNumber}'),
            ],
            const SizedBox(height: 16),
            const Text('This is a demonstration app for Flutter deployment and CI/CD practices.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showBuildInfo(String platform) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('$platform Build Information'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Platform: $platform'),
            const SizedBox(height: 8),
            if (platform == 'Android') ...[
              const Text('• Build APK: flutter build apk --release'),
              const Text('• Build AAB: flutter build appbundle --release'),
              const Text('• Output: build/app/outputs/flutter-apk/'),
            ] else ...[
              const Text('• Build IPA: flutter build ipa --release'),
              const Text('• Requires Xcode and signing'),
              const Text('• Output: build/ios/ipa/'),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showSigningInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Code Signing'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Android:'),
            Text('• Keystore (.jks file)'),
            Text('• key.properties configuration'),
            SizedBox(height: 8),
            Text('iOS:'),
            Text('• Distribution Certificate'),
            Text('• Provisioning Profile'),
            Text('• Managed via Xcode'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCICDInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('CI/CD Pipeline'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('GitHub Actions Workflow:'),
            Text('• Automated testing'),
            Text('• Build generation'),
            Text('• Deployment to stores'),
            Text('• Secure secret management'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _simulateUpdate(BuildContext context, AppState appState) {
    appState.simulateAppUpdate();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('App updated to version ${appState.currentVersion}+${appState.buildNumber}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _resetAppData(BuildContext context, AppState appState) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset App Data'),
        content: const Text('This will clear all app settings and reset to default values. Continue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              appState.resetAppData();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('App data reset successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
