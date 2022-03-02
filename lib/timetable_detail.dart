import 'package:flutter/material.dart';
import 'timetable.dart';

class TimetableDetail extends StatefulWidget {
  final Timetable timetable;
  const TimetableDetail({Key? key, required this.timetable}) : super(key: key);

  @override
  _TimetableDetailState createState() {
    return _TimetableDetailState();
  }
}

class _TimetableDetailState extends State<TimetableDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.timetable.name,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image(
                image: AssetImage(widget.timetable.image),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.timetable.time,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.timetable.teacher,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.timetable.clas,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: widget.timetable.hometask.length,
                itemBuilder: (BuildContext context, int index) {
                  final hometask = widget.timetable.hometask[index];
                  //TODO: Add ingredient quantity
                  return Text(
                    '${hometask.quantity} ${hometask.name} ${hometask.deadline}'
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
