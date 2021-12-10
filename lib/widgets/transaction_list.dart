import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              SizedBox(height: 00,),
              Text(
                'No Transactions added yet!',
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 455,
                  child: Image.network(
                    'https://akm-img-a-in.tosshub.com/indiatoday/images/story/202106/20017667_1556257447773154_1353_1200x768.jpeg?I4.NRu3.CC.SblrKlRNczGKUbmXkmjAK&size=770:433',
                    fit: BoxFit.cover,
                  )),
            ],
          )
    
    
    : ListView.builder(
      itemBuilder: (ctx, index) {
      
      return Card(
        elevation: 5,
        margin: EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 5,
        ),
        child: ListTile(
          // leading: CircleAvatar(
          // child: Padding(padding: EdgeInsets.all(6),
          // child: FittedBox(child: Text('\$ ${transactions[index].amount}'))),
          // radius: 35,
          // ),
          leading: Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade700, width: 2)),
            height: 70,
            width: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: FittedBox(
                child: Text(
                      '\$ ${transactions[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                          ),textAlign: TextAlign.center,
                    ),
              ),
            )
          ),
          title: Text(
            transactions[index].title,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
          subtitle: Text(
            DateFormat.yMMMd().format(transactions[index].date)
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => deleteTx(transactions[index].id),
            color: Colors.red,
            ),
        ),
      );
      
    },
    itemCount: transactions.length,
    );
  }
}
