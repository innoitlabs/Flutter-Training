import 'package:flutter/material.dart';
import 'dart:async';

class ExercisesScreen extends StatefulWidget {
  @override
  _ExercisesScreenState createState() => _ExercisesScreenState();
}

class _ExercisesScreenState extends State<ExercisesScreen> {
  int _currentExercise = 0;
  
  final List<Exercise> _exercises = [
    Exercise(
      title: 'Exercise 1: StatelessWidget Build Observation',
      difficulty: 'Easy',
      description: 'Create a StatelessWidget that prints a message in its build() method. Wrap it in a StatefulWidget that rebuilds it every second. Observe how often build() is called.',
      solution: 'BuildObserverWidget',
      color: Colors.green,
    ),
    Exercise(
      title: 'Exercise 2: Lifecycle Logging',
      difficulty: 'Intermediate',
      description: 'Add lifecycle logs to a StatefulWidget and describe the sequence of method calls when:\n• The widget is first created\n• setState() is called\n• The widget is removed from the tree',
      solution: 'LifecycleLoggerWidget',
      color: Colors.orange,
    ),
    Exercise(
      title: 'Exercise 3: Screen Switching Simulation',
      difficulty: 'Advanced',
      description: 'Create two different screens with StatefulWidgets. Implement navigation between them and observe the lifecycle events (deactivate, dispose, initState, etc.).',
      solution: 'ScreenSwitcher',
      color: Colors.red,
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Practice Exercises'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Exercise selector
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.indigo[50],
            child: Row(
              children: [
                Text(
                  'Exercise ${_currentExercise + 1} of ${_exercises.length}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo[800],
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: _currentExercise > 0
                      ? () => setState(() => _currentExercise--)
                      : null,
                  icon: Icon(Icons.chevron_left),
                ),
                IconButton(
                  onPressed: _currentExercise < _exercises.length - 1
                      ? () => setState(() => _currentExercise++)
                      : null,
                  icon: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
          
          // Exercise content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: _buildExerciseContent(_exercises[_currentExercise]),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildExerciseContent(Exercise exercise) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Exercise header
        Card(
          color: exercise.color.withValues(alpha: 0.1),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: exercise.color,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        exercise.difficulty,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      _getDifficultyIcon(exercise.difficulty),
                      color: exercise.color,
                      size: 24,
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  exercise.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: exercise.color.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        
        // Exercise description
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Description:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  exercise.description,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        
        // Interactive demo
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Interactive Demo:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                _buildExerciseDemo(exercise),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        
        // Solution
        Card(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Solution:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Click below to see the solution implementation:',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: () => _showSolution(exercise),
                  icon: Icon(Icons.code),
                  label: Text('View Solution'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: exercise.color,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        
        // Tips
        Card(
          color: Colors.blue[50],
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '💡 Tips:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                SizedBox(height: 8),
                _buildExerciseTips(exercise),
              ],
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildExerciseDemo(Exercise exercise) {
    switch (_currentExercise) {
      case 0:
        return _buildExercise1Demo();
      case 1:
        return _buildExercise2Demo();
      case 2:
        return _buildExercise3Demo();
      default:
        return Text('Demo not available');
    }
  }
  
  Widget _buildExercise1Demo() {
    return Column(
      children: [
        Text(
          'This demo shows a StatelessWidget being rebuilt by its parent:',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        BuildObserverDemo(),
      ],
    );
  }
  
  Widget _buildExercise2Demo() {
    return Column(
      children: [
        Text(
          'This demo shows a StatefulWidget with complete lifecycle logging:',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        LifecycleLoggerDemo(),
      ],
    );
  }
  
  Widget _buildExercise3Demo() {
    return Column(
      children: [
        Text(
          'This demo shows navigation between two screens:',
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 16),
        ScreenSwitcherDemo(),
      ],
    );
  }
  
  Widget _buildExerciseTips(Exercise exercise) {
    switch (_currentExercise) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Use print() statements in build() to observe rebuilds'),
            Text('• Notice that StatelessWidget has no state preservation'),
            Text('• Each rebuild creates a completely new widget instance'),
          ],
        );
      case 1:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Override all lifecycle methods with print statements'),
            Text('• Observe the order of method calls'),
            Text('• Notice when each method is triggered'),
          ],
        );
      case 2:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('• Use Navigator.push() and Navigator.pop()'),
            Text('• Observe deactivate() and dispose() when leaving screen'),
            Text('• Notice initState() when entering new screen'),
          ],
        );
      default:
        return Text('No tips available');
    }
  }
  
  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return Icons.sentiment_satisfied;
      case 'intermediate':
        return Icons.sentiment_neutral;
      case 'advanced':
        return Icons.sentiment_dissatisfied;
      default:
        return Icons.help;
    }
  }
  
  void _showSolution(Exercise exercise) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Solution: ${exercise.title}'),
        content: SingleChildScrollView(
          child: _buildSolutionCode(exercise),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSolutionCode(Exercise exercise) {
    switch (_currentExercise) {
      case 0:
        return _buildExercise1Solution();
      case 1:
        return _buildExercise2Solution();
      case 2:
        return _buildExercise3Solution();
      default:
        return Text('Solution not available');
    }
  }
  
  Widget _buildExercise1Solution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('StatelessWidget Solution:'),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'class BuildObserverWidget extends StatelessWidget {\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    print("BuildObserverWidget: build() called");\n'
            '    return Text("I am being rebuilt!");\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildExercise2Solution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('StatefulWidget Lifecycle Solution:'),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'class LifecycleLoggerWidget extends StatefulWidget {\n'
            '  @override\n'
            '  _LifecycleLoggerWidgetState createState() => _LifecycleLoggerWidgetState();\n'
            '}\n\n'
            'class _LifecycleLoggerWidgetState extends State<LifecycleLoggerWidget> {\n'
            '  @override\n'
            '  void initState() {\n'
            '    super.initState();\n'
            '    print("initState() called");\n'
            '  }\n\n'
            '  @override\n'
            '  void didChangeDependencies() {\n'
            '    super.didChangeDependencies();\n'
            '    print("didChangeDependencies() called");\n'
            '  }\n\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    print("build() called");\n'
            '    return Container();\n'
            '  }\n\n'
            '  @override\n'
            '  void dispose() {\n'
            '    print("dispose() called");\n'
            '    super.dispose();\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
  
  Widget _buildExercise3Solution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Screen Navigation Solution:'),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '// Screen 1\n'
            'class Screen1 extends StatefulWidget {\n'
            '  @override\n'
            '  _Screen1State createState() => _Screen1State();\n'
            '}\n\n'
            'class _Screen1State extends State<Screen1> {\n'
            '  @override\n'
            '  void initState() {\n'
            '    super.initState();\n'
            '    print("Screen1: initState()");\n'
            '  }\n\n'
            '  @override\n'
            '  void dispose() {\n'
            '    print("Screen1: dispose()");\n'
            '    super.dispose();\n'
            '  }\n\n'
            '  @override\n'
            '  Widget build(BuildContext context) {\n'
            '    return Scaffold(\n'
            '      appBar: AppBar(title: Text("Screen 1")),\n'
            '      body: ElevatedButton(\n'
            '        onPressed: () => Navigator.push(\n'
            '          context,\n'
            '          MaterialPageRoute(builder: (context) => Screen2()),\n'
            '        ),\n'
            '        child: Text("Go to Screen 2"),\n'
            '      ),\n'
            '    );\n'
            '  }\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class Exercise {
  final String title;
  final String difficulty;
  final String description;
  final String solution;
  final Color color;
  
  Exercise({
    required this.title,
    required this.difficulty,
    required this.description,
    required this.solution,
    required this.color,
  });
}

// Exercise 1 Demo: Build Observer
class BuildObserverDemo extends StatefulWidget {
  @override
  _BuildObserverDemoState createState() => _BuildObserverDemoState();
}

class _BuildObserverDemoState extends State<BuildObserverDemo> {
  Timer? _timer;
  int _rebuildCount = 0;
  
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _rebuildCount++;
      });
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Parent rebuilds: $_rebuildCount'),
        SizedBox(height: 16),
        BuildObserverWidget(),
      ],
    );
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}

class BuildObserverWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('🏗️  BuildObserverWidget: build() called at ${DateTime.now().toString().substring(11, 19)}');
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        'I am being rebuilt!',
        style: TextStyle(color: Colors.green[700]),
      ),
    );
  }
}

// Exercise 2 Demo: Lifecycle Logger
class LifecycleLoggerDemo extends StatefulWidget {
  @override
  _LifecycleLoggerDemoState createState() => _LifecycleLoggerDemoState();
}

class _LifecycleLoggerDemoState extends State<LifecycleLoggerDemo> {
  bool _showLogger = true;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              _showLogger = !_showLogger;
            });
          },
          child: Text(_showLogger ? 'Hide Logger' : 'Show Logger'),
        ),
        SizedBox(height: 16),
        if (_showLogger) LifecycleLoggerWidget(),
      ],
    );
  }
}

class LifecycleLoggerWidget extends StatefulWidget {
  @override
  _LifecycleLoggerWidgetState createState() => _LifecycleLoggerWidgetState();
}

class _LifecycleLoggerWidgetState extends State<LifecycleLoggerWidget> {
  int _counter = 0;
  
  @override
  void initState() {
    super.initState();
    print('🎯 LifecycleLoggerWidget: initState() called');
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🔗 LifecycleLoggerWidget: didChangeDependencies() called');
  }
  
  @override
  Widget build(BuildContext context) {
    print('🏗️  LifecycleLoggerWidget: build() called');
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Text(
            'Lifecycle Logger Widget',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.orange[700],
            ),
          ),
          SizedBox(height: 8),
          Text('Counter: $_counter'),
          SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
              print('👆 setState() called - counter increased to $_counter');
            },
            child: Text('Increment'),
          ),
        ],
      ),
    );
  }
  
  @override
  void dispose() {
    print('🗑️  LifecycleLoggerWidget: dispose() called');
    super.dispose();
  }
}

// Exercise 3 Demo: Screen Switcher
class ScreenSwitcherDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Navigate between screens to observe lifecycle:'),
        SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ExerciseScreen1()),
            );
          },
          child: Text('Go to Screen 1'),
        ),
      ],
    );
  }
}

class ExerciseScreen1 extends StatefulWidget {
  @override
  _ExerciseScreen1State createState() => _ExerciseScreen1State();
}

class _ExerciseScreen1State extends State<ExerciseScreen1> {
  @override
  void initState() {
    super.initState();
    print('🎯 ExerciseScreen1: initState() called');
  }
  
  @override
  void dispose() {
    print('🗑️  ExerciseScreen1: dispose() called');
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Screen 1'),
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Screen 1',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ExerciseScreen2()),
                );
              },
              child: Text('Go to Screen 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class ExerciseScreen2 extends StatefulWidget {
  @override
  _ExerciseScreen2State createState() => _ExerciseScreen2State();
}

class _ExerciseScreen2State extends State<ExerciseScreen2> {
  @override
  void initState() {
    super.initState();
    print('🎯 ExerciseScreen2: initState() called');
  }
  
  @override
  void dispose() {
    print('🗑️  ExerciseScreen2: dispose() called');
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Screen 2'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Screen 2',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}
