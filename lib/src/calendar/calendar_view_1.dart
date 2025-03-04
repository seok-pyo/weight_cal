import 'package:flutter/material.dart';
import 'package:weight_cal/src/settings/settings_view.dart';

// class CalendarView extends StatelessWidget {
//   final DateTime startDate = DateTime(2025, 1, 1);
//   final DateTime endDate = DateTime(2025, 12, 31);

//   List<DateTime> generateDates(DateTime start, DateTime end) {
//     List<DateTime> dates = [];
//     for (int i = 0; i <= end.difference(start).inDays; i++) {
//       dates.add(start.add(Duration(days: i)));
//     }
//     return dates;
//   }

//

//   CalendarView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // List<DateTime> dates = generateDates(startDate, endDate);
//     int startDateNum = 3;

//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('2025 Calendar'),
//           actions: [
//             IconButton(
//               icon: const Icon(Icons.settings),
//               onPressed: () {
//                 Navigator.restorablePushNamed(context, SettingsView.routeName);
//               },
//             ),
//           ],
//         ),
//         body: CustomScrollView(
//           slivers: [
//             MonthCalendar(startDateNum: startDateNum),
//             SliverToBoxAdapter(
//                 child: Divider(thickness: 2, color: Colors.grey[400])),
//             MonthCalendar(startDateNum: startDateNum),
//             MonthCalendar(startDateNum: startDateNum),
//             MonthCalendar(startDateNum: startDateNum),
//             MonthCalendar(startDateNum: startDateNum),
//             MonthCalendar(startDateNum: startDateNum),
//           ],
//         ));
//   }
// }

// class MonthCalendar extends StatelessWidget {
//   const MonthCalendar({
//     super.key,
//     required this.startDateNum,
//   });

//   final int startDateNum;

//   @override
//   Widget build(BuildContext context) {
//     return SliverGrid(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 7,
//         childAspectRatio: 1,
//         crossAxisSpacing: 4,
//         mainAxisSpacing: 4,
//       ),
//       delegate: SliverChildBuilderDelegate(
//         (context, index) {
//           if (index < startDateNum) {
//             return Container();
//           }
//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: Center(
//               child: Text(
//                 (index - startDateNum + 1).toString(),
//                 style: TextStyle(
//                   fontSize: 16,
//                 ),
//               ),
//             ),
//           );
//         },
//         childCount: 31 + startDateNum,
//       ),
//     );
//   }
// }
class CalendarView extends StatelessWidget {
  final int year;

  static const routeName = '/';

  const CalendarView({super.key, required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$year Calendar')),
      // body: CustomScrollView(
      //   slivers: List.generate(12, (index) {
      //     final monthStart = DateTime(year, index + 1, 1);
      //     final startWeekday = monthStart.weekday;
      //     final daysInMonth = DateUtils.getDaysInMonth(year, index + 1);
      //     return MonthCalendar(
      //       startWeekday: startWeekday,
      //       daysInMonth: daysInMonth,
      //     );
      //   }),
      // ),

      // body: ListView.builder(itemBuilder: (context, index) {
      //   final monthStart = DateTime(year, index + 1, 1);
      //   final startWeekday = monthStart.weekday;
      //   final daysInMonth = DateUtils.getDaysInMonth(year, index + 1);
      //   return MonthCalendar(
      //     startWeekday: startWeekday,
      //     daysInMonth: daysInMonth,
      //   );
      // }));

      body: SingleChildScrollView(
        child: Column(
          children: List.generate(12, (index) {
            final monthStart = DateTime(year, index + 1, 1);
            final startWeekday = monthStart.weekday;
            final daysInMonth = DateUtils.getDaysInMonth(year, index + 1);
            return MonthCalendar(
              startWeekday: startWeekday,
              daysInMonth: daysInMonth,
            );
          }),
        ),
      ),
    );
  }
}

class MonthCalendar extends StatelessWidget {
  final int startWeekday;
  final int daysInMonth;

  const MonthCalendar(
      {super.key, required this.startWeekday, required this.daysInMonth});

  // @override
  // Widget build(BuildContext context) {
  //   final totalCells = startWeekday + daysInMonth;

  //   return SliverGrid(
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 5,
  //       childAspectRatio: 1,
  //       crossAxisSpacing: 4,
  //       mainAxisSpacing: 4,
  //     ),
  //     delegate: SliverChildBuilderDelegate(
  //       (context, index) {
  //         if (index < startWeekday) {
  //           return Container();
  //         }
  //         final day = index - startWeekday + 1;
  //         return Container(
  //           height: 500,
  //           decoration: BoxDecoration(
  //             // color: Colors.grey[200],

  //             borderRadius: BorderRadius.circular(8),
  //           ),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.max,
  //             children: [
  //               Text('$day', style: const TextStyle(fontSize: 24)),
  //               Expanded(flex: 2, child: Text('80.0')),
  //               Expanded(flex: 2, child: Text('80.0')),
  //             ],
  //           ),
  //         );
  //       },
  //       childCount: totalCells,
  //     ),
  //   );
  // }
  @override
  Widget build(BuildContext context) {
    final totalRows = (daysInMonth % 7) == 0 ? 4 : 5;
    List<TableRow> rows = [];

    for (int i = 0; i < totalRows; i++) {
      List<Widget> cells = [];
      for (int j = 0; j < 7; j++) {
        final dayIndex = i * 7 + j - startWeekday;
        if (dayIndex >= 0 && dayIndex < daysInMonth) {
          final day = dayIndex + 1;
          cells.add(
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '$day',
                    style: const TextStyle(fontSize: 24),
                  ),
                  Center(
                    child: Text(
                      '80.0',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          cells.add(SizedBox.shrink());
        }
      }
      rows.add(TableRow(children: cells));
    }

    return Table(
      children: rows,
    );
  }
}
