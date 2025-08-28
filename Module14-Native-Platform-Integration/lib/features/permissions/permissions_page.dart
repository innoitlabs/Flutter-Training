import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsPage extends StatefulWidget {
  const PermissionsPage({super.key});

  @override
  State<PermissionsPage> createState() => _PermissionsPageState();
}

class _PermissionsPageState extends State<PermissionsPage> {
  PermissionStatus _cameraStatus = PermissionStatus.denied;
  PermissionStatus _locationStatus = PermissionStatus.denied;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  /// Check current permission status for camera and location
  Future<void> _checkPermissions() async {
    setState(() => _isLoading = true);
    
    try {
      final cameraStatus = await Permission.camera.status;
      final locationStatus = await Permission.location.status;
      
      setState(() {
        _cameraStatus = cameraStatus;
        _locationStatus = locationStatus;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Error checking permissions: $e');
    }
  }

  /// Request camera permission
  Future<void> _requestCameraPermission() async {
    setState(() => _isLoading = true);
    
    try {
      final status = await Permission.camera.request();
      setState(() {
        _cameraStatus = status;
        _isLoading = false;
      });
      
      if (status.isDenied) {
        _showInfoSnackBar('Camera permission denied');
      } else if (status.isPermanentlyDenied) {
        _showInfoSnackBar('Camera permission permanently denied. Please enable in settings.');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Error requesting camera permission: $e');
    }
  }

  /// Request location permission
  Future<void> _requestLocationPermission() async {
    setState(() => _isLoading = true);
    
    try {
      final status = await Permission.location.request();
      setState(() {
        _locationStatus = status;
        _isLoading = false;
      });
      
      if (status.isDenied) {
        _showInfoSnackBar('Location permission denied');
      } else if (status.isPermanentlyDenied) {
        _showInfoSnackBar('Location permission permanently denied. Please enable in settings.');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      _showErrorSnackBar('Error requesting location permission: $e');
    }
  }

  /// Open app settings if permission is permanently denied
  Future<void> _openSettings() async {
    await openAppSettings();
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _showInfoSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blue,
      ),
    );
  }

  /// Get permission status color based on status
  Color _getStatusColor(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return Colors.green;
      case PermissionStatus.denied:
        return Colors.orange;
      case PermissionStatus.permanentlyDenied:
        return Colors.red;
      case PermissionStatus.restricted:
        return Colors.purple;
      case PermissionStatus.limited:
        return Colors.blue;
      case PermissionStatus.provisional:
        return Colors.yellow;
    }
  }

  /// Get permission status text
  String _getStatusText(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        return 'Granted';
      case PermissionStatus.denied:
        return 'Denied';
      case PermissionStatus.permanentlyDenied:
        return 'Permanently Denied';
      case PermissionStatus.restricted:
        return 'Restricted';
      case PermissionStatus.limited:
        return 'Limited';
      case PermissionStatus.provisional:
        return 'Provisional';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Permissions'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _isLoading ? null : _checkPermissions,
            tooltip: 'Refresh permissions',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Device Permissions',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Check and request permissions for device features',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  
                  // Camera Permission Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.camera_alt, size: 32),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Camera Permission',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _getStatusText(_cameraStatus),
                                      style: TextStyle(
                                        color: _getStatusColor(_cameraStatus),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _requestCameraPermission,
                                  icon: const Icon(Icons.camera_alt),
                                  label: const Text('Request Permission'),
                                ),
                              ),
                              if (_cameraStatus.isPermanentlyDenied) ...[
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  onPressed: _openSettings,
                                  icon: const Icon(Icons.settings),
                                  label: const Text('Settings'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Location Permission Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.location_on, size: 32),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Location Permission',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _getStatusText(_locationStatus),
                                      style: TextStyle(
                                        color: _getStatusColor(_locationStatus),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton.icon(
                                  onPressed: _requestLocationPermission,
                                  icon: const Icon(Icons.location_on),
                                  label: const Text('Request Permission'),
                                ),
                              ),
                              if (_locationStatus.isPermanentlyDenied) ...[
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  onPressed: _openSettings,
                                  icon: const Icon(Icons.settings),
                                  label: const Text('Settings'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange,
                                    foregroundColor: Colors.white,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Permission Status Legend
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Permission Status Legend',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildLegendItem('Granted', Colors.green, 'Permission is granted and ready to use'),
                          _buildLegendItem('Denied', Colors.orange, 'Permission was denied but can be requested again'),
                          _buildLegendItem('Permanently Denied', Colors.red, 'Permission was permanently denied - user must enable in settings'),
                          _buildLegendItem('Restricted', Colors.purple, 'Permission is restricted by system'),
                        ],
                      ),
                    ),
                  ),
                  
                  // Add bottom padding to prevent overflow
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildLegendItem(String status, Color color, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  status,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: color,
                  ),
                ),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
