import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme/theme_provider.dart';

class ThemeSwitcher extends StatelessWidget {
  const ThemeSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return PopupMenuButton<ThemeMode>(
          icon: Icon(
            themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          tooltip: 'Change theme',
          onSelected: (ThemeMode mode) {
            themeProvider.setThemeMode(mode);
          },
          itemBuilder: (BuildContext context) => [
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.light,
              child: Row(
                children: [
                  Icon(
                    Icons.light_mode,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text('Light'),
                  const Spacer(),
                  if (themeProvider.themeMode == ThemeMode.light)
                    Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ),
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.dark,
              child: Row(
                children: [
                  Icon(
                    Icons.dark_mode,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text('Dark'),
                  const Spacer(),
                  if (themeProvider.themeMode == ThemeMode.dark)
                    Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ),
            PopupMenuItem<ThemeMode>(
              value: ThemeMode.system,
              child: Row(
                children: [
                  Icon(
                    Icons.settings_system_daydream,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text('System'),
                  const Spacer(),
                  if (themeProvider.themeMode == ThemeMode.system)
                    Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class ThemeSwitcherCard extends StatelessWidget {
  const ThemeSwitcherCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.palette,
                      color: theme.colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Theme Settings',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Current Theme: ${themeProvider.themeModeName}',
                                     style: theme.textTheme.bodyMedium?.copyWith(
                     color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                   ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _ThemeOptionButton(
                        title: 'Light',
                        icon: Icons.light_mode,
                        isSelected: themeProvider.themeMode == ThemeMode.light,
                        onTap: () => themeProvider.setThemeMode(ThemeMode.light),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ThemeOptionButton(
                        title: 'Dark',
                        icon: Icons.dark_mode,
                        isSelected: themeProvider.themeMode == ThemeMode.dark,
                        onTap: () => themeProvider.setThemeMode(ThemeMode.dark),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _ThemeOptionButton(
                        title: 'System',
                        icon: Icons.settings_system_daydream,
                        isSelected: themeProvider.themeMode == ThemeMode.system,
                        onTap: () => themeProvider.setThemeMode(ThemeMode.system),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => themeProvider.cycleTheme(),
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Cycle Theme'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ThemeOptionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOptionButton({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
                     color: isSelected 
               ? theme.colorScheme.primary.withValues(alpha: 0.1)
               : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
                         color: isSelected 
                 ? theme.colorScheme.primary
                 : theme.colorScheme.outline.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected 
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface.withValues(alpha: 0.7),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected 
                    ? theme.colorScheme.primary
                    : theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
