
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
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Basic Container Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.blue,
              child: Text(
                'Simple Container',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              ),
            ),
            SizedBox(height: 16.0,),
            Container(
              width: 200.0,
              height: 100.0,
              color: Colors.green,
              //padding: EdgeInsets.fromLTRB(16.0, 16.0, 9.0, 8.0),//Left Top Right Bottom
                padding: EdgeInsets.all(16.0),
              child:Text(
                'With Padding',
                style: TextStyle(color: Colors.white, fontSize: 16.0),
              )
            ),
            SizedBox(height: 16.0,),
            Container(
                width: 200.0,
                height: 100.0,
                color: Colors.green,
                //padding: EdgeInsets.fromLTRB(16.0, 16.0, 9.0, 8.0),//Left Top Right Bottom
                margin: EdgeInsets.all(16.0),
                child:Text(
                  'With Margin',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                )
            ),
            SizedBox(height: 16.0,),
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                )
              ),
              child: Center(
                child: Text(
                  'With Decoration',
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 16.0,),
            Container(
              width: 200.0,
              height: 100.0,
              padding: EdgeInsets.all(16.0),
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  )
                ]

              ),
              child: Center(
                child: Text(
                  'With Decoration',
                  style: TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



