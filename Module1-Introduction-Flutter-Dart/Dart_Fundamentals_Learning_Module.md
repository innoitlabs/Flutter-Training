# Dart Fundamentals Learning Module

## 1. Title & Objectives

### Learning Objectives
By the end of this module, you will be able to:
- Write and run basic Dart programs with proper syntax
- Understand Dart's type system and null safety features
- Work with variables, data types, operators, and control flow
- Create and manipulate collections (lists, sets, maps)
- Build object-oriented programs using classes, inheritance, and interfaces
- Handle asynchronous operations with Future and async/await
- Apply Dart concepts to real-world scenarios and Flutter development

---

## 2. Introduction to Dart

### What is Dart?
Dart is a modern, object-oriented programming language developed by Google. It was designed to be:
- **Fast**: Compiles to native code for high performance
- **Productive**: Features like null safety and strong typing help catch errors early
- **Portable**: Runs on multiple platforms (mobile, web, desktop, server)
- **Object-oriented**: Everything is an object, following OOP principles

### Where is Dart Used?
- **Flutter**: Primary language for building cross-platform mobile apps
- **Web Development**: Can be compiled to JavaScript for web applications
- **Server-side**: Used for backend development with frameworks like Aqueduct
- **Command-line Tools**: Building CLI applications and scripts

### Key Features for Flutter Developers
- **Hot Reload**: Changes reflect immediately during development
- **Strong Typing**: Catches errors at compile time
- **Null Safety**: Prevents null reference errors
- **Rich Standard Library**: Built-in support for common operations

---

## 3. Dart Fundamentals

### Hello World & Basic Syntax

Let's start with the traditional "Hello World" program:

```dart
// This is a comment in Dart
void main() {
  print('Hello, World!');
}
```

**Key Points:**
- `void main()` is the entry point of every Dart program
- `print()` is used to output text to the console
- Semicolons (`;`) are required at the end of statements
- Comments use `//` for single lines or `/* */` for multi-line

### Variables & Constants

Dart provides several ways to declare variables:

```dart
void main() {
  // 1. var - Type inference (recommended for local variables)
  var name = 'John';
  var age = 25;
  
  // 2. final - Runtime constant (value set once, cannot be changed)
  final String city = 'New York';
  final pi = 3.14159;
  
  // 3. const - Compile-time constant (value known at compile time)
  const String country = 'USA';
  const double gravity = 9.8;
  
  // 4. dynamic - Can hold any type (use sparingly)
  dynamic flexible = 'I can be anything';
  flexible = 42;
  flexible = true;
  
  // 5. Explicit type declaration
  String greeting = 'Hello';
  int count = 10;
  double price = 19.99;
  bool isActive = true;
  
  print('Name: $name, Age: $age');
  print('City: $city, Country: $country');
}
```

**Variable Declaration Guidelines:**
- Use `var` for local variables when the type is obvious
- Use `final` when you want a variable that can't be reassigned
- Use `const` for compile-time constants
- Avoid `dynamic` unless absolutely necessary

### Data Types

Dart has several built-in data types:

```dart
void main() {
  // Numbers
  int wholeNumber = 42;           // Integer
  double decimalNumber = 3.14;    // Double (64-bit floating point)
  num flexibleNumber = 10;        // Can be int or double
  
  // Strings
  String text = 'Hello Dart!';
  String multiLine = '''
    This is a
    multi-line string
    in Dart
  ''';
  
  // String interpolation
  String name = 'Alice';
  int age = 30;
  String message = 'My name is $name and I am $age years old';
  String expression = 'Next year I will be ${age + 1}';
  
  // Booleans
  bool isTrue = true;
  bool isFalse = false;
  
  // Null safety - variables are non-nullable by default
  String nonNullable = 'This cannot be null';
  String? nullable = 'This can be null';
  nullable = null; // This is allowed
  
  print('Whole number: $wholeNumber');
  print('Decimal: $decimalNumber');
  print('Message: $message');
  print('Expression: $expression');
  print('Nullable: $nullable');
}
```

### Operators

