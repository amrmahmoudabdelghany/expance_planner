import 'package:expence_planner/models/Transactions.dart';
import 'package:expence_planner/widgets/chart_widget.dart';
import 'package:expence_planner/widgets/new_transaction.dart';

import 'package:expence_planner/widgets/transaction_list.dart';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                fontFamily: "openSans",
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              button: TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransaction = [];
  bool _isShowChart = false;
  List<Transaction> get _filterTransactions {
    return _userTransaction.where((i) {
      return (i.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      ));
    }).toList();
  }

  _deleteTx(var id) {
    setState(() {
      _userTransaction.removeWhere((tx) => tx.id == id);
    });
  }

  _addTransaction(String txTitle, double txAmount, DateTime date) {
    final Transaction transaction = new Transaction(
        id: DateTime.now().toString(),
        title: txTitle,
        amount: txAmount,
        date: date);
    setState(() {
      _userTransaction.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(_addTransaction),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscapeMode =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    final appBar = AppBar(
      title: Text(widget.title),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        )
      ],
    );
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLandscapeMode)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Show Chart"),
                  Switch(
                      value: _isShowChart,
                      onChanged: (value) {
                        setState(() {
                          _isShowChart = value;
                        });
                      }),
                ],
              ),
            if (isLandscapeMode)
              (_isShowChart)
                  ? Container(
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: Chart(_filterTransactions),
                    )
                  : Container(
                      height: (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              appBar.preferredSize.height) *
                          0.7,
                      child: TransactionList(_userTransaction, _deleteTx),
                    ),
            if (!isLandscapeMode)
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appBar.preferredSize.height) *
                    0.3,
                child: Chart(_filterTransactions),
              ),
            if (!isLandscapeMode)
              Container(
                height: (MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        appBar.preferredSize.height) *
                    0.7,
                child: TransactionList(_userTransaction, _deleteTx),
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _startAddNewTransaction(context);
          },
        ),
      ),
    );
  }
}
