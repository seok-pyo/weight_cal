import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_cal/src/provider/weight_provider.dart';

class DetailPage extends StatelessWidget {
  final DateTime date;

  DetailPage({super.key, required this.date});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar:
            AppBar(title: Text('${date.year}년 ${date.month}월 ${date.day}일')),
        body: Consumer<WeightProvider>(
          builder: (context, provider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.175,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextField(
                          style: TextStyle(
                            fontSize: 65,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            label: Center(
                              child: Text(
                                provider.weights[DateTime(
                                            date.year, date.month, date.day)] !=
                                        null
                                    ? provider.weights[DateTime(
                                            date.year, date.month, date.day)]
                                        .toString()
                                    : '🍀',
                              ),
                            ),
                            alignLabelWithHint: true,
                            // floatingLabelBehavior: FloatingLabelBehavior.auto,
                            labelStyle: TextStyle(
                              fontSize: 85,
                            ),
                            border: InputBorder.none,
                            // contentPadding: EdgeInsets.only(left: 90),
                          ),
                          // textAlign: TextAlign.center,
                          controller: _controller,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (double.tryParse(_controller.text) == null) {
                            return;
                          }
                          double weight =
                              double.tryParse(_controller.text) ?? 0.0;
                          Provider.of<WeightProvider>(context, listen: false)
                              .saveWeight(date, weight);
                          Navigator.pop(context);
                        },
                        child: Text("저장"),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