Dart supports various types of operators:

```dart
void main() {
  // Arithmetic operators
  int a = 10;
  int b = 3;
  
  print('Addition: ${a + b}');        // 13
  print('Subtraction: ${a - b}');     // 7
  print('Multiplication: ${a * b}');  // 30
  print('Division: ${a / b}');        // 3.333...
  print('Integer division: ${a ~/ b}'); // 3
  print('Modulo: ${a % b}');          // 1
  print('Increment: ${++a}');         // 11
  print('Decrement: ${--a}');         // 10
  
  // Comparison operators
  print('Equal: ${a == b}');          // false
  print('Not equal: ${a != b}');      // true
  print('Greater than: ${a > b}');    // true
  print('Less than: ${a < b}');       // false
  print('Greater or equal: ${a >= b}'); // true
  print('Less or equal: ${a <= b}');  // false
  
  // Logical operators
  bool x = true;
  bool y = false;
  
  print('AND: ${x && y}');            // false
  print('OR: ${x || y}');             // true
  print('NOT: ${!x}');                // false
  
  // Type test operators
  var value = 'Hello';
  print('Is String: ${value is String}');  // true
  print('Is int: ${value is int}');        // false
  
  // Assignment operators
  int c = 5;
  c += 3;  // Same as c = c + 3
  print('After +=: $c');  // 8
  
  c *= 2;  // Same as c = c * 2
  print('After *=: $c');  // 16
}
```

### Control Flow

Dart provides standard control flow structures:

```dart
void main() {
  // If-else statements
  int age = 18;
  
  if (age >= 18) {
    print('You are an adult');
  } else if (age >= 13) {
    print('You are a teenager');
  } else {
    print('You are a child');
  }
  
  // Switch statements
  String grade = 'B';
  
  switch (grade) {
    case 'A':
      print('Excellent!');
      break;
    case 'B':
      print('Good job!');
      break;
    case 'C':
      print('Satisfactory');
      break;
    default:
      print('Needs improvement');
  }
  
  // For loops
  print('Counting from 1 to 5:');
  for (int i = 1; i <= 5; i++) {
    print(i);
  }
  
  // For-in loops (for collections)
  List<String> fruits = ['apple', 'banana', 'orange'];
  print('Fruits:');
  for (String fruit in fruits) {
    print(fruit);
  }
  
  // While loops
  int count = 0;
  while (count < 3) {
    print('Count: $count');
    count++;
  }
  
  // Do-while loops
  int number = 0;
  do {
    print('Number: $number');
    number++;
  } while (number < 3);
  
  // Break and continue
  for (int i = 0; i < 10; i++) {
    if (i == 5) {
      break; // Exit the loop
    }
    if (i == 2) {
      continue; // Skip this iteration
    }
    print('Processing: $i');
  }
}
```

### Functions

Dart functions are first-class objects and support various features:

