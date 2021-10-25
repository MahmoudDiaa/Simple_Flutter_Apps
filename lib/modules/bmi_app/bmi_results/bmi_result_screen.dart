import 'package:flutter/material.dart';

class BMIResultScreen extends StatelessWidget {
final double result ;
final bool isMale;
final int age ;

  const BMIResultScreen({required  this.result , required this.isMale,required this.age}) ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender : ${isMale?'Male':'Female'}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),


            ),
            Text(
              'Result : ${result.round()}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),


            ),
            Text(
              'Age : $age',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),


            )
          ],
        ),
      ),
    );
  }
}
