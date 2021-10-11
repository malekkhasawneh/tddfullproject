import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tddfullproject/features/random_number/presentation/bloc/bloc.dart';
import 'package:tddfullproject/features/random_number/presentation/bloc/random_number_bloc.dart';
import 'package:tddfullproject/features/random_number/presentation/widget/loading_widget.dart';
import 'package:tddfullproject/features/random_number/presentation/widget/random_controls.dart';
import 'package:tddfullproject/features/random_number/presentation/widget/random_display.dart';
import 'package:tddfullproject/features/random_number/presentation/widget/show_message.dart';
import 'package:tddfullproject/injection_container.dart';

class RandomNumberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Random Number'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.red,
                    Colors.blue
                  ]),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

   buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<RandomNumberBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<RandomNumberBloc, RandomNumberState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Enter Number Or click on Random',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.random);
                  } else if (state is Error) {
                    return MessageDisplay(
                      message: state.message,
                    );
                  }
                  return CircularProgressIndicator();
                },
              ),
              SizedBox(height: 20),
              // Bottom half
              RandomControls()
            ],
          ),
        ),
      ),
    );
  }
}
