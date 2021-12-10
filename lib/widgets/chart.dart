import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/widgets/chart_bars.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactionsValues {

    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalSum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0,1),
        'amount': totalSum
        };
    }).reversed.toList();
  }

  double get totalSpending{
    return groupedTransactionsValues.fold(0.0, (sum, item) {
       return sum + (item['amount']as double) ;
      });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          margin: EdgeInsets.all(12),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupedTransactionsValues.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                    lable : (data['day']as String), 
                    spendingAmount: (data['amount']as double), 
                    spendingPrcntOfTotal: totalSpending == 0.0 ? 0.0 :(data['amount']as double) / totalSpending,
                  ),
                );
              }).toList(),
            ),
          ),
      ),
    );
  }
}