```dart
void main() {
  // Basic function
  void greet() {
    print('Hello!');
  }
  greet();
  
  // Function with parameters
  void greetPerson(String name) {
    print('Hello, $name!');
  }
  greetPerson('Alice');
  
  // Function with return value
  int add(int a, int b) {
    return a + b;
  }
  print('Sum: ${add(5, 3)}');
  
  // Arrow syntax for simple functions
  int multiply(int a, int b) => a * b;
  print('Product: ${multiply(4, 6)}');
  
  // Optional parameters
  void greetWithTitle(String name, [String title = 'Mr.']) {
    print('Hello, $title $name!');
  }
  greetWithTitle('Smith');           // Hello, Mr. Smith!
  greetWithTitle('Johnson', 'Dr.');  // Hello, Dr. Johnson!
  
  // Named parameters
  void createUser({required String name, int age = 0, String? email}) {
    print('Name: $name, Age: $age, Email: $email');
  }
  createUser(name: 'Bob', age: 25, email: 'bob@example.com');
  createUser(name: 'Alice'); // age defaults to 0, email is null
  
  // Higher-order functions
  void processNumbers(List<int> numbers, int Function(int) operation) {
    for (int number in numbers) {
      print('Result: ${operation(number)}');
    }
  }
  
  int square(int x) => x * x;
  int double(int x) => x * 2;
  
  List<int> numbers = [1, 2, 3, 4];
  print('Squaring numbers:');
  processNumbers(numbers, square);
  print('Doubling numbers:');
  processNumbers(numbers, double);
  
  // Anonymous functions (closures)
  processNumbers(numbers, (int x) => x + 10);
}

### Collections

Dart provides three main collection types:

```dart
void main() {
  // Lists (ordered, indexed, allows duplicates)
  List<String> fruits = ['apple', 'banana', 'orange'];
  List<int> numbers = [1, 2, 3, 4, 5];
  
  // Accessing elements
  print('First fruit: ${fruits[0]}');
  print('Last number: ${numbers[numbers.length - 1]}');
  
  // Adding elements
  fruits.add('grape');
  fruits.insert(1, 'mango');
  
  // Removing elements
  fruits.remove('banana');
  fruits.removeAt(0);
  
  // List operations
  print('Fruits: $fruits');
  print('Length: ${fruits.length}');
  print('Is empty: ${fruits.isEmpty}');
  print('Contains apple: ${fruits.contains('apple')}');
  
  // List methods
  numbers.sort();
  print('Sorted numbers: $numbers');
  
  // Spread operator (...)
  List<String> moreFruits = ['kiwi', 'pear'];
  List<String> allFruits = [...fruits, ...moreFruits];
  print('All fruits: $allFruits');
  
  // Sets (unordered, unique elements)
  Set<String> uniqueFruits = {'apple', 'banana', 'apple', 'orange'};
  print('Unique fruits: $uniqueFruits'); // apple, banana, orange
  
  // Set operations
  uniqueFruits.add('grape');
  uniqueFruits.remove('banana');
  print('Updated set: $uniqueFruits');
  
  // Maps (key-value pairs)
  Map<String, int> scores = {
    'Alice': 95,
    'Bob': 87,
    'Charlie': 92,
  };
  
  // Accessing and modifying maps
  print('Alice\'s score: ${scores['Alice']}');
  scores['David'] = 88;
  scores.remove('Bob');
  
  // Map operations
  print('Scores: $scores');
  print('Keys: ${scores.keys}');
  print('Values: ${scores.values}');
  print('Contains Alice: ${scores.containsKey('Alice')}');
  
  // Null-aware operators
  Map<String, int>? nullableMap = null;
  print('Map length: ${nullableMap?.length}'); // null instead of error
  
  // Null coalescing operator
  int? nullableValue = null;
  int defaultValue = nullableValue ?? 0;
  print('Value: $defaultValue'); // 0
}
```

### Null Safety

Dart's null safety is a key feature that prevents null reference errors:

```dart
void main() {
  // Non-nullable types (default)
  String name = 'John'; // Cannot be null
  int age = 25;         // Cannot be null
  
  // Nullable types (use ?)
  String? nullableName = 'Jane';
  nullableName = null; // This is allowed
  
  int? nullableAge = 30;
  nullableAge = null; // This is allowed
  
  // Null-aware operators
  String? maybeName = null;
  
  // ?. operator (safe navigation)
  print('Length: ${maybeName?.length}'); // null instead of error
  
  // ?? operator (null coalescing)
  String displayName = maybeName ?? 'Unknown';
  print('Display name: $displayName'); // Unknown
  
  // ! operator (null assertion - use carefully!)
  String? definitelyNotNull = 'Hello';
  String forced = definitelyNotNull!; // Asserts it's not null
  print('Forced: $forced');
  
  // Null-aware assignment
  String? userName;
  userName ??= 'Default User'; // Only assigns if userName is null
  print('User name: $userName');
  
  // Conditional access
  List<String>? maybeList = null;
  print('First item: ${maybeList?[0]}'); // null instead of error
  
  // Null safety in functions
  void greetPerson(String? name) {
    if (name != null) {
      print('Hello, $name!');
    } else {
      print('Hello, stranger!');
    }
  }
  
  greetPerson('Alice');
  greetPerson(null);
  
  // Late variables (initialized later, but before use)
  late String lateName;
  lateName = 'Late Initialized'; // Must be set before use
  print('Late name: $lateName');
}

