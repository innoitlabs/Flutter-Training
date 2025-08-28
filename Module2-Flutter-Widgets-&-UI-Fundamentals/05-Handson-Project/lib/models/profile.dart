/// Immutable model representing a user profile
class Profile {
  const Profile({
    required this.name,
    required this.title,
    required this.location,
    required this.bio,
    required this.email,
    required this.phone,
    required this.website,
    required this.skills,
    required this.socialLinks,
    this.avatarPath = 'assets/avatar.png',
  });

  final String name;
  final String title;
  final String location;
  final String bio;
  final String email;
  final String phone;
  final String website;
  final List<String> skills;
  final Map<String, String> socialLinks; // platform -> url
  final String avatarPath;

  /// Creates a sample profile for demonstration
  factory Profile.sample() {
    return const Profile(
      name: 'Sarah Johnson',
      title: 'Senior Flutter Developer',
      location: 'San Francisco, CA',
      bio: 'Passionate Flutter developer with 5+ years of experience building '
          'beautiful, responsive mobile applications. I love creating intuitive '
          'user experiences and staying up-to-date with the latest Flutter '
          'technologies and best practices.',
      email: 'sarah.johnson@example.com',
      phone: '+1 (555) 123-4567',
      website: 'https://sarahjohnson.dev',
      skills: [
        'Flutter',
        'Dart',
        'Firebase',
        'REST APIs',
        'State Management',
        'UI/UX Design',
        'Git',
        'Agile',
        'Testing',
        'Performance Optimization',
      ],
      socialLinks: {
        'GitHub': 'https://github.com/sarahjohnson',
        'LinkedIn': 'https://linkedin.com/in/sarahjohnson',
        'Twitter': 'https://twitter.com/sarahjohnson',
        'Medium': 'https://medium.com/@sarahjohnson',
      },
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Profile &&
        other.name == name &&
        other.title == title &&
        other.location == location &&
        other.bio == bio &&
        other.email == email &&
        other.phone == phone &&
        other.website == website &&
        other.avatarPath == avatarPath;
  }

  @override
  int get hashCode {
    return Object.hash(
      name,
      title,
      location,
      bio,
      email,
      phone,
      website,
      avatarPath,
    );
  }
}
