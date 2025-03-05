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
      appBar: AppBar(title: Text('${date.year} - ${date.month} - ${date.day}')),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            keyboardType: TextInputType.number,
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
    );
  }
}
