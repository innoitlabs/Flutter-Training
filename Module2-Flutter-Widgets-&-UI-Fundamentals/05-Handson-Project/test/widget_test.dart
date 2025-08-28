import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_profile_app/app/app.dart';
import 'package:my_profile_app/features/profile/widgets/profile_header.dart';
import 'package:my_profile_app/features/profile/widgets/skill_chips.dart';
import 'package:my_profile_app/models/profile.dart';

void main() {
  group('MyProfileApp Widget Tests', () {
    testWidgets('App should render without crashing', (WidgetTester tester) async {
      await tester.pumpWidget(const MyProfileApp());
      
      // Verify the app title is displayed
      expect(find.text('My Profile'), findsOneWidget);
      
      // Verify the profile name is displayed
      expect(find.text('Sarah Johnson'), findsOneWidget);
      
      // Verify the profile title is displayed
      expect(find.text('Senior Flutter Developer'), findsOneWidget);
    });
  });

  group('ProfileHeader Widget Tests', () {
    testWidgets('ProfileHeader should display name and title', (WidgetTester tester) async {
      final profile = Profile.sample();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ProfileHeader(profile: profile),
          ),
        ),
      );
      
      // Verify name is displayed
      expect(find.text(profile.name), findsOneWidget);
      
      // Verify title is displayed
      expect(find.text(profile.title), findsOneWidget);
      
      // Verify location is displayed
      expect(find.text(profile.location), findsOneWidget);
    });
  });

  group('SkillChips Widget Tests', () {
    testWidgets('SkillChips should display correct number of skills', (WidgetTester tester) async {
      final profile = Profile.sample();
      
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkillChips(skills: profile.skills),
          ),
        ),
      );
      
      // Verify the number of skill chips matches the skills list length
      expect(find.byType(FilterChip), findsNWidgets(profile.skills.length));
      
      // Verify specific skills are displayed
      for (final skill in profile.skills) {
        expect(find.text(skill), findsOneWidget);
      }
    });
  });
}