---

## 4. Object-Oriented Programming in Dart

### Classes and Objects

```dart
void main() {
  // Basic class
  class Person {
    // Instance variables
    String name;
    int age;
    
    // Constructor
    Person(this.name, this.age);
    
    // Method
    void introduce() {
      print('Hi, I\'m $name and I\'m $age years old.');
    }
    
    // Getter
    String get description => '$name ($age years old)';
    
    // Setter
    set setAge(int newAge) {
      if (newAge >= 0) {
        age = newAge;
      }
    }
  }
  
  // Creating objects
  Person person1 = Person('Alice', 25);
  Person person2 = Person('Bob', 30);
  
  person1.introduce();
  person2.introduce();
  
  print(person1.description);
  person1.setAge = 26;
  print('After birthday: ${person1.description}');
  
  // Named constructors
  class Point {
    double x, y;
    
    Point(this.x, this.y);
    
    // Named constructor
    Point.origin() : x = 0, y = 0;
    
    // Named constructor with parameters
    Point.fromJson(Map<String, double> json)
        : x = json['x'] ?? 0,
          y = json['y'] ?? 0;
    
    void display() {
      print('Point($x, $y)');
    }
  }
  
  Point p1 = Point(3, 4);
  Point p2 = Point.origin();
  Point p3 = Point.fromJson({'x': 1, 'y': 2});
  
  p1.display();
  p2.display();
  p3.display();
}
```

### Inheritance

```dart
void main() {
  // Base class
  class Animal {
    String name;
    
    Animal(this.name);
    
    void makeSound() {
      print('Some animal sound');
    }
    
    void sleep() {
      print('$name is sleeping');
    }
  }
  
  // Derived class
  class Dog extends Animal {
    String breed;
    
    // Call super constructor
    Dog(String name, this.breed) : super(name);
    
    // Override method
    @override
    void makeSound() {
      print('$name barks: Woof!');
    }
    
    // New method
    void fetch() {
      print('$name fetches the ball');
    }
  }
  
  // Another derived class
  class Cat extends Animal {
    Cat(String name) : super(name);
    
    @override
    void makeSound() {
      print('$name meows: Meow!');
    }
    
    void climb() {
      print('$name climbs the tree');
    }
  }
  
  Dog dog = Dog('Buddy', 'Golden Retriever');
  Cat cat = Cat('Whiskers');
  
  dog.makeSound();
  dog.sleep();
  dog.fetch();
  
  cat.makeSound();
  cat.sleep();
  cat.climb();
  
  // Abstract classes
  abstract class Shape {
    double get area;
    double get perimeter;
    
    void display() {
      print('Area: $area, Perimeter: $perimeter');
    }
  }
  
  class Circle extends Shape {
    double radius;
    
    Circle(this.radius);
    
    @override
    double get area => 3.14159 * radius * radius;
    
    @override
    double get perimeter => 2 * 3.14159 * radius;
  }
  
  class Rectangle extends Shape {
    double width, height;
    
    Rectangle(this.width, this.height);
    
    @override
    double get area => width * height;
    
    @override
    double get perimeter => 2 * (width + height);
  }
  
  Circle circle = Circle(5);
  Rectangle rectangle = Rectangle(4, 6);
  
  circle.display();
  rectangle.display();
}
```

### Interfaces and Mixins

