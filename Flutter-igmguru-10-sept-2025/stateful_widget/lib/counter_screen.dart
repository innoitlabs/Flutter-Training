import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {

  int _counter = 0;
  String _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter App"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Using setState",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16,),
            Card(
              child: Padding(
                  padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text(
                      "$_counter",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _counter > 0 ? Colors.green : _counter < 0 ? Colors.red : Colors.grey
                      ),
                    ),

                    const SizedBox(height: 16.0,),
                    Text(
                      _message,
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                    )
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                    onPressed: _decreament,
                    label: const Text("Decrement"),
                    icon: const Icon(Icons.remove),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red[100]
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _reset,
                  label: const Text("Reset"),
                  icon: const Icon(Icons.refresh),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[100]
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _increment,
                  label: const Text("Increment"),
                  icon: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[100]
                  ),
                )
              ],
            )

          ],
        ),
      ),
    );
  }

  //Method to increament counter
void _increment(){
    setState(() {
      _counter++;
      _updateMessage();
    });
}

void _decreament(){
    setState(() {
      _counter--;
      _updateMessage();
    });

}

void _reset(){
    setState(() {
      _counter = 0;
      _updateMessage();
    });
}

void _updateMessage(){
    if(_counter > 0){
      _message = "Positive Number";
    }
    else if(_counter < 0){
      _message = "Negative Number";
    }
    else{
      _message = "Zero";
    }
}
}
