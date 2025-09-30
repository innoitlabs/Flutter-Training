
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello World Demo",
      home: const HomePage(),
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello World Title"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Basic Text Example',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.0,),
          Text("Hello Flutter"),
          SizedBox(height: 20.0,),
          Text("Hello Flutter 2"),
          SizedBox(height: 20.0,),
          Text("Hello Flutter 3"),
          Row(
            children: [
              Text("Column1",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 20.0,),
              Text("Column2",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(width: 20.0,),
              Text("Column3",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}



