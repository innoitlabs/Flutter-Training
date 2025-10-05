import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LifeCycleDemo(),
    );
  }
}

class LifeCycleDemo extends StatefulWidget {
  const LifeCycleDemo({super.key});

  @override
  State<LifeCycleDemo> createState() => _LifeCycleDemoState();
}

class _LifeCycleDemoState extends State<LifeCycleDemo> {

  String _status = "Widget created";
  int _counter = 0;


  @override
  void initState() {
    super.initState();
    _status = 'initState called';
    debugPrint('LifeCycleDemo initState Called');
  }

  @override
  void dispose() {
    debugPrint('LifecycleDemo dispose Called');

    super.dispose();
  }

  void _incrementCounter(){
    setState(() {
      _counter++;
      _status = 'setState called $_counter';
    });
    debugPrint('LifeCycleDemo setState Called, counter: $_counter');
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('LifeCycleDemo biuld Called');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('LifeCycle Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Status: $_status'),
          const SizedBox(height: 20),
          Text('Counter: $_counter'),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _incrementCounter,
            child: const Text('Increment Counter'),
          ),
        ],
      ),
    );
  }
}
