import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../models/profile.dart';
import '../../utils/breakpoints.dart';
import 'widgets/profile_header.dart';
import 'widgets/contact_actions.dart';
import 'widgets/skill_chips.dart';
import 'widgets/section_card.dart';

/// Main profile page with responsive layout
class ProfilePage extends StatelessWidget {
  const ProfilePage({
    super.key,
    required this.profile,
  });

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          final isCompact = Breakpoints.isCompact(width);
          
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: Breakpoints.getHorizontalPadding(width),
              vertical: 16,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: Breakpoints.getContentMaxWidth(width),
                ),
                child: isCompact ? _buildCompactLayout() : _buildWideLayout(),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Compact layout for mobile devices (single column)
  Widget _buildCompactLayout() {
    return Column(
      children: [
        // Profile header
        ProfileHeader(profile: profile),
        
        const SizedBox(height: 32),
        
        // Contact actions
        ContactActions(profile: profile),
        
        const SizedBox(height: 32),
        
        // About section
        SectionCard(
          title: 'About',
          child: Text(
            profile.bio,
            style: const TextStyle(height: 1.6),
          ),
        ),
        
        const SizedBox(height: 16),
        
        // Skills section
        SectionCard(
          title: 'Skills',
          child: SkillChips(skills: profile.skills),
        ),
        
        const SizedBox(height: 16),
        
        // Social links section
        SectionCard(
          title: 'Connect',
          child: _SocialLinks(socialLinks: profile.socialLinks),
        ),
      ],
    );
  }

  /// Wide layout for tablets and desktops (two columns)
  Widget _buildWideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left column: Header, About
        Expanded(
          flex: 1,
          child: Column(
            children: [
              ProfileHeader(profile: profile),
              
              const SizedBox(height: 32),
              
              ContactActions(profile: profile),
              
              const SizedBox(height: 32),
              
              SectionCard(
                title: 'About',
                child: Text(
                  profile.bio,
                  style: const TextStyle(height: 1.6),
                ),
              ),
            ],
          ),
        ),
        
        const SizedBox(width: 32),
        
        // Right column: Skills, Social
        Expanded(
          flex: 1,
          child: Column(
            children: [
              SectionCard(
                title: 'Skills',
                child: SkillChips(skills: profile.skills),
              ),
              
              const SizedBox(height: 16),
              
              SectionCard(
                title: 'Connect',
                child: _SocialLinks(socialLinks: profile.socialLinks),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Social links widget with platform icons
class _SocialLinks extends StatelessWidget {
  const _SocialLinks({
    required this.socialLinks,
  });

  final Map<String, String> socialLinks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: socialLinks.entries.map((entry) {
        return Semantics(
          button: true,
          label: 'Visit ${entry.key} profile',
          child: Tooltip(
            message: 'Visit ${entry.key}',
            child: IconButton(
              onPressed: () => _launchUrl(entry.value),
              icon: _getSocialIcon(entry.key),
              style: IconButton.styleFrom(
                backgroundColor: theme.colorScheme.tertiaryContainer,
                foregroundColor: theme.colorScheme.onTertiaryContainer,
                padding: const EdgeInsets.all(12),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  /// Returns appropriate icon for social platform
  Icon _getSocialIcon(String platform) {
    switch (platform.toLowerCase()) {
      case 'github':
        return const Icon(Icons.code);
      case 'linkedin':
        return const Icon(Icons.work);
      case 'twitter':
        return const Icon(Icons.flutter_dash);
      case 'medium':
        return const Icon(Icons.article);
      default:
        return const Icon(Icons.link);
    }
  }

  /// Launches social media URL
  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
