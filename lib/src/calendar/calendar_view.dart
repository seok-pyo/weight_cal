// import 'package:weight_cal/src/settings/settings_view.dart';
import 'package:flutter/material.dart';

class CalendarView extends StatelessWidget {
  final int year;

  static const routeName = '/';

  const CalendarView({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$year Calendar')),
      body: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Mon'),
                // VerticalDivider(
                //   thickness: 2,
                //   color: Colors.black,
                //   width: 20,
                // ),
                Text('Tue'),
                Text('Wed'),
                Text('Thu'),
                Text('Fri'),
                Text('Sat'),
                Text('Sun'),
                SizedBox(),
              ],
            ),
          ),
          Expanded(child: MakeCalendar(year: 2025)),
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
              height: 100,
              padding: const EdgeInsets.all(4),
            ),
          );
        }

        // 날짜 추가
        for (int day = 1; day <= daysInMonth; day++) {
          week.add(
            Container(
              height: 100,
              padding: const EdgeInsets.all(4),
              child: Column(
                children: [
                  Text(
                    '$day',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Text(
                    '80.0',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
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
          padding: EdgeInsets.only(right: 30),
          child: Row(
            spacing: 25,
            children: [
              // Text(
              //   '${monthStart.month}월',
              //   style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              // ),
              for (var week in weeks)
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: week,
                ),
            ],
          ),
        );
      },
    );
  }
}
