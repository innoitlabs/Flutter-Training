import 'package:flutter/material.dart';

class ToggleScreen extends StatefulWidget {
  const ToggleScreen({super.key});

  @override
  State<ToggleScreen> createState() => _ToggleScreenState();
}

class _ToggleScreenState extends State<ToggleScreen> {
  // State variables for different types of interactions
  bool _isVisible = true;
  bool _isChecked = false;
  bool _isEnabled = true;
  String _selectedOption = 'Option 1';
  double _sliderValue = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Interactions'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Handling User Interactions',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Learn how to handle different user interactions using setState.\n'
              'Each interaction updates the state and rebuilds the UI.',
            ),
            const SizedBox(height: 24),
            
            Expanded(
              child: ListView(
                children: [
                  // Visibility Toggle Example
                  _buildInteractionCard(
                    context,
                    'Visibility Toggle',
                    'Toggle the visibility of content',
                    Icons.visibility,
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Show/Hide Content:'),
                            Switch(
                              value: _isVisible,
                              onChanged: (value) {
                                setState(() {
                                  _isVisible = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (_isVisible)
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue[200]!),
                            ),
                            child: const Text(
                              'This content is now visible!\n'
                              'The Switch widget controls this visibility.',
                            ),
                          ),
                      ],
                    ),
                  ),
                  
                  // Checkbox Example
                  _buildInteractionCard(
                    context,
                    'Checkbox Interaction',
                    'Handle checkbox state changes',
                    Icons.check_box,
                    Column(
                      children: [
                        CheckboxListTile(
                          title: const Text('Accept terms and conditions'),
                          subtitle: const Text('You must check this to continue'),
                          value: _isChecked,
                          onChanged: (value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _isChecked 
                              ? '✅ Terms accepted!' 
                              : '❌ Please accept the terms',
                          style: TextStyle(
                            color: _isChecked ? Colors.green : Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Radio Buttons Example
                  _buildInteractionCard(
                    context,
                    'Radio Button Selection',
                    'Handle radio button state changes',
                    Icons.radio_button_checked,
                    Column(
                      children: [
                        RadioListTile<String>(
                          title: const Text('Option 1'),
                          value: 'Option 1',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Option 2'),
                          value: 'Option 2',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                        RadioListTile<String>(
                          title: const Text('Option 3'),
                          value: 'Option 3',
                          groupValue: _selectedOption,
                          onChanged: (value) {
                            setState(() {
                              _selectedOption = value!;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Selected: $_selectedOption',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  
                  // Slider Example
                  _buildInteractionCard(
                    context,
                    'Slider Interaction',
                    'Handle slider value changes',
                    Icons.slideshow,
                    Column(
                      children: [
                        Text(
                          'Value: ${_sliderValue.round()}',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Slider(
                          value: _sliderValue,
                          min: 0,
                          max: 100,
                          divisions: 10,
                          label: _sliderValue.round().toString(),
                          onChanged: (value) {
                            setState(() {
                              _sliderValue = value;
                            });
                          },
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: FractionallySizedBox(
                            alignment: Alignment.centerLeft,
                            widthFactor: _sliderValue / 100,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Button State Example
                  _buildInteractionCard(
                    context,
                    'Button State Management',
                    'Enable/disable buttons based on state',
                    Icons.touch_app,
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Enable Button:'),
                            Switch(
                              value: _isEnabled,
                              onChanged: (value) {
                                setState(() {
                                  _isEnabled = value;
                                });
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _isEnabled ? _showMessage : null,
                            child: Text(_isEnabled ? 'Click Me!' : 'Button Disabled'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInteractionCard(
    BuildContext context,
    String title,
    String description,
    IconData icon,
    Widget content,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 24, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            content,
          ],
        ),
      ),
    );
  }

  void _showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Button clicked! State management is working!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
