# Module 10 — Animations & Transitions (Dart 3.6.1)

## Learning Objectives
- Implement basic (implicit) animations and explicit controller-driven animations
- Create smooth transitions between widgets and pages using Hero animations
- Use AnimationController and Tween/Animation with AnimatedBuilder for efficient rebuilds
- Build custom animations including staggered sequences and custom painters
- Apply best practices for animation performance and lifecycle management

## Key Concepts

### Implicit vs Explicit Animations
- **Implicit**: Automatically animate when properties change (AnimatedContainer, AnimatedOpacity)
- **Explicit**: Manual control with AnimationController for complex sequences

### AnimationController Lifecycle
- Requires `TickerProviderStateMixin` for vsync
- Lifecycle: `initState()` → `forward()`/`reverse()` → `dispose()`
- Always dispose to prevent memory leaks

### Tween Chain Architecture
```
Tween<double>(begin, end) 
  → .animate(CurvedAnimation(parent, curve))
  → AnimatedBuilder(builder: (context, child) => ...)
```

### Hero Animations
- Shared element transitions across routes
- Matching `Hero(tag: "unique_id")` on both pages
- Optional `flightShuttleBuilder` for custom transition behavior

### Staggered Animations
- Multiple Tweens with different `Interval` values
- Single controller drives multiple animations
- Creates sequential animation effects

## Best Practices
- Keep animations subtle and purposeful
- Use appropriate curves (Curves.easeInOut, Curves.fastOutSlowIn)
- Always dispose controllers in `dispose()` method
- Minimize rebuild scope with AnimatedBuilder
- Test on multiple devices and frame rates

## Project Structure
```
lib/
├── main.dart
├── app/
│   ├── app.dart
│   └── theme.dart
├── features/
│   ├── implicit/implicit_page.dart
│   ├── explicit/explicit_page.dart
│   ├── hero/
│   │   ├── hero_grid_page.dart
│   │   └── hero_detail_page.dart
│   ├── custom/custom_page.dart
│   └── routes/transitions_page.dart
└── shared/
    ├── widgets/animated_pulse_button.dart
    └── painters/progress_ring_painter.dart
```

## Run & Verify — iOS Simulator

### Setup Steps:
1. **Install dependencies**: `flutter pub get`
2. **Launch simulator**: `open -a Simulator` (or via Xcode)
3. **Check devices**: `flutter devices` (ensure iOS simulator is listed)
4. **Run app**: `flutter run -d ios`

### Verification Checklist:
- ✅ Implicit page smoothly animates container properties
- ✅ Explicit page controller play/reverse/repeat works without leaks
- ✅ Hero grid → detail animates shared elements smoothly
- ✅ Custom page shows progress ring responding to controller
- ✅ Transitions page demonstrates custom route animations

## Exercises

### Easy
Add a `TweenSequence` to create a bounce scale effect on button press.

### Intermediate
Build a staggered card intro with fade + slide + scale animations.

### Advanced
Implement a Hero with custom `flightShuttleBuilder` and global page transition override.