# Quick Run Instructions

## Prerequisites
- Flutter SDK with Dart 3.6.1
- Xcode with iOS Simulator
- macOS

## Run the App

1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Run tests (optional):**
   ```bash
   flutter test
   ```

3. **Launch iOS Simulator (if not already running):**
   ```bash
   open -a Simulator
   ```

4. **Run the app:**
   ```bash
   flutter run -d ios
   ```

## What to Test

### ✅ Posts List (GET Request)
- App loads with loading spinner
- Posts list appears with cards
- Pull-to-refresh works
- Error handling when network is disabled

### ✅ Create Post (POST Request)
- Tap the + button to open create form
- Fill in title (min 3 chars) and body (min 10 chars)
- Submit and see loading indicator
- Success SnackBar appears
- New post appears in list

### ✅ Error Handling
- Disable network in Simulator → Features → Network Link Conditioner
- See error UI with retry button
- Re-enable network and retry works

### ✅ Material 3 Theming
- Modern Material 3 design
- Adaptive light/dark theme
- Purple color scheme

## Project Structure
```
lib/
├── main.dart                    # App entry point
├── app/theme.dart              # Material 3 theme
├── features/posts/
│   ├── posts_page.dart         # Posts list UI
│   ├── posts_service.dart      # HTTP service
│   ├── post_model.dart         # Data models
│   └── create_post_page.dart   # Create form
└── core/
    ├── network/
    │   ├── api_result.dart     # Result types
    │   └── http_client.dart    # HTTP client
    └── cache/memory_cache.dart # In-memory cache
```

## Key Features Demonstrated
- ✅ HTTP GET/POST requests with timeout
- ✅ JSON parsing with null safety
- ✅ Loading states and error handling
- ✅ Pull-to-refresh functionality
- ✅ Form validation and submission
- ✅ In-memory caching
- ✅ Material 3 theming
- ✅ Status code handling
- ✅ Network error mapping
