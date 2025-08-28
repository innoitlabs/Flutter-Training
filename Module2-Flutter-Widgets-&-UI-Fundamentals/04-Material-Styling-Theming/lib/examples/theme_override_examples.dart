import 'package:flutter/material.dart';

class ThemeOverrideExamples extends StatelessWidget {
  const ThemeOverrideExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Theme Override Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildThemeAccessSection(context),
            const SizedBox(height: 32),
            _buildLocalThemeOverrideSection(context),
            const SizedBox(height: 32),
            _buildCopyWithSection(context),
            const SizedBox(height: 32),
            _buildConditionalThemingSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeAccessSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Accessing Theme Properties',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Using theme colors
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'Using theme.primaryColor',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onPrimary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        
        // Using theme text styles
        Text(
          'This uses theme.textTheme.headlineSmall',
          style: theme.textTheme.headlineSmall,
        ),
        const SizedBox(height: 8),
        
        Text(
          'This uses theme.textTheme.bodyMedium',
          style: theme.textTheme.bodyMedium,
        ),
        const SizedBox(height: 12),
        
        // Using theme for buttons
        ElevatedButton(
          onPressed: () {},
          child: const Text('Theme-based Button'),
        ),
        const SizedBox(height: 8),
        
        OutlinedButton(
          onPressed: () {},
          child: const Text('Theme-based Outlined Button'),
        ),
      ],
    );
  }

  Widget _buildLocalThemeOverrideSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Local Theme Override',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Override theme for specific widget
        Theme(
          data: Theme.of(context).copyWith(
            textTheme: Theme.of(context).textTheme.copyWith(
              bodyLarge: TextStyle(
                fontSize: 18,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          child: const Text('This text uses overridden theme'),
        ),
        const SizedBox(height: 16),
        
        // Override button theme
        Theme(
          data: Theme.of(context).copyWith(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('Overridden Button Style'),
          ),
        ),
        const SizedBox(height: 16),
        
        // Override card theme
        Theme(
          data: Theme.of(context).copyWith(
            cardTheme: CardTheme(
              color: Colors.orange[100],
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
          child: Card(
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Card with overridden theme'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCopyWithSection(BuildContext context) {
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Using copyWith() Method',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Text style with copyWith
        Text(
          'Original text style',
          style: theme.textTheme.bodyLarge,
        ),
        const SizedBox(height: 8),
        
        Text(
          'Modified with copyWith - larger and red',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: 20,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        
        Text(
          'Modified with copyWith - italic and blue',
          style: theme.textTheme.bodyLarge?.copyWith(
            fontStyle: FontStyle.italic,
            color: Colors.blue,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 16),
        
        // Button style with copyWith
        ElevatedButton(
          onPressed: () {},
          style: theme.elevatedButtonTheme.style?.copyWith(
            backgroundColor: WidgetStateProperty.all(Colors.purple),
            foregroundColor: WidgetStateProperty.all(Colors.white),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            ),
          ),
          child: const Text('Button with copyWith style'),
        ),
        const SizedBox(height: 16),
        
        // Container with theme colors and copyWith
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          child: Text(
            'Container using theme colors',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildConditionalThemingSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conditional Theming',
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        
        // Conditional text styling
        Text(
          'This text adapts to theme',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: isDark ? Colors.yellow : Colors.blue,
            fontWeight: isDark ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        const SizedBox(height: 16),
        
        // Conditional container styling
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? Colors.grey[800] : Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? Colors.white : Colors.black,
              width: 1,
            ),
          ),
          child: Text(
            'Container adapts to light/dark theme',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? Colors.white : Colors.black,
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Conditional button styling
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.orange : Colors.green,
            foregroundColor: isDark ? Colors.black : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(isDark ? 20 : 8),
            ),
          ),
          child: Text(
            isDark ? 'Dark Theme Button' : 'Light Theme Button',
          ),
        ),
        const SizedBox(height: 16),
        
        // Theme-aware icon
        Icon(
          isDark ? Icons.dark_mode : Icons.light_mode,
          size: 48,
          color: isDark ? Colors.yellow : Colors.orange,
        ),
        const SizedBox(height: 8),
        
        Text(
          isDark ? 'Dark Mode Active' : 'Light Mode Active',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark ? Colors.yellow : Colors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
