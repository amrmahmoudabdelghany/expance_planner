import 'package:expence_planner/models/Transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTxHandler;
  TransactionList(this._userTransactions, this.deleteTxHandler);

  @override
  Widget build(BuildContext context) {
    return this._userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  "No transaction added yet!",
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset("assets/images/waiting.png",
                      fit: BoxFit.cover),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: _userTransactions.length,
            itemBuilder: (txContext, index) {
              return Card(
                  child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(
                      color: Theme.of(context).primaryColor,
                      style: BorderStyle.solid,
                      width: 2,
                    )),
                    margin: EdgeInsets.all(15),
                    child: Text(
                      '\$${_userTransactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _userTransactions[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat().format(_userTransactions[index].date),
                          )
                        ],
                      ),
                    ),
                  ),
                  (MediaQuery.of(context).size.width > 460)
                      ? FlatButton.icon(
                          onPressed: () {
                            this.deleteTxHandler(_userTransactions[index].id);
                          },
                          label: Text("Delete"),
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                        )
                      : IconButton(
                          onPressed: () {
                            this.deleteTxHandler(_userTransactions[index].id);
                          },
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                        ),
                ],
              ));
            },
          );
  }
}
