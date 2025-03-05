import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weight_cal/src/provider/weight_provider.dart';

class DetailPage extends StatelessWidget {
  final DateTime date;

  DetailPage({super.key, required this.date});

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${date.year}년 ${date.month}월 ${date.day}일')),
      body: Consumer<WeightProvider>(
        builder: (context, provider, child) {
          return Container(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.3),
              child: Column(
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      style: TextStyle(fontSize: 24),
                      decoration: InputDecoration(
                        hintText: provider.weights[DateTime(
                                    date.year, date.month, date.day)] !=
                                null
                            ? provider.weights[
                                    DateTime(date.year, date.month, date.day)]
                                .toString()
                            : '🍀',
                        alignLabelWithHint: true,
                      ),
                      textAlign: TextAlign.center,
                      controller: _controller,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      double weight = double.tryParse(_controller.text) ?? 0.0;
                      Provider.of<WeightProvider>(context, listen: false)
                          .saveWeight(date, weight);
                      Navigator.pop(context);
                    },
                    child: Text("저장"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
