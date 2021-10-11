import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tddfullproject/features/random_number/presentation/bloc/random_number_bloc.dart';
import 'package:tddfullproject/features/random_number/presentation/bloc/random_number_event.dart';

class RandomControls extends StatefulWidget {
  @override
  _RandomControlsState createState() => _RandomControlsState();
}

class _RandomControlsState extends State<RandomControls> {
  final controller = TextEditingController();
  String inputStr = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Colors.red, width: 1.0)),
            hintText: 'Enter a number',
          ),
          onChanged: (value) {
            inputStr = value;
          },
          onSubmitted: (_) {
            dispatchConcrete();
          },
        ),
        SizedBox(height: 30),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.blue,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: TextButton(
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  onPressed: dispatchConcrete,
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.red,
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 0.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: TextButton(
                  child: Text(
                    'Get random number',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold,fontSize: 15),
                  ),
                  onPressed: dispatchRandom,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void dispatchConcrete() {
    controller.clear();
    BlocProvider.of<RandomNumberBloc>(context)
        .add(GetRandomForConcreteNumber(inputStr));
  }

  void dispatchRandom() {
    controller.clear();
    BlocProvider.of<RandomNumberBloc>(context).add(GetForRandomNumber());
  }
}
