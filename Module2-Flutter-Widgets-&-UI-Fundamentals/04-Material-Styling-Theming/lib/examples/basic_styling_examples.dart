import 'package:flutter/material.dart';

class BasicStylingExamples extends StatelessWidget {
  const BasicStylingExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Styling Examples'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextStylingSection(),
            const SizedBox(height: 32),
            _buildContainerStylingSection(),
            const SizedBox(height: 32),
            _buildButtonStylingSection(),
            const SizedBox(height: 32),
            _buildInputStylingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextStylingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Text Styling Examples',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        
        // Basic text styling
        const Text(
          'Hello Flutter!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
            fontFamily: 'Roboto',
            letterSpacing: 1.2,
            height: 1.5,
          ),
        ),
        const SizedBox(height: 8),
        
        // Text with decoration
        const Text(
          'Underlined Text',
          style: TextStyle(
            fontSize: 18,
            decoration: TextDecoration.underline,
            decorationColor: Colors.red,
            decorationThickness: 2,
          ),
        ),
        const SizedBox(height: 8),
        
        // Gradient text (using ShaderMask)
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Colors.purple, Colors.orange],
          ).createShader(bounds),
          child: const Text(
            'Gradient Text',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        
        // Rich text
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 16, color: Colors.black),
            children: [
              TextSpan(text: 'Rich text with '),
              TextSpan(
                text: 'bold',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
              TextSpan(text: ' and '),
              TextSpan(
                text: 'italic',
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.blue),
              ),
              TextSpan(text: ' styling'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContainerStylingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Container Styling Examples',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        
        // Basic container with decoration
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: const Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          child: const Center(
            child: Text(
              'Styled Container',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Container with gradient
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Colors.blue, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
          ),
          child: const Center(
            child: Text(
              'Gradient Container',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Container with image background
        Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage('https://picsum.photos/200/100'),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.black.withValues(alpha: 0.3),
            ),
            child: const Center(
              child: Text(
                'Image Background',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButtonStylingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Button Styling Examples',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        
        // Elevated button with custom style
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 4,
          ),
          child: const Text('Styled Elevated Button'),
        ),
        const SizedBox(height: 12),
        
        // Outlined button with custom style
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.blue,
            side: const BorderSide(color: Colors.blue, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text('Styled Outlined Button'),
        ),
        const SizedBox(height: 12),
        
        // Text button with custom style
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: Colors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          child: const Text('Styled Text Button'),
        ),
        const SizedBox(height: 12),
        
        // Icon button
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite),
          style: IconButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.all(12),
          ),
        ),
      ],
    );
  }

  Widget _buildInputStylingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Input Styling Examples',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        const SizedBox(height: 16),
        
        // Styled text field
        TextField(
          decoration: InputDecoration(
            labelText: 'Styled Text Field',
            hintText: 'Enter your text here',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
            filled: true,
            fillColor: Colors.grey[100],
            prefixIcon: const Icon(Icons.edit),
            suffixIcon: const Icon(Icons.clear),
          ),
        ),
        const SizedBox(height: 16),
        
        // Styled text form field
        TextFormField(
          decoration: InputDecoration(
            labelText: 'Form Field',
            hintText: 'Enter your data',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.green, width: 2),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            prefixIcon: const Icon(Icons.person, color: Colors.green),
          ),
        ),
      ],
    );
  }
}
