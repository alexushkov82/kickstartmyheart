class Timetable {
  String name;
  String time;
  String teacher;
  String clas;
  String image;
  int num;
  List<Hometask> hometask;

  Timetable(
      this.name,
      this.time,
      this.teacher,
      this.clas,
      this.image,
      this.num,
      this.hometask,
      );

  static List<Timetable> samples = [
    Timetable(
      'Mathematical Analysis',
      '8.15-9.35',
      'Mazanik',
      '605',
      'assets/2.jpg',
      3,
      [
        Hometask(2, 'integrals', '20/04/2021'),
        Hometask(1, 'differentials', '15/11/2021'),
        Hometask(4, 'row of Furye', '20/02/2022'),
      ],

    ),
    Timetable(
      'Differential Equations',
      '9.45-11.05',
      'Zadvorny',
      '517',
      'assets/3.jpg',
      4,
      [
        Hometask(5, 'Leibnits', '20/12/2021'),
        Hometask(5, 'Koshi', '20/12/2021'),
        Hometask(5, 'Eiler', '20/12/2021'),
        Hometask(5, 'Lyapunov', '20/12/2021'),
      ],
    ),
    Timetable(
      'Programming',
      '11.15-12.35',
      'Vasilenko',
      '508',
      'assets/4.jpg',
      2,
      [
        Hometask(1, 'regular exp.', '05/10/2021'),
        Hometask(2, 'class Date', '06/11/2021'),
      ],
    ),
    Timetable(
      'Swimming',
      '3.30-5.00',
      'Hojempo',
      'Swimming pool',
      'assets/5.jpg',
      0,
      [],
    ),

  ];
}

class Hometask {
  double quantity;
  String name;
  String deadline;

  Hometask (
      this.quantity,
      this.name,
      this.deadline,
      );
}