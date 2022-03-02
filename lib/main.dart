import 'package:flutter/material.dart';
import 'timetable.dart';
import 'timetable_detail.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Kickstartmyheart App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: MyHomePage(title: 'Timetable'));
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
          ),
        ),
      body: SafeArea(
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: Timetable.samples.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TimetableDetail(timetable: Timetable.samples[index]);
                    },
                  ),
                );
              },
              child: buildTimetableCard(Timetable.samples[index]),
            );
          },
        ),
      ),
    );
  }

  Widget buildTimetableCard(Timetable timetable) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Text(
              timetable.name,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Image(image: AssetImage(timetable.image)),
            const SizedBox(
              height: 15,
            ),
            Text(
              timetable.time,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

}