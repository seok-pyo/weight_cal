import 'package:flutter/material.dart';
import 'package:weight_cal/src/settings/settings_view.dart';

class CalendarView extends StatelessWidget {
  final DateTime startDate = DateTime(2025, 1, 1);
  final DateTime endDate = DateTime(2025, 12, 31);

  List<DateTime> generateDates(DateTime start, DateTime end) {
    List<DateTime> dates = [];
    for (int i = 0; i <= end.difference(start).inDays; i++) {
      dates.add(start.add(Duration(days: i)));
    }
    return dates;
  }

  static const routeName = '/';

  CalendarView({super.key});

  @override
  Widget build(BuildContext context) {
    // List<DateTime> dates = generateDates(startDate, endDate);
    int startDateNum = 3;

    return Scaffold(
        appBar: AppBar(
          title: const Text('2025 Calendar'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.restorablePushNamed(context, SettingsView.routeName);
              },
            ),
          ],
        ),
        body: CustomScrollView(
          slivers: [
            SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index < startDateNum) {
                    return Container();
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        (index - startDateNum + 1).toString(),
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  );
                },
                childCount: 31 + startDateNum,
              ),
            ),
          ],
        ));
  }
}
