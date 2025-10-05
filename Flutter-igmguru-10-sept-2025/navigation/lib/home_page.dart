import 'package:flutter/material.dart';
import 'package:navigation/details_page.dart';
import 'package:navigation/second_screen.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Navigation - Home'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Card(
              child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Basic Navigation Concepts',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      ),
                      SizedBox(height: 8,),
                      Text("The Example Demonstrates the fundamental navigation concepts", style: TextStyle(fontSize: 16),),
                      SizedBox(height: 8,),
                      Text('. Navigator.push() - Add a new screen to the navigation stack', style: TextStyle(fontSize: 16),),
                      Text('. Navigator.pop() - Remove the top screen from the navigation stack', style: TextStyle(fontSize: 16),),
                      Text('. MaterialPageRoute - Standard Page transition')
                    ],
                  )
              ),
              ),
            SizedBox(height: 8,),
            ElevatedButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SecondScreen(
                        title: 'Data Passing to Details Page',
                      ))
                  );
                },
                child: const Text('Go to Details Page')),
            SizedBox(height: 8,),
            ElevatedButton(
                onPressed: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const DetailsPage())
                  );
                },
                child: const Text('Go to Details Page push replacement'))
          ],
        ),
      ),
    );
  }
}
