import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key, String title=''});

  //Navigator.popUntil(context, (route) => route.isfirst);
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
            
          ],
        ),
      ),
    );

  }
}
