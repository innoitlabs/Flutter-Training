import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  final String? title;

  const SecondScreen({
    super.key,
    this.title
  });

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details Page"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Details Page', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
            SizedBox(height: 8.0,),
            ElevatedButton( onPressed: (){
              Navigator.pop(context);
            },
                child: const Text("Go Back to Home")),
            SizedBox(height: 8.0,),
            Text(widget.title ?? '', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );

  }

}
