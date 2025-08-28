# Module 13 — Advanced State Management with BLoC (Dart 3.6.1)

A comprehensive Flutter learning module that teaches the BLoC (Business Logic Component) pattern for complex state management. This module demonstrates fundamental concepts, advanced patterns, and best practices for building scalable Flutter applications.

## 🎯 Learning Objectives

- **Implement the BLoC pattern** in Flutter applications
- **Handle complex state scenarios** (loading, success, error, empty, pagination)
- **Create reusable BLoCs** and compose them across features
- **Test BLoC logic thoroughly** (unit & widget tests)

## 🏗️ Architecture Overview

### BLoC Pattern Fundamentals

The BLoC pattern separates business logic from UI by:
- **Events**: Input to the BLoC (user actions, system events)
- **States**: Output from the BLoC (UI state representation)
- **BLoC**: Business logic component that transforms events into states

```
UI → Events → BLoC → States → UI
```

### Key Benefits

- **Deterministic Logic**: Business logic is pure and testable
- **UI Decoupling**: UI components only depend on state, not business logic
- **Reusability**: BLoCs can be shared across multiple UI components
- **Testability**: Business logic can be tested independently

## 📱 App Features

### BlocHub - A 3-Tab Demo Application

1. **Counter Tab** - Minimal BLoC implementation
   - Events: increment, decrement, reset
   - States: value with derived properties (parity, sign)
   - UI: BlocBuilder, BlocListener for side effects

2. **Todos Tab** - CRUD operations with composition
   - Events: load, add, update, delete, toggle, filter, clear completed
   - States: todos list with filtering and status management
   - Composition: TodoStatsBloc derived from TodosBloc
   - UI: Complex forms, filtering, statistics

3. **Feed Tab** - Async operations with pagination
   - Events: fetch first page, fetch next page, refresh, retry
   - States: paginated feed with loading states and error handling
   - UI: Infinite scroll, pull-to-refresh, error recovery

## 🚀 Getting Started

### Prerequisites

- Flutter SDK >= 3.16.0
- Dart SDK >= 3.6.1
- iOS Simulator (for testing)

### Installation

1. **Clone and setup**:
   ```bash
   cd Module13-Advanced-State-Management-BLoC
   flutter pub get
   ```

2. **Launch iOS Simulator**:
   ```bash
   open -a Simulator
   # or via Xcode: Xcode → Open Developer Tool → Simulator
   ```

3. **Run the app**:
   ```bash
   flutter devices  # Confirm iOS simulator appears
   flutter run -d ios
   ```

### Verify Functionality

#### Counter Tab
- ✅ Buttons dispatch events correctly
- ✅ Snackbar appears on thresholds (10, reset)
- ✅ Parity updates correctly (even/odd colors)
- ✅ Derived properties work (positive/negative/zero)

#### Todos Tab
- ✅ Add new todos with validation
- ✅ Toggle completion status
- ✅ Edit existing todos
- ✅ Delete todos
- ✅ Filter by status (all/active/completed)
- ✅ Statistics update via composed BLoC
- ✅ Clear completed functionality

#### Feed Tab
- ✅ First page loads automatically
- ✅ Infinite scroll loads more pages
- ✅ Pull-to-refresh resets to page 1
- ✅ Error handling with retry buttons
- ✅ Loading states for pagination
- ✅ End-of-feed detection

## 📚 Core Concepts

### 1. Event & State Classes

```dart
// Events extend Equatable for comparison
abstract class CounterEvent extends Equatable {
  const CounterEvent();
  @override
  List<Object?> get props => [];
}

// States contain data and derived properties
class CounterState extends Equatable {
  final int value;
  final bool isEven;
  final bool isPositive;
  
  const CounterState({required this.value})
    : isEven = value % 2 == 0,
      isPositive = value > 0;
}
```

### 2. BLoC Implementation

```dart
class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState.initial()) {
    on<CounterIncrement>(_onIncrement);
    on<CounterDecrement>(_onDecrement);
    on<CounterReset>(_onReset);
  }

  void _onIncrement(CounterIncrement event, Emitter<CounterState> emit) {
    final newValue = state.value + 1;
    emit(CounterState.value(newValue));
  }
}
```

### 3. UI Integration

```dart
BlocBuilder<CounterBloc, CounterState>(
  builder: (context, state) {
    return Text('${state.value}');
  },
)

BlocListener<CounterBloc, CounterState>(
  listener: (context, state) {
    if (state.value == 10) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('🎉 You reached 10!')),
      );
    }
  },
  child: // UI widgets
)
```

### 4. BLoC Composition

```dart
// TodoStatsBloc listens to TodosBloc
class TodoStatsBloc extends Bloc<TodoStatsEvent, TodoStatsState> {
  final TodosBloc todosBloc;

  TodoStatsBloc({required this.todosBloc}) : super(const TodoStatsState.initial()) {
    // Listen to parent BLoC's stream
    todosBloc.stream.listen((todosState) {
      if (todosState.status == TodosStatus.success) {
        add(TodoStatsUpdated(todosState));
      }
    });
  }
}
```

## 🧪 Testing

### Unit Tests with bloc_test

```dart
blocTest<CounterBloc, CounterState>(
  'emits [CounterState(value: 1)] when increment is added',
  build: () => CounterBloc(),
  act: (bloc) => bloc.add(const CounterIncrement()),
  expect: () => [const CounterState(value: 1)],
);
```

### Widget Tests with Mock BLoCs