```dart
void main() {
  // Interfaces (implicit in Dart)
  class Flyable {
    void fly() {
      print('Flying...');
    }
  }
  
  class Swimmable {
    void swim() {
      print('Swimming...');
    }
  }
  
  // Class implementing multiple interfaces
  class Duck implements Flyable, Swimmable {
    String name;
    
    Duck(this.name);
    
    @override
    void fly() {
      print('$name is flying');
    }
    
    @override
    void swim() {
      print('$name is swimming');
    }
    
    void quack() {
      print('$name says: Quack!');
    }
  }
  
  Duck duck = Duck('Donald');
  duck.fly();
  duck.swim();
  duck.quack();
  
  // Mixins (reusable code)
  mixin Logger {
    void log(String message) {
      print('Log: $message');
    }
  }
  
  mixin Validator {
    bool isValidEmail(String email) {
      return email.contains('@');
    }
  }
  
  class User with Logger, Validator {
    String name;
    String email;
    
    User(this.name, this.email);
    
    void register() {
      log('Registering user: $name');
      if (isValidEmail(email)) {
        log('Email is valid');
      } else {
        log('Invalid email');
      }
    }
  }
  
  User user = User('John', 'john@example.com');
  user.register();
  
  // Extension methods
  extension StringExtension on String {
    String get reversed => split('').reversed.join();
    
    bool get isPalindrome {
      String clean = toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
      return clean == clean.split('').reversed.join();
    }
  }
  
  String text = 'Hello';
  print('Original: $text');
  print('Reversed: ${text.reversed}');
  
  String palindrome = 'A man, a plan, a canal: Panama';
  print('Is palindrome: ${palindrome.isPalindrome}');
}

---

## 5. Asynchronous Programming

### Future Basics

```dart
void main() {
  // Creating a Future
  Future<String> fetchUserData() {
    // Simulate network delay
    return Future.delayed(Duration(seconds: 2), () {
      return 'User data loaded successfully';
    });
  }
  
  // Using Future with .then()
  print('Starting to fetch data...');
  fetchUserData().then((data) {
    print('Data received: $data');
  }).catchError((error) {
    print('Error: $error');
  });
  
  // Future with error handling
  Future<int> divideNumbers(int a, int b) {
    return Future.delayed(Duration(seconds: 1), () {
      if (b == 0) {
        throw Exception('Division by zero');
      }
      return a ~/ b;
    });
  }
  
  divideNumbers(10, 2).then((result) {
    print('Result: $result');
  }).catchError((error) {
    print('Error: $error');
  });
  
  // Multiple Futures
  Future<String> fetchName() {
    return Future.delayed(Duration(seconds: 1), () => 'John');
  }
  
  Future<String> fetchAge() {
    return Future.delayed(Duration(seconds: 1), () => '25');
  }
  
  Future.wait([fetchName(), fetchAge()]).then((results) {
    print('Name: ${results[0]}, Age: ${results[1]}');
  });
}
```

### Async/Await

```dart
void main() async {
  // Basic async function
  Future<String> fetchData() async {
    await Future.delayed(Duration(seconds: 2));
    return 'Data loaded';
  }
  
  // Using async/await
  print('Starting...');
  String result = await fetchData();
  print('Result: $result');
  
  // Error handling with try-catch
  Future<int> riskyOperation() async {
    await Future.delayed(Duration(seconds: 1));
    throw Exception('Something went wrong');
  }
  
  try {
    int value = await riskyOperation();
    print('Value: $value');
  } catch (error) {
    print('Caught error: $error');
  }
  
  // Multiple async operations
  Future<String> fetchUser() async {
    await Future.delayed(Duration(seconds: 1));
    return 'User data';
  }
  
  Future<String> fetchPosts() async {
    await Future.delayed(Duration(seconds: 1));
    return 'Posts data';
  }
  
  // Sequential execution
  print('Fetching sequentially...');
  String user = await fetchUser();
  String posts = await fetchPosts();
  print('User: $user, Posts: $posts');
  
  // Parallel execution
  print('Fetching in parallel...');
  List<String> results = await Future.wait([fetchUser(), fetchPosts()]);
  print('Results: $results');
  
  // Async function with return type
  Future<Map<String, dynamic>> fetchUserProfile() async {
    await Future.delayed(Duration(seconds: 1));
    return {
      'name': 'Alice',
      'age': 30,
      'email': 'alice@example.com'
    };
  }
  
  Map<String, dynamic> profile = await fetchUserProfile();
  print('Profile: $profile');
}
```

### Streams

```dart
import 'dart:async';

