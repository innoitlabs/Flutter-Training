
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
            Text(
              'Row Widgets Examples',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 16.0),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow,),
                  SizedBox(width: 8.0,),
                  Text('5.0'),
                  SizedBox(width: 8.0,),
                  Text('(150 reviews)'),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                  borderRadius: BorderRadius.circular(8.0)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(width: 50, height: 50, color: Colors.red,),
                  Container(width: 50, height: 50, color: Colors.green,),
                  Container(width: 50, height: 50, color: Colors.blue,),
                  Container(width: 50, height: 50, color: Colors.yellow,),
                ],
              ),
            ),
            SizedBox(height: 8.0,),
            Row(
              children: [
                Expanded(

                    child: Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(8.0)
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(width: 50, height: 50, color: Colors.red,),
                          SizedBox(height: 8.0,),
                          Container(width: 50, height: 50, color: Colors.green,),
                          SizedBox(height: 8.0,),
                          Container(width: 50, height: 50, color: Colors.blue,),
                        ],
                      ),
                    )
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}



