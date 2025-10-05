import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/custom_button.dart';
import '../widgets/loading_overlay.dart';
import 'login_screen.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return LoadingOverlay(
            isLoading: authProvider.isLoading,
            loadingText: _getLoadingText(authProvider),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Section
                  _buildProfileSection(authProvider),
                  
                  SizedBox(height: 24),
                  
                  // Account Section
                  _buildAccountSection(context, authProvider),
                  
                  SizedBox(height: 24),
                  
                  // Security Section
                  _buildSecuritySection(context, authProvider),
                  
                  SizedBox(height: 24),
                  
                  // Danger Zone
                  _buildDangerZone(context, authProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getLoadingText(AuthProvider authProvider) {
    if (authProvider.isSigningOut) {
      return 'Signing you out...';
    } else if (authProvider.isLoading) {
      return 'Loading...';
    }
    return 'Loading...';
  }

  Widget _buildProfileSection(AuthProvider authProvider) {
    if (authProvider.user == null) return SizedBox.shrink();

    final user = authProvider.user!;

    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          // User Avatar
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: user.photoURL != null 
                  ? NetworkImage(user.photoURL!)
                  : null,
              child: user.photoURL == null 
                  ? Text(
                      user.initials,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    )
                  : null,
              backgroundColor: Colors.blue[600],
            ),
          ),
          
          SizedBox(height: 16),
          
          // User Info
          _buildInfoRow('Name', user.displayNameOrEmail),
          _buildInfoRow('Email', user.email ?? 'Not provided'),
          _buildInfoRow('User ID', user.uid),
          _buildInfoRow('Sign-in Method', 
            user.photoURL != null && user.photoURL!.contains('googleusercontent.com')
                ? 'Google'
                : 'Email/Password'
          ),
          _buildInfoRow('Email Verified', user.isEmailVerified ? 'Yes' : 'No'),
          _buildInfoRow('Account Created', 
            user.creationTime != null 
                ? _formatDate(user.creationTime!)
                : 'Unknown'
          ),
        ],
      ),
    );
  }

  Widget _buildAccountSection(BuildContext context, AuthProvider authProvider) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildActionTile(
            icon: Icons.edit,
            title: 'Update Profile',
            subtitle: 'Change your name and photo',
            onTap: () => _showUpdateProfileDialog(context, authProvider),
          ),
          
          _buildActionTile(
            icon: Icons.lock,
            title: 'Change Password',
            subtitle: 'Update your password',
            onTap: () => _showChangePasswordDialog(context, authProvider),
          ),
          
          _buildActionTile(
            icon: Icons.email,
            title: 'Email Settings',
            subtitle: 'Manage email notifications',
            onTap: () => _showEmailSettingsDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSecuritySection(BuildContext context, AuthProvider authProvider) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Security',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildActionTile(
            icon: Icons.security,
            title: 'Two-Factor Authentication',
            subtitle: 'Add an extra layer of security',
            onTap: () => _showTwoFactorDialog(context),
          ),
          
          _buildActionTile(
            icon: Icons.history,
            title: 'Login History',
            subtitle: 'View recent login activity',
            onTap: () => _showLoginHistoryDialog(context),
          ),
          
          _buildActionTile(
            icon: Icons.devices,
            title: 'Connected Devices',
            subtitle: 'Manage your devices',
            onTap: () => _showDevicesDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDangerZone(BuildContext context, AuthProvider authProvider) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Danger Zone',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red[800],
            ),
          ),
          
          SizedBox(height: 16),
          
          _buildActionTile(
            icon: Icons.logout,
            title: 'Sign Out',
            subtitle: 'Sign out of your account',
            onTap: () => _showLogoutDialog(context, authProvider),
            isDestructive: true,
          ),
          
          _buildActionTile(
            icon: Icons.delete_forever,
            title: 'Delete Account',
            subtitle: 'Permanently delete your account',
            onTap: () => _showDeleteAccountDialog(context, authProvider),
            isDestructive: true,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDestructive ? Colors.red[50] : Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDestructive ? Colors.red[200]! : Colors.grey[200]!,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDestructive ? Colors.red[100] : Colors.blue[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: isDestructive ? Colors.red[600] : Colors.blue[600],
                size: 20,
              ),
            ),
            
            SizedBox(width: 16),
            
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: isDestructive ? Colors.red[800] : Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: isDestructive ? Colors.red[600] : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: isDestructive ? Colors.red[400] : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showLogoutDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign Out'),
          content: Text('Are you sure you want to sign out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await authProvider.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Sign Out'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteAccountDialog(BuildContext context, AuthProvider authProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Account'),
          content: Text(
            'This action cannot be undone. All your data will be permanently deleted.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                // TODO: Implement account deletion
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Account deletion feature coming soon!')),
                );
              },
              child: Text('Delete Account'),
            ),
          ],
        );
      },
    );
  }

  void _showUpdateProfileDialog(BuildContext context, AuthProvider authProvider) {
    // TODO: Implement profile update dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Profile update feature coming soon!')),
    );
  }

  void _showChangePasswordDialog(BuildContext context, AuthProvider authProvider) {
    // TODO: Implement password change dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Password change feature coming soon!')),
    );
  }

  void _showEmailSettingsDialog(BuildContext context) {
    // TODO: Implement email settings dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Email settings feature coming soon!')),
    );
  }

  void _showTwoFactorDialog(BuildContext context) {
    // TODO: Implement two-factor authentication dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Two-factor authentication coming soon!')),
    );
  }

  void _showLoginHistoryDialog(BuildContext context) {
    // TODO: Implement login history dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login history feature coming soon!')),
    );
  }

  void _showDevicesDialog(BuildContext context) {
    // TODO: Implement connected devices dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Device management coming soon!')),
    );
  }
}
