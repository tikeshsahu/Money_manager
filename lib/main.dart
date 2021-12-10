import 'package:flutter/services.dart';
import 'package:intl/intl_standalone.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/widgets/chart.dart';
import 'package:money_manager/widgets/new_transaction.dart';
import 'package:money_manager/widgets/try.dart';
import './widgets/transaction_list.dart';
import 'models/transaction.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, 
      DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Money Manager',
      theme: ThemeData(primarySwatch: Colors.red),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<HomePage> {
  final List<Transaction> userTransactions = [];

  List<Transaction> get recentTransactions {
    return userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void addNewTransactions(
      String ttitle, double tamount, DateTime selectedDate) {
    final newT = Transaction(
        id: DateTime.now().toString(),
        title: ttitle,
        amount: tamount,
        date: selectedDate);

    setState(() {
      userTransactions.add(newT);
    });
  }

  void startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTransaction(addNewTransactions),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void deleteTransaction(String id) {
    setState(() {
      userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      title: Text(
        'Money Manager',
      ),
      centerTitle: true,
      backgroundColor: Colors.teal,
      actions: [
        IconButton(
          icon: Icon(Icons.wallet_travel),
          onPressed: () {}
          //=> startAddNewTransaction(context),
        )
      ],
    );
    return Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height -
                        appBar.preferredSize.height) *
                    0.25,
                width: double.infinity,
                child: Chart(recentTransactions: recentTransactions,),
                
              ),
              Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height) *
                      0.7,
                  child: TransactionList(userTransactions, deleteTransaction)),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70),
          child: FloatingActionButton(
            tooltip: 'Add Transactions',
            onPressed: () => startAddNewTransaction(context),
            child: Icon(Icons.add),
            shape: RoundedRectangleBorder(
              side: new BorderSide(color: Color(0xFF2A8068)),
              borderRadius: new BorderRadius.all(new Radius.circular(4)),
            ),
          ),
        ));
  }
}
