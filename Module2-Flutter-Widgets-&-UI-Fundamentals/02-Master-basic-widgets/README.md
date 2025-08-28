# Mastering Flutter Basic Widgets

## Learning Objectives

By the end of this module, you will be able to:

1. **Understand Flutter's widget-based architecture** and why everything in Flutter is a widget
2. **Master Text widget** for displaying and styling text content
3. **Use Container widget** for layout, padding, margins, borders, and background styling
4. **Implement Row and Column widgets** for horizontal and vertical layouts
5. **Create overlapping layouts** using Stack widget with positioning
6. **Control flex layouts** using Expanded widget within Row/Column
7. **Combine multiple widgets** to build complete UI layouts

---

## 1. Introduction to Widgets

### What are Widgets?

In Flutter, **everything is a widget**. Widgets are the building blocks of Flutter applications - they describe what their view should look like given their current configuration and state.

```
Widget Tree Concept:
┌─────────────────────────────────────┐
│           MyApp (Root)              │
├─────────────────────────────────────┤
│         MaterialApp                 │
├─────────────────────────────────────┤
│           Scaffold                  │
├─────────────────────────────────────┤
│    AppBar    │    Body              │
│              │                      │
│              │  ┌─────────────────┐ │
│              │  │   Container     │ │
│              │  │  ┌─────────────┐│ │
│              │  │  │    Text     ││ │
│              │  │  └─────────────┘│ │
│              │  └─────────────────┘ │
└─────────────────────────────────────┘
```

### Stateless vs Stateful Widgets

