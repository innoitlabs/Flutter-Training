import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Position? _currentPosition;
  StreamSubscription<Position>? _positionStream;
  bool _isListening = false;
  bool _isLoading = false;
  String? _errorMessage;
  List<Position> _locationHistory = [];

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  /// Check location permission and service status
  Future<void> _checkLocationPermission() async {
    setState(() => _isLoading = true);
    
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _errorMessage = 'Location services are disabled. Please enable GPS.';
          _isLoading = false;
        });
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() {
            _errorMessage = 'Location permission denied';
            _isLoading = false;
          });
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() {
          _errorMessage = 'Location permissions are permanently denied. Please enable in settings.';
          _isLoading = false;
        });
        return;
      }

      setState(() => _isLoading = false);
    } catch (e) {
      setState(() {
        _errorMessage = 'Error checking location permission: $e';
        _isLoading = false;
      });
    }
  }

  /// Get current location once
  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);
    
    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );
      
      setState(() {
        _currentPosition = position;
        _isLoading = false;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to get current location: $e';
        _isLoading = false;
      });
    }
  }

  /// Start listening to location updates
  Future<void> _startLocationUpdates() async {
    if (_isListening) return;

    try {
      const LocationSettings locationSettings = LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      );

      _positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings,
      ).listen(
        (Position position) {
          setState(() {
            _currentPosition = position;
            _locationHistory.add(position);
            
            // Keep only last 10 locations
            if (_locationHistory.length > 10) {
              _locationHistory.removeAt(0);
            }
          });
        },
        onError: (error) {
          setState(() {
            _errorMessage = 'Location stream error: $error';
            _isListening = false;
          });
        },
      );

      setState(() {
        _isListening = true;
        _errorMessage = null;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to start location updates: $e';
      });
    }
  }

  /// Stop listening to location updates
  void _stopLocationUpdates() {
    _positionStream?.cancel();
    setState(() {
      _isListening = false;
    });
  }

  /// Clear location history
  void _clearHistory() {
    setState(() {
      _locationHistory.clear();
    });
  }

  /// Format coordinates for display
  String _formatCoordinates(Position position) {
    return '${position.latitude.toStringAsFixed(6)}, ${position.longitude.toStringAsFixed(6)}';
  }

  /// Format timestamp for display
  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
  }

  /// Calculate distance between two positions
  double _calculateDistance(Position? pos1, Position? pos2) {
    if (pos1 == null || pos2 == null) return 0;
    return Geolocator.distanceBetween(
      pos1.latitude,
      pos1.longitude,
      pos2.latitude,
      pos2.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_locationHistory.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.clear_all),
              onPressed: _clearHistory,
              tooltip: 'Clear history',
            ),
        ],
      ),
      body: _errorMessage != null
          ? _buildErrorView()
          : _buildLocationView(),
    );
  }

  /// Build error view when location services fail
  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.location_off,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _checkLocationPermission,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build main location view
  Widget _buildLocationView() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Current location card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.my_location, size: 32),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Text(
                          'Current Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (_isListening)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  
                  if (_currentPosition != null) ...[
                    _buildLocationInfo('Latitude', _currentPosition!.latitude.toStringAsFixed(6)),
                    _buildLocationInfo('Longitude', _currentPosition!.longitude.toStringAsFixed(6)),
                    _buildLocationInfo('Accuracy', '${_currentPosition!.accuracy.toStringAsFixed(1)}m'),
                    _buildLocationInfo('Altitude', '${_currentPosition!.altitude.toStringAsFixed(1)}m'),
                    _buildLocationInfo('Speed', '${_currentPosition!.speed.toStringAsFixed(1)}m/s'),
                                         _buildLocationInfo('Timestamp', _formatTimestamp(_currentPosition!.timestamp)),
                  ] else ...[
                    const Text(
                      'No location data available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontStyle: FontStyle.italic,
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
                  onPressed: _isLoading ? null : _getCurrentLocation,
                  icon: _isLoading ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ) : const Icon(Icons.my_location),
                  label: const Text('Get Location'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _isListening ? _stopLocationUpdates : _startLocationUpdates,
                  icon: Icon(_isListening ? Icons.stop : Icons.play_arrow),
                  label: Text(_isListening ? 'Stop Updates' : 'Start Updates'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isListening ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Location history
          if (_locationHistory.isNotEmpty) ...[
            const Text(
              'Location History',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Card(
                child: ListView.builder(
                  itemCount: _locationHistory.length,
                  itemBuilder: (context, index) {
                    final position = _locationHistory[index];
                    final isLatest = position == _currentPosition;
                    
                    return ListTile(
                      leading: Icon(
                        Icons.location_on,
                        color: isLatest ? Colors.green : Colors.grey,
                      ),
                      title: Text(
                        _formatCoordinates(position),
                        style: TextStyle(
                          fontWeight: isLatest ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                                             subtitle: Text(
                         '${_formatTimestamp(position.timestamp)} • ${position.accuracy.toStringAsFixed(1)}m accuracy',
                       ),
                      trailing: index > 0
                          ? Text(
                              '${_calculateDistance(position, _locationHistory[index - 1]).toStringAsFixed(1)}m',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                    );
                  },
                ),
              ),
            ),
          ] else ...[
            const Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.history,
                      size: 64,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No location history yet',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Start location updates to see history',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Build location info row
  Widget _buildLocationInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
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
