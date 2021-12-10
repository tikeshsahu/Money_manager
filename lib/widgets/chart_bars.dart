import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {

  final String lable;
  final double spendingAmount;
  final double spendingPrcntOfTotal; 
  
  const ChartBar({ Key? key, 
  required this.lable, 
  required this.spendingAmount, 
  required this.spendingPrcntOfTotal }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 20,
          child: FittedBox(
            child: Text('\$${spendingAmount.toStringAsFixed(0)}')),
        ),

        SizedBox(height: 5,),

        Container(
          height: 70,
          width: 10,
          child: Stack(
            children: [
              Container(decoration: BoxDecoration(
                border: Border.all(color: Colors.black,width: 1),
                color: Color(0xff72d8bf),
                borderRadius: BorderRadius.circular(10),
                ),
                ),

                FractionallySizedBox(
                  heightFactor: spendingPrcntOfTotal,
                  child: Container(decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),),
                )
            ],
          ),
        ),
        SizedBox(height: 8,),
        Text(lable),
      ],
    );
  }
}