```dart
testWidgets('shows todos list when todos exist', (tester) async {
  when(() => mockTodosBloc.state).thenReturn(
    TodosState.success(todos: testTodos),
  );
  
  await tester.pumpWidget(createTestWidget());
  expect(find.text('Test Todo'), findsOneWidget);
});
```

### Run Tests

```bash
# Run all tests
flutter test

# Run specific test file
flutter test test/counter/counter_bloc_test.dart

# Run with coverage
flutter test --coverage
```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── app/
│   ├── app.dart             # Main app widget with BLoC providers
│   ├── theme.dart           # Material 3 theme configuration
│   └── routes.dart          # App routing
├── core/
│   ├── result.dart          # Success/Error result type
│   └── exceptions.dart      # Custom exceptions
├── features/
│   ├── counter/             # Example A: Fundamentals
│   │   ├── counter_bloc.dart
│   │   ├── counter_event.dart
│   │   ├── counter_state.dart
│   │   └── counter_page.dart
│   ├── todos/               # Example B: CRUD + Composition
│   │   ├── data/
│   │   │   ├── todo_model.dart
│   │   │   └── todo_repository.dart
│   │   ├── bloc/
│   │   │   ├── todos_bloc.dart
│   │   │   ├── todos_event.dart
│   │   │   ├── todos_state.dart
│   │   │   └── todo_stats_bloc.dart
│   │   └── ui/
│   │       ├── todos_page.dart
│   │       └── todo_editor_sheet.dart
│   └── feed/                # Example C: Async + Pagination
│       ├── data/
│       │   └── feed_repository.dart
│       ├── bloc/
│       │   ├── feed_bloc.dart
│       │   ├── feed_event.dart
│       │   └── feed_state.dart
│       └── ui/
│           └── feed_page.dart
test/
├── counter/
│   └── counter_bloc_test.dart
├── todos/
│   └── todos_bloc_test.dart
├── feed/
│   └── feed_bloc_test.dart
└── widget/
    └── todos_page_test.dart
```

## 🎨 Material 3 Design

The app uses Material 3 design system with:
- Dynamic color scheme based on seed color
- Adaptive theming (light/dark mode)
- Modern UI components (NavigationBar, SegmentedButton)
- Consistent spacing and typography

## 🔧 Dependencies

```yaml
dependencies:
  flutter_bloc: ^8.1.3    # BLoC pattern implementation
  bloc: ^8.1.2            # Core BLoC library
  equatable: ^2.0.5       # Value equality for events/states

dev_dependencies:
  bloc_test: ^9.1.4       # BLoC testing utilities
  mocktail: ^1.0.2        # Mocking for tests
  flutter_lints: ^3.0.0   # Code quality
```

## 📖 Best Practices

### 1. Keep BLoCs Focused
- Single responsibility principle
- Avoid "god" BLoCs that handle everything
- Compose BLoCs instead of creating mega-BLoCs

### 2. State Modeling
- Model states explicitly (loading/success/error/empty)
- Include derived properties in state
- Use sealed classes or Equatable for type safety

### 3. Error Handling
- Centralize error mapping in BLoCs
- Keep error states explicit and user-friendly
- Never emit ambiguous states

### 4. Performance
- Use `buildWhen` in BlocBuilder to reduce rebuilds
- Split widgets to minimize rebuild scope
- Use selectors for fine-grained updates

### 5. Testing
- Test BLoC logic thoroughly (happy path, error path, edge cases)
- Mock external dependencies (repositories, services)
- Test UI integration with widget tests

## 🚀 Exercises

### Easy
- Add "Clear completed" event to Todos BLoC
- Verify stats update correctly after clearing
- Add unit tests for the new functionality

### Intermediate
- Add search filter to Todos with debouncing
- Implement search in the BLoC with proper state management
- Add UI for search input with real-time filtering

### Advanced
- Add infinite scroll to Feed with scroll listener
- Implement backpressure (ignore new fetch while loading)
- Add scroll position restoration after refresh

## 🔍 Troubleshooting

### Common Issues

1. **BLoC not updating UI**
   - Check if BlocProvider is properly scoped
   - Verify event dispatching is working
   - Ensure state equality is implemented correctly

2. **Memory leaks**
   - Always close BLoCs in dispose methods
   - Use BlocProvider.value for testing
   - Avoid storing BLoCs in global variables

3. **Test failures**
   - Mock all external dependencies
   - Use proper async/await in tests
   - Verify state transitions in order

### Debug Tips

- Enable BLoC transition logging:
  ```dart
  @override
  void onTransition(Transition<Event, State> transition) {
    super.onTransition(transition);
    print('${transition.event} -> ${transition.currentState}');
  }
  ```

- Use BlocObserver for global debugging:
  ```dart
  class AppBlocObserver extends BlocObserver {
    @override
    void onChange(BlocBase bloc, Change change) {
      super.onChange(bloc, change);
      print('${bloc.runtimeType} $change');
    }
  }
  ```

## 📚 Additional Resources

- [BLoC Documentation](https://bloclibrary.dev/)
- [Flutter BLoC Package](https://pub.dev/packages/flutter_bloc)
- [BLoC Testing Guide](https://bloclibrary.dev/#/testing)
- [Material 3 Design](https://m3.material.io/)

## 🤝 Contributing

This is a learning module. Feel free to:
- Report issues or bugs
- Suggest improvements
- Add more examples
- Enhance documentation

## 📄 License

This project is for educational purposes. Use it to learn and improve your Flutter development skills!
