import 'package:flutter/material.dart';

/// Skill chips widget with responsive wrap layout
class SkillChips extends StatelessWidget {
  const SkillChips({
    super.key,
    required this.skills,
  });

  final List<String> skills;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8, // Horizontal spacing between chips
      runSpacing: 8, // Vertical spacing between rows
      children: skills.map((skill) => _SkillChip(skill: skill)).toList(),
    );
  }
}

/// Individual skill chip widget
class _SkillChip extends StatelessWidget {
  const _SkillChip({
    required this.skill,
  });

  final String skill;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Semantics(
      label: 'Skill: $skill',
      child: FilterChip(
        label: Text(skill),
        selected: false,
        onSelected: (_) {}, // No selection behavior for display-only chips
        backgroundColor: theme.colorScheme.secondaryContainer,
        selectedColor: theme.colorScheme.primaryContainer,
        labelStyle: theme.textTheme.labelMedium?.copyWith(
          color: theme.colorScheme.onSecondaryContainer,
        ),
        // Custom styling for better visual appeal
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
          width: 1,
        ),
        elevation: 0,
        pressElevation: 2,
        // Ensure adequate touch target size
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
