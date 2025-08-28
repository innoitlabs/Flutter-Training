# Module 6 — Basic Networking & HTTP Requests in Flutter (Dart 3.6.1)

## Learning Objectives
- Make HTTP requests to APIs (GET/POST)
- Handle JSON parsing & serialization safely
- Implement loading states and refresh patterns
- Handle network errors (timeouts, non-2xx codes, parsing errors)

## Key Concepts Covered
- Using the http package (package:http/http.dart)
- JSON parsing (dart:convert), model classes, and fromJson / toJson
- async/await patterns and timeouts
- Error handling with try/catch, mapping HTTP status codes to user-friendly messages
- Loading indicators (CircularProgressIndicator, RefreshIndicator) and empty/error states

## Architecture Overview

### Request Flow
```
UI → Repository/Service → HTTP Client → JSON → Model → UI
```

### Why Separate Concerns?
- **UI Layer**: Handles presentation, user interactions, and state display
- **Service Layer**: Manages HTTP requests, error handling, and data transformation
- **Model Layer**: Defines data structures and JSON serialization/deserialization
- **Network Layer**: Provides shared HTTP client and result types

### HTTP Methods & Timeouts
- **GET**: Retrieve data (posts list, single post)
- **POST**: Create new resources (new post)
- **Timeout**: 10 seconds to prevent UI hanging

## Project Structure
```
lib/
├── main.dart                    # App entry point with Material 3 theme
├── app/
│   └── theme.dart              # Material 3 theme configuration
├── features/
│   └── posts/
│       ├── posts_page.dart     # UI list with loading/error/empty states
│       ├── posts_service.dart  # HTTP GET with timeout and error mapping
│       └── post_model.dart     # fromJson/toJson model
├── core/
│   ├── network/
│   │   ├── api_result.dart     # sealed-like result: success/error
│   │   └── http_client.dart    # shared http.Client and helpers
│   └── cache/
│       └── memory_cache.dart   # simple in-memory cache with TTL
```

## Features Implemented

### Example A — GET List (with Loading & Error)
- Fetches posts from https://jsonplaceholder.typicode.com/posts
- Shows loading spinner during fetch
- Pull-to-refresh functionality
- Error UI with retry button
- In-memory cache to avoid redundant fetches

### Example B — POST Create (Form + Submission State)
- Simple form (title/body) for creating new posts
- Form validation
- Submitting indicator
- Success (201) vs error handling
- Returns created model with SnackBar notification

## Best Practices Demonstrated
- Handle network errors gracefully with specific messages
- Show loading and pull-to-refresh states
- Cache data appropriately (in-memory cache)
- Respect and log proper HTTP status codes
- Keep network code separate from UI widgets
- Use null safety throughout
- Implement proper error mapping

## Run & Verify — iOS Simulator

### Prerequisites
- Flutter SDK with Dart 3.6.1
- Xcode with iOS Simulator
- macOS

### Steps
1. **Install dependencies:**
   ```bash
   flutter pub get
   ```

2. **Launch iOS Simulator:**
   ```bash
   open -a Simulator
   ```
   Or launch from Xcode → Window → Devices and Simulators

3. **Verify Flutter devices:**
   ```bash
   flutter devices
   ```
   Confirm iOS Simulator is listed

4. **Run the app:**
   ```bash
   flutter run -d ios
   ```

### Verification Checklist
- [ ] Posts list loads with spinner then data
- [ ] Pull-to-refresh refetches data
- [ ] Error UI appears when network is disabled
- [ ] Form submission works with loading indicator
- [ ] Success SnackBar shows after POST
- [ ] Material 3 theming is applied

### Testing Network Errors
1. **Simulate network issues:**
   - Simulator → Features → Network Link Conditioner → Enable
   - Or disable Wi-Fi on macOS
   - Or use airplane mode in simulator

2. **Verify error handling:**
   - App should show user-friendly error message
   - Retry button should work when network is restored

## Exercises

### Easy
Add a details screen for a single post (GET /posts/{id}) with loading/error states.

### Intermediate
Add comments fetch with parallel requests and show combined results.

### Advanced
Add a search input with debounced fetch, cache per-query results, and show empty state message.

## Technical Notes
- Uses HTTPS endpoints to avoid iOS ATS issues
- No Info.plist changes required
- All code is null-safe and compatible with Dart 3.6.1
- Material 3 theming with ColorScheme.fromSeed
- No deprecated APIs used
