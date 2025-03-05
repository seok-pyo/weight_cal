// import 'package:weight_cal/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:weight_cal/src/details/detail_page.dart';

class CalendarView extends StatelessWidget {
  final int year;

  static const routeName = '/';

  const CalendarView({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 25, left: 10),
          child: Text(
            '$year년',
            style: TextStyle(fontSize: 32),
          ),
        ),
        centerTitle: false,
      ),
      body: Row(
        children: [
          Expanded(child: MakeCalendar(year: 2025)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                ),
                ...List.generate(
                  7,
                  (index) {
                    List<String> weekdays = [
                      'sun',
                      'mon',
                      'tue',
                      'wed',
                      'thu',
                      'fri',
                      'sat',
                    ];
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      alignment: Alignment.topLeft,
                      child: RotatedBox(
                        quarterTurns: 1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Text(
                            weekdays[index],
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MakeCalendar extends StatelessWidget {
  final int year;

  const MakeCalendar({
    super.key,
    required this.year,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 12,
      itemBuilder: (context, index) {
        final monthStart = DateTime(year, index + 1, 1);
        final daysInMonth = DateUtils.getDaysInMonth(year, index + 1);
        final startWeekday = monthStart.weekday + 1;

        List<List<Widget>> weeks = [];
        List<Widget> week = [];

        // 첫 주에 비어있는 날짜를 추가
        for (int i = 1; i <= (startWeekday % 7); i++) {
          week.add(
            Container(
              height: MediaQuery.of(context).size.height * 0.1,
              padding: const EdgeInsets.all(4),
            ),
          );
        }

        // 날짜 추가
        for (int day = 1; day <= daysInMonth; day++) {
          week.add(
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      date: DateTime(year, index + 1, day),
                    ),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    Text(
                      '$day',
                      style: const TextStyle(fontSize: 24),
                    ),

                    // Expanded(
                    //   child: IconButton(
                    //     iconSize: 20,
                    //     icon: Icon(Icons.local_fire_department_rounded),
                    //     onPressed: () {},
                    //   ),
                    // ),
                    // Text(
                    //   '80.0',
                    //   style: const TextStyle(fontSize: 18),
                    // ),
                  ],
                ),
              ),
            ),
          );

          // 일주일이 끝나면 새 주로 넘어가도록 한다.
          if ((startWeekday + day) % 7 == 0) {
            weeks.add(List<Widget>.from(week));
            week.clear();
          }
        }

        // 마지막 주가 남아있을 수 있으므로 추가
        if (week.isNotEmpty) {
          weeks.add(week);
        }

        return Padding(
          padding: EdgeInsets.only(left: 5, right: 10, top: 20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: EdgeInsets.only(
                left: 20,
                bottom: 20,
              ),
              child: Text(
                '${monthStart.month}월',
                style:
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 30, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 15,
                children: [
                  for (var week in weeks)
                    SizedBox(
                      width: 50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: week,
                      ),
                    ),
                ],
              ),
            ),
          ]),
        );
      },
    );
  }
}
