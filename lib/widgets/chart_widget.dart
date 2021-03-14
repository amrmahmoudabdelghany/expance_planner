import 'package:expence_planner/models/Transactions.dart';
import 'package:expence_planner/widgets/chart_bar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> userTrunsaction;

  Chart(this.userTrunsaction);
  double get _totalAmount {
    double res = 0.0;
    for (int i = 0; i < this.userTrunsaction.length; i++)
      res += this.userTrunsaction[i].amount;
    return res;
  }

  List<Map<String, Object>> get groubedTransactions {
    return List<Map<String, Object>>.generate(7, (index) {
      final cDay = DateTime.now().subtract(Duration(days: index));

      var totalAmount = 0.0;
      for (int i = 0; i < this.userTrunsaction.length; i++) {
        if (this.userTrunsaction[i].date.day == cDay.day &&
            this.userTrunsaction[i].date.month == cDay.month &&
            this.userTrunsaction[i].date.year == cDay.year) {
          totalAmount += this.userTrunsaction[i].amount;
        }
      }

      return {"day": DateFormat.E().format(cDay), "amount": totalAmount};
    }).reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: this.groubedTransactions.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  e['day'],
                  e['amount'],
                  _totalAmount == 0.0
                      ? 0.0
                      : (e['amount'] as double) / _totalAmount),
            );
          }).toList(),
        ),
      ),
    );
  }
}
