import 'package:flutter/material.dart';
import '../../../models/profile.dart';

/// Profile header widget with avatar, name, title, and location
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      children: [
        // Avatar with status badge
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            // Main avatar
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(profile.avatarPath),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
            // Status badge (online indicator)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colorScheme.surface,
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.circle,
                size: 12,
                color: Colors.white,
              ),
            ),
          ],
        ),
        
        const SizedBox(height: 24),
        
        // Name
        Text(
          profile.name,
          style: theme.textTheme.displayMedium,
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 8),
        
        // Title
        Text(
          profile.title,
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
          textAlign: TextAlign.center,
        ),
        
        const SizedBox(height: 16),
        
        // Location
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 16,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(width: 4),
            Text(
              profile.location,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