void main() async {
  // Creating a Stream
  Stream<int> countStream() async* {
    for (int i = 1; i <= 5; i++) {
      await Future.delayed(Duration(seconds: 1));
      yield i; // Emit value
    }
  }
  
  // Listening to a Stream
  print('Listening to count stream...');
  await for (int count in countStream()) {
    print('Count: $count');
  }
  
  // Stream with listen method
  Stream<String> messageStream() async* {
    yield 'Hello';
    await Future.delayed(Duration(seconds: 1));
    yield 'World';
    await Future.delayed(Duration(seconds: 1));
    yield 'From Dart!';
  }
  
  messageStream().listen(
    (message) => print('Received: $message'),
    onError: (error) => print('Error: $error'),
    onDone: () => print('Stream completed'),
  );
  
  // Stream transformations
  Stream<int> numberStream() async* {
    for (int i = 1; i <= 10; i++) {
      await Future.delayed(Duration(milliseconds: 500));
      yield i;
    }
  }
  
  // Filter even numbers
  await for (int number in numberStream().where((n) => n % 2 == 0)) {
    print('Even number: $number');
  }
  
  // Transform numbers to strings
  await for (String text in numberStream().map((n) => 'Number $n')) {
    print(text);
  }
  
  // Take only first 3 values
  await for (int number in numberStream().take(3)) {
    print('First 3: $number');
  }
  
  // StreamController (for manual control)
  StreamController<String> controller = StreamController<String>();
  
  // Listen to the stream
  controller.stream.listen(
    (data) => print('Controller: $data'),
    onDone: () => print('Controller done'),
  );
  
  // Add data to the stream
  controller.add('First message');
  await Future.delayed(Duration(seconds: 1));
  controller.add('Second message');
  await Future.delayed(Duration(seconds: 1));
  controller.close(); // Close the stream
}

---

## 6. Mini Projects / Practice

### Easy: Prime Number Checker

```dart
void main() {
  bool isPrime(int number) {
    if (number < 2) return false;
    if (number == 2) return true;
    if (number % 2 == 0) return false;
    
    for (int i = 3; i * i <= number; i += 2) {
      if (number % i == 0) return false;
    }
    return true;
  }
  
  // Test the function
  List<int> testNumbers = [2, 3, 4, 5, 7, 9, 11, 13, 15, 17];
  
  for (int number in testNumbers) {
    print('$number is ${isPrime(number) ? 'prime' : 'not prime'}');
  }
}
```

### Intermediate: Student Grade Calculator

```dart
void main() {
  class Student {
    String name;
    Map<String, int> marks;
    
    Student(this.name, this.marks);
    
    double get average {
      if (marks.isEmpty) return 0.0;
      int total = marks.values.reduce((a, b) => a + b);
      return total / marks.length;
    }
    
    String get grade {
      double avg = average;
      if (avg >= 90) return 'A';
      if (avg >= 80) return 'B';
      if (avg >= 70) return 'C';
      if (avg >= 60) return 'D';
      return 'F';
    }
    
    void displayInfo() {
      print('Student: $name');
      print('Marks: $marks');
      print('Average: ${average.toStringAsFixed(2)}');
      print('Grade: $grade');
      print('---');
    }
  }
  
  // Create students
  Student alice = Student('Alice', {
    'Math': 95,
    'Science': 88,
    'English': 92,
    'History': 85,
  });
  
  Student bob = Student('Bob', {
    'Math': 75,
    'Science': 82,
    'English': 78,
    'History': 80,
  });
  
  // Display student information
  alice.displayInfo();
  bob.displayInfo();
  
  // Find the best student
  List<Student> students = [alice, bob];
  Student? bestStudent = students.reduce((a, b) => 
    a.average > b.average ? a : b);
  
  print('Best student: ${bestStudent?.name} with average: ${bestStudent?.average.toStringAsFixed(2)}');
}
```

### Advanced: Async Data Fetcher

