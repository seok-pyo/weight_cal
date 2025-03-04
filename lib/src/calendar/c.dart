import 'package:flutter/material.dart';

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
        final startWeekday = monthStart.weekday;

        List<List<Widget>> weeks = [];
        List<Widget> week = [];

        // 첫 주에 비어있는 날짜를 추가
        for (int i = 0; i < startWeekday - 1; i++) {
          week.add(Container());
        }

        // 날짜 추가
        for (int day = 1; day <= daysInMonth; day++) {
          week.add(
            Container(
              padding: const EdgeInsets.all(8),
              child: Text(
                '$day',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          );

          // 일주일이 끝나면 새 주로 넘어가도록 한다.
          if ((startWeekday - 1 + day) % 7 == 0) {
            weeks.add(List<Widget>.from(week));
            week.clear();
          }
        }

        // 마지막 주가 남아있을 수 있으므로 추가
        if (week.isNotEmpty) {
          weeks.add(week);
        }

        return Column(
          children: [
            Text(
              '${monthStart.month}월',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            for (var week in weeks)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: week,
              ),
          ],
        );
      },
    );
  }
}
