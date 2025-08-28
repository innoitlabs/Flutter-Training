import 'package:flutter/material.dart';
import 'battery_channel.dart';

class BatteryPage extends StatefulWidget {
  const BatteryPage({super.key});

  @override
  State<BatteryPage> createState() => _BatteryPageState();
}

class _BatteryPageState extends State<BatteryPage> {
  int _batteryLevel = -1;
  Map<String, dynamic> _batteryInfo = {};
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _getBatteryLevel();
  }

  /// Get battery level using platform channel
  Future<void> _getBatteryLevel() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final batteryLevel = await BatteryChannel.getBatteryLevel();
      setState(() {
        _batteryLevel = batteryLevel;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get battery level: $e';
        _isLoading = false;
      });
    }
  }

  /// Get detailed battery information
  Future<void> _getBatteryInfo() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final batteryInfo = await BatteryChannel.getBatteryInfo();
      setState(() {
        _batteryInfo = batteryInfo;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get battery info: $e';
        _isLoading = false;
      });
    }
  }

  /// Get battery level color based on percentage
  Color _getBatteryColor(int level) {
    if (level < 0) return Colors.grey;
    if (level < 20) return Colors.red;
    if (level < 50) return Colors.orange;
    if (level < 80) return Colors.yellow;
    return Colors.green;
  }

  /// Get battery icon based on level
  IconData _getBatteryIcon(int level) {
    if (level < 0) return Icons.battery_unknown;
    if (level < 10) return Icons.battery_alert;
    if (level < 20) return Icons.battery_0_bar;
    if (level < 30) return Icons.battery_1_bar;
    if (level < 50) return Icons.battery_2_bar;
    if (level < 70) return Icons.battery_3_bar;
    if (level < 90) return Icons.battery_4_bar;
    return Icons.battery_full;
  }

  /// Get battery status text
  String _getBatteryStatusText(int level) {
    if (level < 0) return 'Unknown';
    if (level < 20) return 'Critical';
    if (level < 50) return 'Low';
    if (level < 80) return 'Medium';
    return 'Good';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Battery Level'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _getBatteryLevel,
            tooltip: 'Refresh battery level',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Platform Channel Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Get battery level from native platform code',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),

            // Battery level card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    // Battery icon
                    Icon(
                      _getBatteryIcon(_batteryLevel),
                      size: 80,
                      color: _getBatteryColor(_batteryLevel),
                    ),
                    const SizedBox(height: 16),

                    // Battery level display
                    if (_isLoading)
                      const CircularProgressIndicator()
                    else if (_batteryLevel >= 0) ...[
                      Text(
                        '$_batteryLevel%',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: _getBatteryColor(_batteryLevel),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getBatteryStatusText(_batteryLevel),
                        style: TextStyle(
                          fontSize: 18,
                          color: _getBatteryColor(_batteryLevel),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ] else ...[
                      const Text(
                        'Unknown',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Unable to get battery level',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _getBatteryLevel,
                    icon: const Icon(Icons.battery_full),
                    label: const Text('Get Battery Level'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isLoading ? null : _getBatteryInfo,
                    icon: const Icon(Icons.info),
                    label: const Text('Get Battery Info'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Battery info display
            if (_batteryInfo.isNotEmpty) ...[
              const Text(
                'Battery Information',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      _buildInfoRow('Level', '${_batteryInfo['level'] ?? 'Unknown'}%'),
                      _buildInfoRow('Charging', _batteryInfo['isCharging'] == true ? 'Yes' : 'No'),
                      _buildInfoRow('Plugged In', _batteryInfo['isPluggedIn'] == true ? 'Yes' : 'No'),
                      if (_batteryInfo['error'] != null)
                        _buildInfoRow('Error', _batteryInfo['error']),
                    ],
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Platform channel explanation
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'How Platform Channels Work',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      '1. Flutter calls native code via MethodChannel\n'
                      '2. Native iOS/Android code executes\n'
                      '3. Result is returned to Flutter\n'
                      '4. UI updates with the result',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'MethodChannel: samples.flutter.dev/battery\n'
                        'Method: getBatteryLevel()',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Error display
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Card(
                color: Colors.red[50],
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const Icon(Icons.error, color: Colors.red),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// Build info row for battery information
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