```dart
import 'dart:convert';

void main() async {
  // Mock JSON data fetcher
  Future<Map<String, dynamic>> fetchMockData() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 2));
    
    // Return mock JSON data
    return {
      'users': [
        {'id': 1, 'name': 'Alice', 'email': 'alice@example.com'},
        {'id': 2, 'name': 'Bob', 'email': 'bob@example.com'},
        {'id': 3, 'name': 'Charlie', 'email': 'charlie@example.com'},
      ],
      'posts': [
        {'id': 1, 'title': 'First Post', 'content': 'Hello World!'},
        {'id': 2, 'title': 'Second Post', 'content': 'Dart is awesome!'},
      ],
      'timestamp': DateTime.now().toIso8601String(),
    };
  }
  
  // Process the data
  Future<void> processData() async {
    try {
      print('Fetching data...');
      Map<String, dynamic> data = await fetchMockData();
      
      print('Data received at: ${data['timestamp']}');
      
      // Process users
      List<dynamic> users = data['users'];
      print('\nUsers:');
      for (var user in users) {
        print('- ${user['name']} (${user['email']})');
      }
      
      // Process posts
      List<dynamic> posts = data['posts'];
      print('\nPosts:');
      for (var post in posts) {
        print('- ${post['title']}: ${post['content']}');
      }
      
      // Calculate statistics
      print('\nStatistics:');
      print('Total users: ${users.length}');
      print('Total posts: ${posts.length}');
      
    } catch (error) {
      print('Error fetching data: $error');
    }
  }
  
  // Run the async operation
  await processData();
  print('\nData processing completed!');
}

---

## 7. Comparison to Other Languages

### JavaScript vs Dart

| Feature | JavaScript | Dart |
|---------|------------|------|
| Type System | Dynamic | Static (with type inference) |
| Null Safety | No | Yes (built-in) |
| Classes | ES6+ | Yes |
| Async/Await | Yes | Yes |
| Compilation | Interpreted | Compiled |

**JavaScript:**
```javascript
let name = "John";
let age = 25;
function greet(person) {
    return `Hello, ${person}!`;
}
```

**Dart:**
```dart
String name = 'John';
int age = 25;
String greet(String person) => 'Hello, $person!';
```

### Java vs Dart

| Feature | Java | Dart |
|---------|------|------|
| Null Safety | Optional (Java 8+) | Built-in |
| Type Inference | Limited | Yes |
| Functions | Methods only | First-class |
| Collections | Separate classes | Built-in types |

**Java:**
```java
public class Person {
    private String name;
    private int age;
    
    public Person(String name, int age) {
        this.name = name;
        this.age = age;
    }
    
    public void introduce() {
        System.out.println("Hi, I'm " + name);
    }
}
```

**Dart:**
```dart
class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void introduce() {
    print('Hi, I\'m $name');
  }
}
```

### Python vs Dart

| Feature | Python | Dart |
|---------|--------|------|
| Type System | Dynamic | Static |
| Performance | Interpreted | Compiled |
| Null Safety | No | Yes |
| Async | async/await | async/await |

**Python:**
```python
def greet(name):
    return f"Hello, {name}!"

class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def introduce(self):
        print(f"Hi, I'm {self.name}")
```

**Dart:**
```dart
String greet(String name) => 'Hello, $name!';

class Person {
  String name;
  int age;
  
  Person(this.name, this.age);
  
