import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../models/profile.dart';

/// Contact actions widget with email, phone, and website buttons
class ContactActions extends StatelessWidget {
  const ContactActions({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Email button
        _ContactButton(
          icon: Icons.email_outlined,
          label: 'Email',
          onPressed: () => _launchUrl('mailto:${profile.email}'),
          tooltip: 'Send email to ${profile.email}',
        ),
        
        // Phone button
        _ContactButton(
          icon: Icons.phone_outlined,
          label: 'Phone',
          onPressed: () => _launchUrl('tel:${profile.phone}'),
          tooltip: 'Call ${profile.phone}',
        ),
        
        // Website button
        _ContactButton(
          icon: Icons.language_outlined,
          label: 'Website',
          onPressed: () => _launchUrl(profile.website),
          tooltip: 'Visit ${profile.website}',
        ),
      ],
    );
  }

  /// Launches a URL using url_launcher package
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

/// Individual contact button with icon and label
class _ContactButton extends StatelessWidget {
  const _ContactButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.tooltip,
  });

  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon button
            IconButton(
              onPressed: onPressed,
              icon: Icon(icon),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.primaryContainer,
                foregroundColor: theme.colorScheme.onPrimaryContainer,
                padding: const EdgeInsets.all(12),
              ),
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              label,
              style: theme.textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