- **StatelessWidget**: Widgets that don't change over time (like Text, Container)
- **StatefulWidget**: Widgets that can change their state (we'll learn these later)

For basic widgets, we'll focus on StatelessWidgets as they're simpler and perfect for static UI elements.

---

## 2. Text Widget

The Text widget is used to display a string of text with single style.

### Basic Text Display

```dart
Text('Hello Flutter!')
```

### Styled Text

```dart
Text(
  'Welcome to Flutter',
  style: TextStyle(
    fontSize: 24.0,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  ),
)
```

### Complete Example: Heading and Subtitle

```dart
Column(
  children: [
    Text(
      'Flutter Basics',
      style: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    ),
    SizedBox(height: 8.0), // Spacing
    Text(
      'Learn the fundamentals of Flutter widgets',
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.grey[600],
        fontStyle: FontStyle.italic,
      ),
    ),
  ],
)
```

**Expected Output:**
```
┌─────────────────────────────────────┐
│           Flutter Basics            │
│                                     │
│    Learn the fundamentals of        │
│    Flutter widgets                  │
└─────────────────────────────────────┘
```

---

## 3. Container Widget

Container is a versatile widget that combines common painting, positioning, and sizing widgets.

### Container as a Box

Think of Container as a box that can have:
- **Size** (width, height)
- **Padding** (internal spacing)
- **Margin** (external spacing)
- **Border** (outline)
- **Background** (color, gradient, image)

### Basic Container

```dart
Container(
  width: 200.0,
  height: 100.0,
  color: Colors.blue,
  child: Text('Hello Container!'),
)
```

### Styled Container with Decoration

```dart
Container(
  width: 200.0,
  height: 100.0,
  padding: EdgeInsets.all(16.0),
  margin: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    color: Colors.orange,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 5,
        offset: Offset(0, 3),
      ),
    ],
  ),
  child: Text(
    'Styled Container',
    style: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    ),
  ),
)
```

**Expected Output:**
```
┌─────────────────────────────────────┐
│                                     │
│    ┌─────────────────────────────┐  │
│    │      Styled Container       │  │
│    └─────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

---

## 4. Row & Column Widgets

Row and Column are layout widgets that arrange their children in a horizontal or vertical line.

### Row Widget (Horizontal Layout)

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Icon(Icons.star, color: Colors.yellow),
    Text('5.0'),
    Text('(120 reviews)'),
  ],
)
```

### Column Widget (Vertical Layout)

```dart
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text('Product Name', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Product Description'),
    Text('\$29.99', style: TextStyle(fontSize: 18, color: Colors.green)),
  ],
)
```

### MainAxisAlignment vs CrossAxisAlignment

```
Row MainAxisAlignment:
┌─────────────────────────────────────┐
│ start    center    end    spaceEvenly│
│ [A][B]   [A][B]   [A][B]   [A] [B]  │
└─────────────────────────────────────┘

Column CrossAxisAlignment:
┌─────────────────────────────────────┐
│ start:                              │
│ [A]                                 │
│ [B]                                 │
│                                     │
│ center:                             │
│    [A]                              │
│    [B]                              │
└─────────────────────────────────────┘
```

### Example: Profile Card

```dart
Container(
  padding: EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.0),
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 1,
        blurRadius: 5,
      ),
    ],
  ),
  child: Row(
    children: [
      // Profile Image
      Container(
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.person, color: Colors.white, size: 30.0),
      ),
      SizedBox(width: 16.0), // Spacing
      // Profile Info
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Doe',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Flutter Developer',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    ],
  ),
)
```

**Expected Output:**
```
┌─────────────────────────────────────┐
│  ○    John Doe                      │
│       Flutter Developer             │
└─────────────────────────────────────┘
```

---

## 5. Stack Widget

Stack allows you to overlay multiple widgets on top of each other.

### Basic Stack

```dart
Stack(
  children: [
    // Background
    Container(
      width: 300.0,
      height: 200.0,
      color: Colors.blue,
    ),
    // Overlay text
    Positioned(
      bottom: 20.0,
      left: 20.0,
      child: Text(
        'Overlay Text',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ],
)
```

### Example: Banner with Text Overlay

```dart
Stack(
  children: [
    // Background image/container
    Container(
      width: 300.0,
      height: 150.0,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
    ),
    // Overlay text
    Positioned(
      top: 20.0,
      left: 20.0,
      child: Text(
        'Special Offer!',
        style: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
    // Button overlay
    Positioned(
      bottom: 20.0,
      right: 20.0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Text(
          'Learn More',
          style: TextStyle(
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  ],
)
```

**Expected Output:**
```
┌─────────────────────────────────────┐
│ Special Offer!              [Learn] │
│                                     │
│                                     │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

---

## 6. Expanded Widget

Expanded is used to make a child of a Row or Column expand to fill the available space.

### How Expanded Works

```
Without Expanded:
┌─────────────────────────────────────┐
│ [A][B][C]                          │
└─────────────────────────────────────┘

With Expanded on B:
┌─────────────────────────────────────┐
│ [A][        B        ][C]          │
└─────────────────────────────────────┘
```

### Basic Expanded Example

```dart
Row(
  children: [
    Container(
      width: 50.0,
      height: 50.0,
      color: Colors.red,
    ),
    Expanded(
      child: Container(
        height: 50.0,
        color: Colors.green,
        child: Center(child: Text('Expanded')),
      ),
    ),
    Container(
      width: 50.0,
      height: 50.0,
      color: Colors.blue,
    ),
  ],
)
```

### Flex Property Example

```dart
Row(
  children: [
    Expanded(
      flex: 1, // Takes 1 part of space
      child: Container(
        height: 50.0,
        color: Colors.red,
        child: Center(child: Text('1')),
      ),
    ),
    Expanded(
      flex: 2, // Takes 2 parts of space (double width)
      child: Container(
        height: 50.0,
        color: Colors.green,
        child: Center(child: Text('2')),
      ),
    ),
    Expanded(
      flex: 1, // Takes 1 part of space
      child: Container(
        height: 50.0,
        color: Colors.blue,
        child: Center(child: Text('1')),
      ),
    ),
  ],
)
```

**Expected Output:**
```
┌─────────────────────────────────────┐
│ [1][        2        ][1]          │
└─────────────────────────────────────┘
```

---

## 7. Putting It All Together

Let's build a complete demo screen that combines all these widgets:

```dart
class WidgetDemoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Widgets Demo'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.deepPurple, Colors.purple],
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Text(
                    'Flutter Widgets',
                    style: TextStyle(
                      fontSize: 28.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Master the basics',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Profile Card Section
            Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 60.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: Colors.white, size: 30.0),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Flutter Developer',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Building amazing apps',
                          style: TextStyle(
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.grey),
                ],
              ),
            ),
            
            SizedBox(height: 24.0),
            
            // Stats Section with Expanded
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(right: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.green[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '150',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[800],
                          ),
                        ),
                        Text(
                          'Projects',
                          style: TextStyle(color: Colors.green[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '4.9',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                        Text(
                          'Rating',
                          style: TextStyle(color: Colors.blue[700]),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.only(left: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.orange[100],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '2.5K',
                          style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                        Text(
                          'Downloads',
                          style: TextStyle(color: Colors.orange[700]),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 24.0),
            
            // Stack Banner Section
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.purple, Colors.pink],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                Positioned(
                  top: 20.0,
                  left: 20.0,
                  child: Text(
                    'Special Offer!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 50.0,
                  left: 20.0,
                  child: Text(
                    'Get 50% off on Flutter courses',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 20.0,
                  right: 20.0,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Text(
                      'Claim Now',
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
```

**Expected Output:**
```
┌─────────────────────────────────────┐
│        Flutter Widgets              │
│        Master the basics            │
│                                     │
│  ○    Flutter Developer    >        │
│       Building amazing apps         │
│                                     │
│ [150] [4.9] [2.5K]                 │
│ Projects Rating Downloads           │
│                                     │
│ Special Offer!              [Claim] │
│ Get 50% off on Flutter courses      │
└─────────────────────────────────────┘
```

---

## 8. Exercises

### Exercise 1: Basic Text Styling (Easy)
Create a Text widget that displays "Hello Flutter" with:
- Font size of 24
- Blue color
- Bold weight

**Solution:**
```dart
Text(
  'Hello Flutter',
  style: TextStyle(
    fontSize: 24.0,
    color: Colors.blue,
    fontWeight: FontWeight.bold,
  ),
)
```

### Exercise 2: Profile Card (Intermediate)
Create a card with:
- A circular avatar (use Container with shape: BoxShape.circle)
- Name and title in a Column
- Arrange them horizontally using Row

**Solution:**
```dart
Container(
  padding: EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5),
    ],
  ),
  child: Row(
    children: [
      Container(
        width: 50.0,
        height: 50.0,
        decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.person, color: Colors.white),
      ),
      SizedBox(width: 16.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Developer'),
        ],
      ),
    ],
  ),
)
```

### Exercise 3: Responsive Layout (Advanced)
Build a layout with:
- Header with title
- Three sections in a Row using Expanded
- A Stack overlay with a floating action button

**Solution:**
```dart
Column(
  children: [
    // Header
    Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      color: Colors.blue,
      child: Text(
        'My App',
        style: TextStyle(color: Colors.white, fontSize: 20.0),
      ),
    ),
    
    // Content with Expanded sections
    Expanded(
      child: Row(
        children: [
          Expanded(
            child: Container(
              color: Colors.red[100],
              child: Center(child: Text('Section 1')),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.green[100],
              child: Center(child: Text('Section 2')),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue[100],
              child: Center(child: Text('Section 3')),
            ),
          ),
        ],
      ),
    ),
    
    // Stack with floating button
    Stack(
      children: [
        Container(height: 100.0, color: Colors.grey[200]),
        Positioned(
          right: 20.0,
          bottom: 20.0,
          child: Container(
            width: 56.0,
            height: 56.0,
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    ),
  ],
)
```

---

## 9. Summary

### Key Takeaways

1. **Widgets are Everything**: Every UI element in Flutter is a widget, forming a widget tree.

2. **Text Widget**: Displays strings with customizable styling using TextStyle.

3. **Container Widget**: Versatile box for layout, styling, padding, margins, and decoration.

4. **Row & Column**: Layout widgets for horizontal and vertical arrangements with alignment control.

5. **Stack Widget**: Creates overlapping layouts with precise positioning using Positioned.

6. **Expanded Widget**: Controls how widgets share available space in Row/Column using flex.

### Widget Combination Patterns

- **Text + Container**: Styled text boxes
- **Row + Column**: Complex layouts
- **Container + Row/Column**: Styled layout sections
- **Stack + Positioned**: Overlay effects
- **Expanded + Row/Column**: Responsive layouts

### Best Practices

1. **Use meaningful widget names** in your code for better readability
2. **Group related widgets** in Containers for better organization
3. **Use SizedBox** for consistent spacing
4. **Apply consistent styling** with reusable decoration patterns
5. **Test layouts** on different screen sizes

### Next Steps

Now that you've mastered basic widgets, you can explore:
- **StatefulWidgets** for interactive UI
- **ListView** for scrollable lists
- **GestureDetector** for user interactions
- **Custom widgets** for reusable components
- **Theme and styling** for consistent app design

---

## 10. Practice Projects

1. **Personal Profile App**: Create a profile screen using all basic widgets
2. **Product Card**: Design a product card with image, title, price, and rating
3. **Dashboard Layout**: Build a dashboard with multiple sections and stats
4. **News Article**: Create an article layout with header, content, and metadata

Remember: The best way to learn Flutter widgets is through practice. Start with simple layouts and gradually build more complex ones!

