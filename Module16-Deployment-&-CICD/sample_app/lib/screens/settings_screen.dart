import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../providers/app_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // App Information
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'App Information',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_packageInfo != null) ...[
                      _buildInfoRow('App Name', _packageInfo!.appName),
                      _buildInfoRow('Package', _packageInfo!.packageName),
                      _buildInfoRow('Version', _packageInfo!.version),
                      _buildInfoRow('Build Number', _packageInfo!.buildNumber),
                    ],
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Appearance Settings
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Appearance',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<AppState>(
                      builder: (context, appState, child) {
                        return SwitchListTile(
                          title: const Text('Dark Mode'),
                          subtitle: const Text('Use dark theme'),
                          value: appState.isDarkMode,
                          onChanged: (value) => appState.toggleTheme(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Build Configuration
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Build Configuration',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.build),
                      title: const Text('Build Type'),
                      subtitle: const Text('Release'),
                      trailing: const Chip(
                        label: Text('Release'),
                        backgroundColor: Colors.green,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.security),
                      title: const Text('Code Signing'),
                      subtitle: const Text('Signed'),
                      trailing: const Chip(
                        label: Text('Signed'),
                        backgroundColor: Colors.blue,
                        labelStyle: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Development Tools
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Development Tools',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ListTile(
                      leading: const Icon(Icons.bug_report),
                      title: const Text('Debug Mode'),
                      subtitle: const Text('Enable debug features'),
                      trailing: Switch(
                        value: false,
                        onChanged: (value) {
                          // Debug mode toggle
                        },
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.analytics),
                      title: const Text('Analytics'),
                      subtitle: const Text('Collect usage data'),
                      trailing: Switch(
                        value: true,
                        onChanged: (value) {
                          // Analytics toggle
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Actions',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Consumer<AppState>(
                      builder: (context, appState, child) {
                        return Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.update),
                              title: const Text('Simulate Update'),
                              subtitle: Text('Current: ${appState.currentVersion}+${appState.buildNumber}'),
                              onTap: () => _simulateUpdate(context, appState),
                            ),
                            ListTile(
                              leading: const Icon(Icons.refresh),
                              title: const Text('Reset App Data'),
                              subtitle: const Text('Clear all settings'),
                              onTap: () => _resetAppData(context, appState),
                            ),
                            ListTile(
                              leading: const Icon(Icons.info),
                              title: const Text('About'),
                              subtitle: const Text('App information and credits'),
                              onTap: () => _showAboutDialog(context),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Version History
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Version History',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildVersionItem('1.0.0', 'Initial release', '2024-01-01'),
                    _buildVersionItem('0.9.0', 'Beta testing', '2023-12-15'),
                    _buildVersionItem('0.8.0', 'Alpha testing', '2023-12-01'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersionItem(String version, String description, String date) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  version,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            date,
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: 12,
            ),
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

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Deployment Demo App',
      applicationVersion: _packageInfo?.version ?? '1.0.0',
      applicationIcon: const FlutterLogo(size: 64),
      children: [
        const Text(
          'This is a demonstration app for Flutter deployment and CI/CD practices. '
          'It showcases various deployment features and best practices.',
        ),
        const SizedBox(height: 16),
        const Text(
          'Features:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const Text('• Material 3 Design'),
        const Text('• Dark/Light Theme'),
        const Text('• Version Management'),
        const Text('• Build Configuration'),
        const Text('• CI/CD Integration'),
      ],
    );
  }
}
