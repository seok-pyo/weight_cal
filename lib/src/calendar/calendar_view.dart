// import 'package:weight_cal/src/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_cal/src/details/detail_page.dart';
import 'package:weight_cal/src/provider/weight_provider.dart';
import 'package:weight_cal/src/theme/theme_controller.dart';

class CalendarView extends StatelessWidget {
  final int year;
  final ThemeController themeController;

  static const routeName = '/';

  const CalendarView({
    super.key,
    required this.year,
    required this.themeController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.only(top: 25, left: 10),
          child: Text(
            '$year년',
            style: TextStyle(
                // fontFamily: 'NotoSans',
                fontWeight: FontWeight.w400,
                fontSize: 32),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                themeController.updateTheme(
                  themeController.themeMode == ThemeMode.dark
                      ? ThemeMode.light
                      : ThemeMode.dark,
                );
              },
              icon: Icon(
                themeController.themeMode == ThemeMode.dark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ))
        ],
        centerTitle: false,
      ),
      body: Row(
        children: [
          Expanded(child: MakeCalendar(year: 2025)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 85,
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

class MakeCalendar extends StatefulWidget {
  final int year;

  const MakeCalendar({
    super.key,
    required this.year,
  });

  @override
  State<MakeCalendar> createState() => _MakeCalendarState();
}

class _MakeCalendarState extends State<MakeCalendar> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final currentMonth = DateTime.now().month - 1;
    _pageController = PageController(initialPage: currentMonth);
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      // pageSnapping: false,
      controller: _pageController,
      scrollDirection: Axis.horizontal,
      itemCount: 12,
      itemBuilder: (context, index) {
        final monthStart = DateTime(widget.year, index + 1, 1);
        final daysInMonth = DateUtils.getDaysInMonth(widget.year, index + 1);
        final startWeekday = monthStart.weekday;
        final currentMonth = DateTime.now().month - 1;
        final currentDay = DateTime.now().day;
        bool isToday = false;

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
          if (index == currentMonth && day == currentDay) {
            isToday = true;
          } else {
            isToday = false;
          }
          week.add(
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      date: DateTime(widget.year, index + 1, day),
                    ),
                  ),
                );
              },
              child: Container(
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.all(4),
                child: Column(
                  children: [
                    isToday
                        ? Text('$day',
                            style: const TextStyle(
                              fontSize: 24,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ))
                        : Text(
                            '$day',
                            // 오늘 색상 표시
                            style: const TextStyle(
                              fontSize: 24,
                            ),
                          ),
                    Consumer<WeightProvider>(
                      builder: (context, value, child) {
                        Object? weight = value
                            .weights[DateTime(widget.year, index + 1, day)];
                        return Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            weight != null && weight != 0.0 ? '$weight' : '',
                            style: TextStyle(fontSize: 18),
                            overflow: TextOverflow.ellipsis,
                          ),
                        );
                      },
                    )
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
          padding: EdgeInsets.only(left: 10, right: 10, top: 20),
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
                    const TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: weeks.length == 6 ? 9 : 15,
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
