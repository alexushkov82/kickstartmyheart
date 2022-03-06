import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Kickstartmyheart App',
        theme: ThemeData.dark(),
        home: Scaffold(
          body: Center(
            child: Text('kickstartmyheart'),
          ),
        )
    );
  }
}