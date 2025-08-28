import 'package:flutter/material.dart';
import 'dart:async';

class DataFetchingDemo extends StatefulWidget {
  @override
  _DataFetchingDemoState createState() => _DataFetchingDemoState();
}

class _DataFetchingDemoState extends State<DataFetchingDemo> {
  String _data = 'Initial state';
  bool _isLoading = false;
  String _error = '';
  int _fetchCount = 0;
  
  @override
  void initState() {
    super.initState();
    print('🎯 DataFetchingDemo: initState() called');
    print('   - Starting initial data fetch');
    
    // Start initial data fetch
    _fetchData();
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('🔗 DataFetchingDemo: didChangeDependencies() called');
    print('   - Dependencies have changed');
  }
  
  Future<void> _fetchData() async {
    print('📡 Starting data fetch #${_fetchCount + 1}');
    
    setState(() {
      _isLoading = true;
      _error = '';
    });
    
    try {
      // Simulate API call with random delay
      final delay = Duration(seconds: 1 + (_fetchCount % 3));
      print('   - Simulating API call with ${delay.inSeconds}s delay');
      
      await Future.delayed(delay);
      
      // Simulate random success/failure
      final success = _fetchCount % 4 != 0; // 75% success rate
      
      if (mounted) { // Check if widget is still in tree
        setState(() {
          _fetchCount++;
          _isLoading = false;
          
          if (success) {
            _data = 'Data loaded successfully! (Fetch #$_fetchCount)';
            print('✅ Data fetch #$_fetchCount completed successfully');
          } else {
            _error = 'Failed to load data (Fetch #$_fetchCount)';
            print('❌ Data fetch #$_fetchCount failed');
          }
        });
      } else {
        print('⚠️  Widget was disposed during data fetch');
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _error = 'Error: $e';
        });
        print('❌ Data fetch error: $e');
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    print('🏗️  DataFetchingDemo: build() called');
    print('   - Current state: ${_isLoading ? "Loading" : _error.isNotEmpty ? "Error" : "Success"}');
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Fetching Lifecycle'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: _isLoading ? null : _fetchData,
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
              color: Colors.green[50],
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Data Fetching Status',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green[800],
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Fetch count: $_fetchCount',
                      style: TextStyle(color: Colors.green[600]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Main content area
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isLoading) ...[
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Loading data...',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.green[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Check console for lifecycle logs',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ] else if (_error.isNotEmpty) ...[
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Error',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _error,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.red[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ] else ...[
                        Icon(
                          Icons.check_circle_outline,
                          size: 64,
                          color: Colors.green[400],
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Success!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.green[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          _data,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.green[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            
            // Control buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _fetchData,
                    icon: Icon(Icons.cloud_download),
                    label: Text('Fetch Data'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      setState(() {
                        _fetchCount = 0;
                        _data = 'Reset to initial state';
                        _error = '';
                      });
                      print('🔄 Reset: Data state reset');
                    },
                    icon: Icon(Icons.refresh),
                    label: Text('Reset'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            
            // Lifecycle explanation
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Key Lifecycle Concepts:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    _buildConceptItem(
                      'initState()',
                      'Start async operations like API calls',
                      Icons.play_arrow,
                    ),
                    _buildConceptItem(
                      'mounted check',
                      'Verify widget is still active before setState',
                      Icons.check_circle,
                    ),
                    _buildConceptItem(
                      'dispose()',
                      'Cancel ongoing operations to prevent memory leaks',
                      Icons.stop,
                    ),
                    SizedBox(height: 12),
                    Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '💡 Best Practice: Always check mounted before setState in async operations!',
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildConceptItem(String title, String description, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.green[600],
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
  
  @override
  void deactivate() {
    print('🚪 DataFetchingDemo: deactivate() called');
    print('   - Widget is being removed from the tree');
    super.deactivate();
  }
  
  @override
  void dispose() {
    print('🗑️  DataFetchingDemo: dispose() called');
    print('   - Widget is permanently removed');
    print('   - Any ongoing operations should be cancelled here');
    super.dispose();
  }
}
