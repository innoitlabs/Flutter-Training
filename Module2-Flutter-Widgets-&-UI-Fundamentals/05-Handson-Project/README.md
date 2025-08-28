# My Profile App - Flutter Personal Profile Application

A comprehensive Flutter project demonstrating Material 3 design, responsive layouts, and modern Flutter development patterns. This app showcases a personal profile page with avatar, contact information, skills, and social links.

## 🎯 Learning Goals

- **Build responsive layouts** using LayoutBuilder and breakpoints
- **Implement Material 3 design** with proper theming and color schemes
- **Create reusable widgets** with shallow widget trees
- **Apply accessibility best practices** with semantics and tooltips
- **Use modern Dart 3.6.1 syntax** with null safety and const constructors
- **Structure code properly** with feature-based organization

## 🚀 Features

- **Responsive Design**: Adapts from single-column (mobile) to two-column (tablet/desktop)
- **Material 3 Theming**: Light and dark themes with ColorScheme.fromSeed
- **Interactive Elements**: Contact buttons with url_launcher integration
- **Accessibility**: Semantic labels, tooltips, and proper contrast
- **Clean Architecture**: Separated models, widgets, and utilities

## 📱 Screenshots

### Mobile Layout (Compact)
- Single column layout with centered avatar
- Stacked sections: Header → Contact → About → Skills → Social
- Optimized touch targets and spacing

### Tablet/Desktop Layout (Wide)
- Two-column responsive layout
- Left column: Profile header, contact actions, about section
- Right column: Skills and social links
- Generous gutters and improved content width

## 🛠️ Technical Implementation

### Widget Architecture

```
ProfilePage (Main container)
├── LayoutBuilder (Responsive logic)
├── ProfileHeader (Avatar, name, title, location)
├── ContactActions (Email, phone, website buttons)
├── SectionCard (Reusable container)
│   ├── About section
│   ├── Skills section (SkillChips with Wrap)
│   └── Social links section
```

### Key Design Decisions

1. **LayoutBuilder for Responsiveness**: 
   - Uses constraints.maxWidth to determine layout
   - Breakpoints utility provides consistent sizing logic
   - Conditional rendering between compact and wide layouts

2. **Wrap Widget for Skills**:
   - Automatically wraps skills to new lines
   - Maintains consistent spacing with spacing/runSpacing
   - Responsive to different screen widths

3. **SectionCard for Consistency**:
   - Reusable container with consistent styling
   - Reduces widget tree depth through composition
   - Maintains Material 3 elevation and surface colors

4. **Material 3 Theming**:
   - ColorScheme.fromSeed generates harmonious colors
   - Proper contrast ratios for accessibility
   - Consistent typography scale

## 📦 Dependencies

- **url_launcher**: For opening email, phone, and website links
- **flutter_lints**: For code quality and consistency

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   ├── app.dart             # MaterialApp configuration
│   └── theme.dart           # Material 3 theme setup
├── features/profile/
│   ├── profile_page.dart    # Main profile page
│   └── widgets/
│       ├── profile_header.dart
│       ├── contact_actions.dart
│       ├── skill_chips.dart
│       └── section_card.dart
├── models/
│   └── profile.dart         # Immutable profile model
└── utils/
    └── breakpoints.dart     # Responsive design helpers
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK 3.24.0 or higher
- Dart 3.6.1 or higher
- Android Studio / VS Code with Flutter extensions

### Installation

1. **Clone or download the project**
   ```bash
   cd my_profile_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

4. **Run tests**
   ```bash
   flutter test
   ```

5. **Analyze code**
   ```bash
   flutter analyze
   ```

## 🎨 Customization

### Adding Your Profile

Edit `lib/models/profile.dart` and update the `Profile.sample()` factory:

```dart
factory Profile.sample() {
  return const Profile(
    name: 'Your Name',
    title: 'Your Title',
    location: 'Your Location',
    bio: 'Your bio...',
    email: 'your.email@example.com',
    phone: '+1 (555) 123-4567',
    website: 'https://yourwebsite.com',
    skills: ['Flutter', 'Dart', 'Your Skills...'],
    socialLinks: {
      'GitHub': 'https://github.com/yourusername',
      'LinkedIn': 'https://linkedin.com/in/yourusername',
    },
  );
}
```

### Customizing Theme

Modify `lib/app/theme.dart` to change colors, typography, or add custom themes:

```dart
static const Color _seedColor = Color(0xFF6750A4); // Change this color
```

### Adding New Sections

1. Create a new widget in `lib/features/profile/widgets/`
2. Use `SectionCard` for consistent styling
3. Add to the appropriate layout method in `ProfilePage`

## 🧪 Testing

The project includes comprehensive widget tests:

- **App rendering test**: Verifies the app starts without errors
- **Profile header test**: Confirms name, title, and location display
- **Skill chips test**: Validates correct number of skills are rendered

Run tests with:
```bash
flutter test
```

## 📚 Teaching Notes

### Material 3 Concepts

1. **ColorScheme.fromSeed**: Generates a complete color palette from a single seed color
2. **Surface Colors**: Different elevation levels for cards and components
3. **Typography Scale**: Consistent text styles across the app
4. **Component Theming**: Customizable button, card, and chip styles

### Responsive Design Patterns

1. **Breakpoints**: Define screen size categories (small, medium, large)
2. **LayoutBuilder**: Access constraints to make layout decisions
3. **Conditional Rendering**: Switch between different layouts based on screen size
4. **Flexible Sizing**: Use Expanded, Flexible, and constraints for adaptive layouts

### Accessibility Best Practices

1. **Semantic Labels**: Provide meaningful descriptions for screen readers
2. **Tooltips**: Help users understand button functions
3. **Adequate Touch Targets**: Minimum 48x48dp for interactive elements
4. **Color Contrast**: Ensure text is readable in both light and dark themes

### Code Organization Principles

1. **Feature-based Structure**: Group related files by feature
2. **Widget Composition**: Break large widgets into smaller, reusable components
3. **Separation of Concerns**: Keep models, UI, and utilities separate
4. **Const Constructors**: Use const where possible for better performance

## 🔧 Extension Ideas

### Advanced Features

1. **Theme Toggle**: Add a switch to manually toggle between light/dark themes
2. **Localization**: Support multiple languages using flutter_localizations
3. **Dynamic Data**: Load profile data from API or local storage
4. **Image Picker**: Allow users to upload their own avatar
5. **Edit Mode**: Add ability to edit profile information
6. **Animations**: Add smooth transitions between layouts

### Technical Enhancements

1. **State Management**: Implement Riverpod or Bloc for complex state
2. **Navigation**: Add multiple screens (Settings, About, Edit Profile)
3. **Persistence**: Save theme preferences and profile data locally
4. **Analytics**: Track user interactions and app usage
5. **Performance**: Implement lazy loading for large skill lists

## 🐛 Troubleshooting

### Common Issues

1. **Avatar not displaying**: Ensure `assets/avatar.png` exists and is properly configured in `pubspec.yaml`
2. **URL launcher not working**: Check device permissions and internet connectivity
3. **Layout issues**: Verify breakpoint values match your target devices
4. **Theme not applying**: Ensure `useMaterial3: true` is set in ThemeData

### Debug Commands

```bash
# Check Flutter installation
flutter doctor

# Clean and rebuild
flutter clean && flutter pub get

# Run with verbose logging
flutter run -v

# Check for linting issues
flutter analyze
```

## 📄 License

This project is created for educational purposes. Feel free to use and modify as needed.

## 🤝 Contributing

This is a learning project, but suggestions and improvements are welcome!

---

**Happy Flutter Development! 🚀**
