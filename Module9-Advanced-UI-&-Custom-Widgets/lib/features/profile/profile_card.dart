import 'package:flutter/material.dart';

/// Custom ProfileCard widget demonstrating widget composition and reusability
/// Shows how to create reusable widgets with clean APIs
class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.onEdit,
    this.onDelete,
    this.onView,
    this.showActions = true,
  });

  final String name;
  final String email;
  final String avatarUrl;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onView;
  final bool showActions;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Avatar and basic info section
            _ProfileHeader(
              name: name,
              email: email,
              avatarUrl: avatarUrl,
            ),
            if (showActions) ...[
              const SizedBox(height: 16),
              // Action buttons section
              _ProfileActions(
                onEdit: onEdit,
                onDelete: onDelete,
                onView: onView,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Profile header widget - demonstrates composition
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  final String name;
  final String email;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar widget
        _ProfileAvatar(avatarUrl: avatarUrl),
        const SizedBox(width: 16),
        // User info widget
        Expanded(
          child: _ProfileInfo(
            name: name,
            email: email,
          ),
        ),
      ],
    );
  }
}

/// Profile avatar widget - demonstrates small, focused widgets
class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.avatarUrl});

  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 30,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: avatarUrl.isNotEmpty
          ? ClipOval(
              child: Image.network(
                avatarUrl,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return _DefaultAvatar();
                },
              ),
            )
          : const _DefaultAvatar(),
    );
  }
}

/// Default avatar when image fails to load
class _DefaultAvatar extends StatelessWidget {
  const _DefaultAvatar();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.person,
      size: 40,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
    );
  }
}

/// Profile info widget - demonstrates text layout
class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo({
    required this.name,
    required this.email,
  });

  final String name;
  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

/// Profile actions widget - demonstrates button layout
class _ProfileActions extends StatelessWidget {
  const _ProfileActions({
    this.onEdit,
    this.onDelete,
    this.onView,
  });

  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onView;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (onView != null)
          _ActionButton(
            icon: Icons.visibility,
            label: 'View',
            onPressed: onView,
            color: Theme.of(context).colorScheme.primary,
          ),
        if (onEdit != null)
          _ActionButton(
            icon: Icons.edit,
            label: 'Edit',
            onPressed: onEdit,
            color: Theme.of(context).colorScheme.secondary,
          ),
        if (onDelete != null)
          _ActionButton(
            icon: Icons.delete,
            label: 'Delete',
            onPressed: onDelete,
            color: Theme.of(context).colorScheme.error,
          ),
      ],
    );
  }
}

/// Reusable action button widget
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onPressed,
    required this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback? onPressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilledButton.icon(
          onPressed: onPressed,
          icon: Icon(icon, size: 18),
          label: Text(label),
          style: FilledButton.styleFrom(
            backgroundColor: color,
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }
}

/// Demo page showcasing ProfileCard usage
class ProfileCardDemo extends StatelessWidget {
  const ProfileCardDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Widgets - ProfileCard'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ProfileCard Widget Demo',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This demonstrates a reusable ProfileCard widget with composition, clean API, and Material 3 styling.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            // ProfileCard with actions
            ProfileCard(
              name: 'John Doe',
              email: 'john.doe@example.com',
              avatarUrl: 'https://via.placeholder.com/150',
              onEdit: () => _showSnackBar(context, 'Edit pressed'),
              onDelete: () => _showSnackBar(context, 'Delete pressed'),
              onView: () => _showSnackBar(context, 'View pressed'),
            ),
            const SizedBox(height: 16),
            // ProfileCard without actions
            ProfileCard(
              name: 'Jane Smith',
              email: 'jane.smith@example.com',
              avatarUrl: '',
              showActions: false,
            ),
            const SizedBox(height: 16),
            // ProfileCard with partial actions
            ProfileCard(
              name: 'Bob Wilson',
              email: 'bob.wilson@example.com',
              avatarUrl: 'https://via.placeholder.com/150',
              onEdit: () => _showSnackBar(context, 'Edit pressed'),
              onView: () => _showSnackBar(context, 'View pressed'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
