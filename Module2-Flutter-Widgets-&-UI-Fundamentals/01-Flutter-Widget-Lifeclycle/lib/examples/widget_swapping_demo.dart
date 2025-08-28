import 'package:flutter/material.dart';
import 'dart:async';

class WidgetSwappingDemo extends StatefulWidget {
  @override
  _WidgetSwappingDemoState createState() => _WidgetSwappingDemoState();
}

class _WidgetSwappingDemoState extends State<WidgetSwappingDemo> {
  bool _showFirstWidget = true;
  int _swapCount = 0;
  Timer? _autoSwapTimer;
  
  @override
  void initState() {
    super.initState();
    print('🎯 WidgetSwappingDemo: initState() called');
    print('   - Starting auto-swap timer');
    
    // Auto-swap widgets every 5 seconds
    _autoSwapTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      if (mounted) {
        setState(() {
          _showFirstWidget = !_showFirstWidget;
          _swapCount++;
        });
        print('🔄 Auto-swap: Switched to ${_showFirstWidget ? "Widget A" : "Widget B"} (Swap #$_swapCount)');
      }
    });
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🔗 WidgetSwappingDemo: didChangeDependencies() called');
  }
  
  @override
  Widget build(BuildContext context) {
    print('🏗️  WidgetSwappingDemo: build() called');
    print('   - Currently showing: ${_showFirstWidget ? "Widget A" : "Widget B"}');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget Swapping Demo'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showSwappingInfo,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Status card
            Card(
              color: Colors.purple[50],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Widget Swapping Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Swap count: $_swapCount | Auto-swap every 5s',
                      style: TextStyle(color: Colors.purple[600]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Current widget display
            Container(
              height: 200,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.purple, width: 2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: _showFirstWidget
                  ? SwappableWidget(
                      title: 'Widget A',
                      color: Colors.blue,
                      icon: Icons.star,
                    )
                  : SwappableWidget(
                      title: 'Widget B',
                      color: Colors.green,
                      icon: Icons.favorite,
                    ),
            ),
            SizedBox(height: 20),
            
            // Control buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _showFirstWidget = !_showFirstWidget;
                        _swapCount++;
                      });
                      print('👆 Manual swap: Switched to ${_showFirstWidget ? "Widget A" : "Widget B"} (Swap #$_swapCount)');
                    },
                    icon: Icon(Icons.swap_horiz),
                    label: Text('Manual Swap'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _swapCount = 0;
                      });
                      print('🔄 Reset: Swap count reset to 0');
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Reset Count'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            
            // Lifecycle explanation
            Expanded(
              child: SingleChildScrollView(
                child: Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Widget Lifecycle During Swapping:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildLifecycleStep(
                          '1. Widget Removal',
                          'deactivate() → dispose()',
                          'Widget is removed from tree',
                          Icons.remove_circle,
                          Colors.red,
                        ),
                        _buildLifecycleStep(
                          '2. Widget Creation',
                          'createState() → initState()',
                          'New widget is created',
                          Icons.add_circle,
                          Colors.green,
                        ),
                        _buildLifecycleStep(
                          '3. Widget Building',
                          'didChangeDependencies() → build()',
                          'New widget builds its UI',
                          Icons.build,
                          Colors.blue,
                        ),
                        SizedBox(height: 16),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.yellow.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                                                            border: Border.all(color: Colors.yellow.withValues(alpha: 0.3)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '💡 Key Insight:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange.withValues(alpha: 0.8),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'When widgets are swapped, the old widget is completely disposed and a new one is created. This demonstrates the immutable nature of Flutter widgets.',
                                style: TextStyle(
                                  color: Colors.orange.withValues(alpha: 0.7),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Expected Console Output:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Widget A: deactivate()\n'
                            'Widget A: dispose()\n'
                            'Widget B: initState()\n'
                            'Widget B: didChangeDependencies()\n'
                            'Widget B: build()',
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 12,
                              color: Colors.grey.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildLifecycleStep(
    String title,
    String methods,
    String description,
    IconData icon,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 24,
            color: color,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: color.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  methods,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  void _showSwappingInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Widget Swapping'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('When widgets are swapped in Flutter:'),
              SizedBox(height: 12),
              Text('• The old widget is completely removed from the tree'),
              Text('• All its lifecycle methods are called (deactivate, dispose)'),
              Text('• A new widget instance is created'),
              Text('• The new widget goes through its full lifecycle'),
              SizedBox(height: 12),
              Text(
                'This demonstrates Flutter\'s immutable widget model!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
  
  @override
  void deactivate() {
    print('🚪 WidgetSwappingDemo: deactivate() called');
    super.deactivate();
  }
  
  @override
  void dispose() {
    print('🗑️  WidgetSwappingDemo: dispose() called');
    _autoSwapTimer?.cancel();
    super.dispose();
  }
}

// Swappable widget that logs its lifecycle
class SwappableWidget extends StatefulWidget {
  final String title;
  final Color color;
  final IconData icon;
  
  const SwappableWidget({
    Key? key,
    required this.title,
    required this.color,
    required this.icon,
  }) : super(key: key);
  
  @override
  _SwappableWidgetState createState() => _SwappableWidgetState();
}

class _SwappableWidgetState extends State<SwappableWidget> {
  int _internalCounter = 0;
  Timer? _timer;
  
  @override
  void initState() {
    super.initState();
    print('🎯 ${widget.title}: initState() called');
    print('   - Widget ${widget.title} is being created');
    
    // Start internal timer
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      if (mounted) {
        setState(() {
          _internalCounter++;
        });
        print('🔄 ${widget.title}: Internal counter: $_internalCounter');
      }
    });
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🔗 ${widget.title}: didChangeDependencies() called');
  }
  
  @override
  void didUpdateWidget(SwappableWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('📝 ${widget.title}: didUpdateWidget() called');
    print('   - Old title: ${oldWidget.title}');
    print('   - New title: ${widget.title}');
  }
  
  @override
  Widget build(BuildContext context) {
    print('🏗️  ${widget.title}: build() called');
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            widget.icon,
            size: 48,
            color: widget.color,
          ),
          SizedBox(height: 12),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Counter: $_internalCounter',
            style: TextStyle(
              fontSize: 16,
              color: widget.color.withValues(alpha: 0.6),
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Check console for logs',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  void deactivate() {
    print('🚪 ${widget.title}: deactivate() called');
    print('   - Widget ${widget.title} is being removed from tree');
    super.deactivate();
  }
  
  @override
  void dispose() {
    print('🗑️  ${widget.title}: dispose() called');
    print('   - Widget ${widget.title} is being permanently removed');
    print('   - Cleaning up timer for ${widget.title}');
    _timer?.cancel();
    super.dispose();
  }
}
