import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:intl/intl.dart';
import 'package:money_manager/main.dart';

class NewTransaction extends StatefulWidget {
  final Function addTrans;

  NewTransaction(this.addTrans);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
   
  DateTime selectedDate = DateTime.now();


  // void submitData() {
  //   final enteredTitle = titleController.text;
  //   final enteredAmount = double.parse(amountController.text);

  //   if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
  //     return;
  //   }
  void submitData() {
    if (amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);
    

    if (enteredTitle.isEmpty || enteredAmount <= 0 || selectedDate == null) {
      return;
    }

    widget.addTrans(
      enteredTitle,
      enteredAmount,
      selectedDate
    );

    Navigator.of(context).pop();
  }

  void presenDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2020), 
      lastDate: DateTime.now()
      ).then((pickedDate) {
        if(pickedDate == null){
          return;
        }
        setState(() {
          selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SizedBox(height: 10,),
      SingleChildScrollView(
        child: Card(
          elevation: 0,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10
            ),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Note'),
                  controller: titleController,
                  onSubmitted: (_) => submitData(),
                ),
                TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    onSubmitted: (_) => submitData()
                    ),
                
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                      ),
                    ),
                      FlatButton(
                        onPressed: presenDatePicker, 
                        child: Text('Choose Date',
                        style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red[900]),
                        ))
                    ],),
                )
      
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 25,),
      RaisedButton(
              child: Text('Add Transaction'),
              color: Colors.teal,
              textColor: Colors.white,
              onPressed: submitData,
            ),

      // Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
      //   children: [
      //      ToggleSwitch(
      //         initialLabelIndex: 1,
      //         cornerRadius: 20,
      //         changeOnTap: true,
      //         activeFgColor: Colors.white,
      //         activeBgColor: [Colors.green],
      //         inactiveBgColor: Colors.redAccent,
      //         minHeight: 70,
      //         minWidth: 150, 
      //         icons: [Icons.call_missed_outgoing_outlined,
      //         Icons.add],
      //         iconSize: 35,  
      //         totalSwitches: 2,
      //         labels: ['Spent', 'Income'],
      //         onToggle: (index) {
      //             widget.addTrans(
      //             titleController.text,
      //               double.parse(amountController.text),
      //             );
      //             Navigator.of(context).pop();
      //            },
      //     ),
      //   ],
      // ),
      SizedBox(
        height: 20,
      ),
    ]);
  }
}
