import 'package:flutter/material.dart';
import 'dart:async';

class CounterLifecycleDemo extends StatefulWidget {
  @override
  _CounterLifecycleDemoState createState() => _CounterLifecycleDemoState();
}

class _CounterLifecycleDemoState extends State<CounterLifecycleDemo> {
  int _counter = 0;
  bool _showCounter = true;
  Timer? _autoIncrementTimer;
  
  @override
  void initState() {
    super.initState();
    print('🎯 CounterLifecycleDemo: initState() called');
    print('   - Widget is being initialized');
    print('   - Perfect place for one-time setup');
    
    // Start auto-increment timer to demonstrate setState
    _autoIncrementTimer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          _counter++;
        });
        print('🔄 Auto-increment: Counter increased to $_counter');
      }
    });
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🔗 CounterLifecycleDemo: didChangeDependencies() called');
    print('   - Called after initState() and when dependencies change');
    print('   - Good place to subscribe to inherited widgets');
  }
  
  @override
  Widget build(BuildContext context) {
    print('🏗️  CounterLifecycleDemo: build() called');
    print('   - Building UI with counter: $_counter');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter Lifecycle Demo'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.info),
            onPressed: _showLifecycleInfo,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Lifecycle status card
            Card(
              color: Colors.blue[50],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Widget Lifecycle Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Check console for detailed lifecycle logs',
                      style: TextStyle(color: Colors.blue[600]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Counter widget (conditionally shown)
            if (_showCounter) ...[
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Text(
                      'Counter Widget',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '$_counter',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[600],
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _counter++;
                            });
                            print('👆 Manual increment: Counter increased to $_counter');
                          },
                          child: Text('Increment'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _counter = 0;
                            });
                            print('🔄 Reset: Counter reset to 0');
                          },
                          child: Text('Reset'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
            
            // Control buttons
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _showCounter = !_showCounter;
                });
                print('👁️  Toggle counter visibility: $_showCounter');
              },
              icon: Icon(_showCounter ? Icons.visibility_off : Icons.visibility),
              label: Text(_showCounter ? 'Hide Counter' : 'Show Counter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 12),
            
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
                          'Lifecycle Methods Observed:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 12),
                        _buildLifecycleItem('initState()', 'One-time initialization'),
                        _buildLifecycleItem('didChangeDependencies()', 'Dependency changes'),
                        _buildLifecycleItem('build()', 'UI construction'),
                        _buildLifecycleItem('setState()', 'Trigger rebuilds'),
                        _buildLifecycleItem('deactivate()', 'Widget removal'),
                        _buildLifecycleItem('dispose()', 'Final cleanup'),
                        SizedBox(height: 16),
                        Text(
                          '💡 Tip: Open the console to see detailed lifecycle logs!',
                          style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w500,
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
  
  Widget _buildLifecycleItem(String method, String description) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 8,
            height: 8,
            margin: EdgeInsets.only(top: 6, right: 8),
            decoration: BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  method,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: 'monospace',
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
  
  void _showLifecycleInfo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Widget Lifecycle'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('The widget lifecycle consists of several phases:'),
              SizedBox(height: 12),
              Text('1. Creation: createState(), initState()'),
              Text('2. Dependencies: didChangeDependencies()'),
              Text('3. Building: build()'),
              Text('4. Updates: setState(), didUpdateWidget()'),
              Text('5. Cleanup: deactivate(), dispose()'),
              SizedBox(height: 12),
              Text(
                'Check the console for real-time logs of these methods!',
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
    print('🚪 CounterLifecycleDemo: deactivate() called');
    print('   - Widget is being removed from the tree');
    print('   - Might be reinserted later');
    super.deactivate();
  }
  
  @override
  void dispose() {
    print('🗑️  CounterLifecycleDemo: dispose() called');
    print('   - Widget is permanently removed');
    print('   - Cleaning up resources');
    _autoIncrementTimer?.cancel();
    super.dispose();
  }
}
