import 'package:flutter/material.dart';
import 'package:tddfullproject/features/random_number/domain/entity/random_number.dart';

class RandomDisplay extends StatelessWidget {
  final RandomNumber Randomnumber;

  const RandomDisplay({
    required this.Randomnumber,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            Randomnumber.number.toString(),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                 Randomnumber.text,
                  style: TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
