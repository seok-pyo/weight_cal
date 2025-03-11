import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vertical/src/provider/weight_provider.dart';

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
            String dateKey = provider.formatDateKey(date);
            print(provider.weights);
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
                                provider.weights[dateKey] != null
                                    ? provider.weights[dateKey].toString()
                                    : '🍀',
                              ),
                            ),
                            alignLabelWithHint: true,
                            labelStyle: TextStyle(
                              fontSize: 85,
                            ),
                            border: InputBorder.none,
                          ),
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
                          if (provider.weights[dateKey] != null) {
                            // remove existed one.
                            // print("before: ${provider.weights}");
                            provider.weights.remove(dateKey);
                            // print("after: ${provider.weights}");
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
