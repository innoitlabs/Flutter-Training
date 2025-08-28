import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DeploymentInfoScreen extends StatelessWidget {
  const DeploymentInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deployment Info'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Build Commands Section
            _buildSection(
              context,
              'Build Commands',
              Icons.build,
              [
                _buildInfoCard(
                  'Android APK',
                  'flutter build apk --release',
                  'Builds a signed APK for Android',
                  Colors.green,
                ),
                _buildInfoCard(
                  'Android App Bundle',
                  'flutter build appbundle --release',
                  'Builds an AAB for Play Store',
                  Colors.green,
                ),
                _buildInfoCard(
                  'iOS IPA',
                  'flutter build ipa --release',
                  'Builds a signed IPA for iOS',
                  Colors.blue,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Code Signing Section
            _buildSection(
              context,
              'Code Signing',
              Icons.security,
              [
                _buildInfoCard(
                  'Android Keystore',
                  'keytool -genkey -v -keystore ~/my-release-key.jks',
                  'Generate signing keystore',
                  Colors.orange,
                ),
                _buildInfoCard(
                  'iOS Certificates',
                  'Xcode → Signing & Capabilities',
                  'Manage certificates and profiles',
                  Colors.blue,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // CI/CD Section
            _buildSection(
              context,
              'CI/CD Pipeline',
              Icons.rocket_launch,
              [
                _buildInfoCard(
                  'GitHub Actions',
                  '.github/workflows/flutter.yml',
                  'Automated build and test',
                  Colors.purple,
                ),
                _buildInfoCard(
                  'Fastlane',
                  'fastlane init',
                  'Automated deployment',
                  Colors.indigo,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Store Deployment Section
            _buildSection(
              context,
              'Store Deployment',
              Icons.store,
              [
                _buildInfoCard(
                  'Google Play Store',
                  'Upload AAB via Play Console',
                  'Internal → Beta → Production',
                  Colors.green,
                ),
                _buildInfoCard(
                  'Apple App Store',
                  'Upload IPA via Transporter',
                  'TestFlight → App Store',
                  Colors.blue,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Best Practices Section
            _buildSection(
              context,
              'Best Practices',
              Icons.star,
              [
                _buildInfoCard(
                  'Version Management',
                  'Update pubspec.yaml version',
                  'Follow semantic versioning',
                  Colors.amber,
                ),
                _buildInfoCard(
                  'Testing',
                  'flutter test && flutter drive',
                  'Unit, widget, and integration tests',
                  Colors.teal,
                ),
                _buildInfoCard(
                  'Security',
                  'Store secrets in CI/CD',
                  'Never commit keys to VCS',
                  Colors.red,
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Quick Actions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.play_arrow, color: theme.colorScheme.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Quick Actions',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ActionChip(
                          avatar: const Icon(Icons.copy, size: 16),
                          label: const Text('Copy Build Command'),
                          onPressed: () => _copyToClipboard(context, 'flutter build appbundle --release'),
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.copy, size: 16),
                          label: const Text('Copy Test Command'),
                          onPressed: () => _copyToClipboard(context, 'flutter test'),
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.copy, size: 16),
                          label: const Text('Copy Clean Command'),
                          onPressed: () => _copyToClipboard(context, 'flutter clean && flutter pub get'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildInfoCard(
    String title,
    String command,
    String description,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Text(
                command,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied: $text'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
