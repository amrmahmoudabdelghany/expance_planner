import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spanndingAmount;
  final double spanndingPctOfAmount;

  ChartBar(this.label, this.spanndingAmount, this.spanndingPctOfAmount);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(spanndingAmount.toString()),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
            height: constraints.maxHeight * 0.7,
            width: 10,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: spanndingPctOfAmount,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.05,
          ),
          Container(
              height: constraints.maxHeight * 0.10,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
