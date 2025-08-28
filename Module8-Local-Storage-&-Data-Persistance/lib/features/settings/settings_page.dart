import 'package:flutter/material.dart';
import 'settings_service.dart';

/// Settings page that displays and manages user preferences
/// Uses SharedPreferences for persistence with caching
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final SettingsService _settingsService = SettingsService();
  final TextEditingController _usernameController = TextEditingController();

  // State variables
  bool _isDarkMode = false;
  bool _notificationsEnabled = true;
  bool _autoSaveEnabled = true;
  int _launchCount = 0;
  DateTime? _lastLaunchDate;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  /// Load all settings from SharedPreferences
  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Load all settings in parallel
      final results = await Future.wait([
        _settingsService.getUsername(),
        _settingsService.getIsDarkMode(),
        _settingsService.getNotificationsEnabled(),
        _settingsService.getAutoSaveEnabled(),
        _settingsService.getLaunchCount(),
        _settingsService.getLastLaunchDate(),
      ]);

      // Check if all results are successful
      if (results.every((result) => result.isSuccess)) {
        setState(() {
          _usernameController.text = results[0].data! as String;
          _isDarkMode = results[1].data! as bool;
          _notificationsEnabled = results[2].data! as bool;
          _autoSaveEnabled = results[3].data! as bool;
          _launchCount = results[4].data! as int;
          _lastLaunchDate = results[5].data as DateTime?;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to load some settings';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load settings: $e';
        _isLoading = false;
      });
    }
  }

  /// Save username setting
  Future<void> _saveUsername(String username) async {
    final result = await _settingsService.setUsername(username);
    if (result.isSuccess) {
      _showSnackBar('Username saved successfully');
    } else {
      _showSnackBar('Failed to save username: ${result.errorMessage}');
    }
  }

  /// Toggle dark mode setting
  Future<void> _toggleDarkMode(bool value) async {
    final result = await _settingsService.setIsDarkMode(value);
    if (result.isSuccess) {
      setState(() {
        _isDarkMode = value;
      });
      _showSnackBar('Theme updated successfully');
    } else {
      _showSnackBar('Failed to update theme: ${result.errorMessage}');
    }
  }

  /// Toggle notifications setting
  Future<void> _toggleNotifications(bool value) async {
    final result = await _settingsService.setNotificationsEnabled(value);
    if (result.isSuccess) {
      setState(() {
        _notificationsEnabled = value;
      });
      _showSnackBar('Notifications setting updated');
    } else {
      _showSnackBar('Failed to update notifications: ${result.errorMessage}');
    }
  }

  /// Toggle auto save setting
  Future<void> _toggleAutoSave(bool value) async {
    final result = await _settingsService.setAutoSaveEnabled(value);
    if (result.isSuccess) {
      setState(() {
        _autoSaveEnabled = value;
      });
      _showSnackBar('Auto save setting updated');
    } else {
      _showSnackBar('Failed to update auto save: ${result.errorMessage}');
    }
  }

  /// Reset all settings to defaults
  Future<void> _resetToDefaults() async {
    final confirmed = await _showConfirmDialog(
      'Reset Settings',
      'Are you sure you want to reset all settings to defaults? This action cannot be undone.',
    );

    if (confirmed) {
      final result = await _settingsService.resetToDefaults();
      if (result.isSuccess) {
        _showSnackBar('Settings reset to defaults');
        _loadSettings(); // Reload settings
      } else {
        _showSnackBar('Failed to reset settings: ${result.errorMessage}');
      }
    }
  }

  /// Show a confirmation dialog
  Future<bool> _showConfirmDialog(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Reset'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  /// Show a snackbar with message
  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        actions: [
          IconButton(
            onPressed: _loadSettings,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh settings',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? _buildErrorView()
              : _buildSettingsContent(),
    );
  }

  /// Build error view when settings fail to load
  Widget _buildErrorView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            size: 64,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          Text(
            'Failed to load settings',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            _errorMessage!,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _loadSettings,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Build the main settings content
  Widget _buildSettingsContent() {
    return RefreshIndicator(
      onRefresh: _loadSettings,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // User Information Section
          _buildSection(
            title: 'User Information',
            icon: Icons.person,
            children: [
              _buildTextField(
                label: 'Username',
                controller: _usernameController,
                onChanged: _saveUsername,
                icon: Icons.edit,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // App Settings Section
          _buildSection(
            title: 'App Settings',
            icon: Icons.settings,
            children: [
              _buildSwitchTile(
                title: 'Dark Mode',
                subtitle: 'Use dark theme for the app',
                value: _isDarkMode,
                onChanged: _toggleDarkMode,
                icon: Icons.dark_mode,
              ),
              _buildSwitchTile(
                title: 'Notifications',
                subtitle: 'Enable push notifications',
                value: _notificationsEnabled,
                onChanged: _toggleNotifications,
                icon: Icons.notifications,
              ),
              _buildSwitchTile(
                title: 'Auto Save',
                subtitle: 'Automatically save changes',
                value: _autoSaveEnabled,
                onChanged: _toggleAutoSave,
                icon: Icons.save,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // App Statistics Section
          _buildSection(
            title: 'App Statistics',
            icon: Icons.analytics,
            children: [
              _buildInfoTile(
                title: 'Launch Count',
                subtitle: 'Number of times app has been opened',
                value: _launchCount.toString(),
                icon: Icons.launch,
              ),
              _buildInfoTile(
                title: 'Last Launch',
                subtitle: 'When you last opened the app',
                value: _lastLaunchDate != null
                    ? _formatDate(_lastLaunchDate!)
                    : 'Never',
                icon: Icons.access_time,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Actions Section
          _buildSection(
            title: 'Actions',
            icon: Icons.build,
            children: [
              ListTile(
                leading: const Icon(Icons.refresh),
                title: const Text('Reset to Defaults'),
                subtitle: const Text('Reset all settings to default values'),
                onTap: _resetToDefaults,
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Build a settings section with title and icon
  Widget _buildSection({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  /// Build a text field for settings
  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required Function(String) onChanged,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          suffixIcon: const Icon(Icons.check_circle, color: Colors.green),
        ),
        onChanged: onChanged,
      ),
    );
  }

  /// Build a switch tile for boolean settings
  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
  }) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: onChanged,
      secondary: Icon(icon),
    );
  }

  /// Build an info tile for read-only settings
  Widget _buildInfoTile({
    required String title,
    required String subtitle,
    required String value,
    required IconData icon,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: Text(
        value,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  /// Format date for display
  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today at ${_formatTime(date)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${_formatTime(date)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  /// Format time for display
  String _formatTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }
}
