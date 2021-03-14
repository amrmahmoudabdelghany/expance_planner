import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function txHandler;

  NewTransaction(this.txHandler);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();
  DateTime _date;
  void _submiteData() {
    final title = this.titleController.text;
    final amount = double.parse(this.amountController.text);

    if (title == null || amount <= 0 || _date == null) return;

    this.widget.txHandler(
          title,
          amount,
          _date,
        );
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: new DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        this._date = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: "title"),
                controller: titleController,
                onSubmitted: (_) => _submiteData(),
              ),
              TextField(
                decoration: InputDecoration(labelText: "amount"),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submiteData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(((this._date == null)
                          ? "No Date Chosen!"
                          : "Picked Date : ${DateFormat.yMd().format(this._date)}")),
                    ),
                    FlatButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        "Chose Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      textColor: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: _submiteData,
                child: Text(
                  "Add Transaction",
                ),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
              )
            ],
          ),
        ),
      ),
    );
  }
}
