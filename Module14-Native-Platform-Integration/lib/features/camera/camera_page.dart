import 'dart:io';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _controller;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  bool _isInitialized = false;
  bool _isCapturing = false;
  XFile? _capturedImage;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// Initialize camera with permission check
  Future<void> _initializeCamera() async {
    try {
      // Check camera permission first
      final permissionStatus = await Permission.camera.status;
      if (!permissionStatus.isGranted) {
        final requestStatus = await Permission.camera.request();
        if (!requestStatus.isGranted) {
          setState(() {
            _errorMessage = 'Camera permission is required to use this feature';
          });
          return;
        }
      }

      // Get available cameras
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        setState(() {
          _errorMessage = 'No cameras found on this device';
        });
        return;
      }

      // Initialize camera controller
      _controller = CameraController(
        _cameras[_selectedCameraIndex],
        ResolutionPreset.high,
        enableAudio: false, // Disable audio for photo capture
      );

      // Initialize the controller
      await _controller!.initialize();
      
      if (mounted) {
        setState(() {
          _isInitialized = true;
          _errorMessage = null;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to initialize camera: $e';
      });
    }
  }

  /// Switch between front and back cameras
  Future<void> _switchCamera() async {
    if (_cameras.length < 2) return;

    setState(() => _isInitialized = false);
    await _controller?.dispose();

    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    _controller = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      setState(() => _isInitialized = true);
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to switch camera: $e';
      });
    }
  }

  /// Capture a photo
  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    setState(() => _isCapturing = true);

    try {
      final XFile image = await _controller!.takePicture();
      setState(() {
        _capturedImage = image;
        _isCapturing = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to capture image: $e';
        _isCapturing = false;
      });
    }
  }

  /// Reset captured image
  void _resetImage() {
    setState(() {
      _capturedImage = null;
    });
  }

  // Removed unused _showErrorDialog method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (_cameras.length > 1)
            IconButton(
              icon: const Icon(Icons.switch_camera),
              onPressed: _isInitialized ? _switchCamera : null,
              tooltip: 'Switch camera',
            ),
        ],
      ),
      body: _errorMessage != null
          ? _buildErrorView()
          : _capturedImage != null
              ? _buildImagePreview()
              : _buildCameraView(),
    );
  }

  /// Build error view when camera fails to initialize
  Widget _buildErrorView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
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
              onPressed: _initializeCamera,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  /// Build camera preview view
  Widget _buildCameraView() {
    if (!_isInitialized || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Column(
      children: [
        // Camera preview
        Expanded(
          child: Container(
            width: double.infinity,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: CameraPreview(_controller!),
            ),
          ),
        ),
        
        // Camera controls
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Camera info
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    _cameras[_selectedCameraIndex].lensDirection == CameraLensDirection.front
                        ? Icons.camera_front
                        : Icons.camera_rear,
                    color: Colors.grey[600],
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${_cameras[_selectedCameraIndex].lensDirection.name.toUpperCase()} Camera',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Capture button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Spacer
                  const SizedBox(width: 60),
                  
                  // Main capture button
                  GestureDetector(
                    onTap: _isCapturing ? null : _takePicture,
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _isCapturing ? Colors.grey : Colors.white,
                        border: Border.all(
                          color: _isCapturing ? Colors.grey : Colors.blue,
                          width: 4,
                        ),
                      ),
                      child: _isCapturing
                          ? const CircularProgressIndicator()
                          : const Icon(
                              Icons.camera_alt,
                              size: 40,
                              color: Colors.blue,
                            ),
                    ),
                  ),
                  
                  // Switch camera button (if multiple cameras)
                  if (_cameras.length > 1)
                    IconButton(
                      onPressed: _switchCamera,
                      icon: const Icon(Icons.switch_camera),
                      iconSize: 32,
                      color: Colors.grey[600],
                    )
                  else
                    const SizedBox(width: 60),
                ],
              ),
              
              const SizedBox(height: 16),
              
              // Instructions
              const Text(
                'Tap the button to capture a photo',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Build image preview after capture
  Widget _buildImagePreview() {
    return Column(
      children: [
        // Image preview
        Expanded(
          child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(_capturedImage!.path),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        // Action buttons
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: _resetImage,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Take Another'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[200],
                    foregroundColor: Colors.grey[800],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Here you could save the image to gallery
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Image captured successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Use Photo'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