  void introduce() {
    print('Hi, I\'m $name');
  }
}
```

---

## 8. Summary & Key Takeaways

### 5 Key Points About Dart Fundamentals

1. **Null Safety First**: Dart's null safety prevents null reference errors at compile time, making your code more reliable and reducing runtime crashes.

2. **Type Inference with Safety**: Dart combines the convenience of type inference (`var`) with the safety of static typing, giving you the best of both worlds.

3. **Everything is an Object**: Dart follows a pure object-oriented approach where everything, including numbers and functions, is an object.

4. **Rich Standard Library**: Dart provides comprehensive built-in support for collections, async programming, and common operations, reducing the need for external libraries.

5. **Flutter-Ready**: Dart is designed specifically for Flutter development, with features like hot reload and cross-platform compilation that make mobile app development efficient and enjoyable.

### Best Practices for Dart Development

- Use `var` for local variables when the type is obvious
- Prefer `final` over `var` when the value won't change
- Use `const` for compile-time constants
- Embrace null safety - use nullable types (`?`) only when necessary
- Leverage Dart's strong typing to catch errors early
- Use async/await for asynchronous operations
- Follow Dart's naming conventions (camelCase for variables, PascalCase for classes)

---

## 9. Exercises / Quiz

### Multiple Choice Questions

1. **What is the correct way to declare a variable that cannot be reassigned?**
   - a) `var x = 5;`
   - b) `final x = 5;`
   - c) `const x = 5;`
   - d) Both b and c

2. **Which operator is used for null-aware navigation?**
   - a) `?.`
   - b) `??`
   - c) `!`
   - d) `?.`

3. **What is the output of `print('Hello' + 'World');`?**
   - a) HelloWorld
   - b) Hello World
   - c) Compilation error
   - d) Runtime error

4. **Which collection type allows duplicate elements?**
   - a) Set
   - b) Map
   - c) List
   - d) None of the above

5. **What is the correct way to handle async operations in Dart?**
   - a) Only use callbacks
   - b) Only use async/await
   - c) Use either callbacks or async/await
   - d) Use only Future.then()

### True/False Questions

1. **Dart is a compiled language.** (True/False)
2. **All variables in Dart are nullable by default.** (True/False)
3. **Dart supports multiple inheritance through classes.** (True/False)
4. **The `main()` function is optional in Dart programs.** (True/False)
5. **Dart can be compiled to JavaScript for web development.** (True/False)

### Coding Exercises

**Exercise 1: Temperature Converter**
Write a function that converts Celsius to Fahrenheit and vice versa.

```dart
// Your code here
double celsiusToFahrenheit(double celsius) {
  // TODO: Implement conversion
}

double fahrenheitToCelsius(double fahrenheit) {
  // TODO: Implement conversion
}
```

**Exercise 2: List Operations**
Create a function that finds the second largest number in a list.

```dart
// Your code here
int findSecondLargest(List<int> numbers) {
  // TODO: Implement logic
}
```

**Exercise 3: Async Counter**
Create an async function that counts from 1 to 10 with a 1-second delay between each number.

```dart
// Your code here
Future<void> asyncCounter() async {
  // TODO: Implement async counting
}
```

### Answers

**Multiple Choice:**
1. d) Both b and c
2. a) `?.`
3. c) Compilation error (use string interpolation: `'Hello' + 'World'` or `'Hello$World'`)
4. c) List
5. c) Use either callbacks or async/await

**True/False:**
1. True
2. False (non-nullable by default)
3. False (uses mixins instead)
4. False (required entry point)
5. True

**Coding Solutions:**

```dart
// Exercise 1
double celsiusToFahrenheit(double celsius) {
  return (celsius * 9/5) + 32;
}

double fahrenheitToCelsius(double fahrenheit) {
  return (fahrenheit - 32) * 5/9;
}

// Exercise 2
int findSecondLargest(List<int> numbers) {
  if (numbers.length < 2) return numbers.first;
  
  numbers.sort();
  return numbers[numbers.length - 2];
}

// Exercise 3
Future<void> asyncCounter() async {
  for (int i = 1; i <= 10; i++) {
    print(i);
    await Future.delayed(Duration(seconds: 1));
  }
}
```

---

## Next Steps

Congratulations! You've completed the Dart fundamentals learning module. Here's what you can do next:

1. **Practice**: Try the exercises and mini-projects in this module
2. **Flutter**: Start learning Flutter to apply your Dart knowledge
3. **Advanced Topics**: Explore generics, isolates, and advanced OOP concepts
4. **Real Projects**: Build small applications to reinforce your learning
5. **Community**: Join Dart/Flutter communities for support and learning

Remember, the best way to learn Dart is by writing code and building projects. Start small, practice regularly, and gradually work your way up to more complex applications!
```
