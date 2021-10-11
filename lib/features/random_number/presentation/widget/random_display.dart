import 'package:flutter/material.dart';
import 'package:tddfullproject/features/random_number/domain/entity/random_number.dart';

class TriviaDisplay extends StatelessWidget {
  final RandomNumber numberTrivia;

  const TriviaDisplay({
    required this.numberTrivia,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      child: Column(
        children: [
          Text(
            numberTrivia.number.toString(),
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Text(
                  numberTrivia.text,
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