import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';

class CounterButton extends StatefulWidget {
  @override
  _CounterButtonState createState() => _CounterButtonState();
}

class _CounterButtonState extends State<CounterButton> {
  Timer? _incrementTimer;
  bool _isPressed = false;

  @override
  void dispose() {
    _incrementTimer?.cancel();
    super.dispose();
  }

  void _startIncrement(BuildContext context) {
    _incrementTimer?.cancel();
    _incrementTimer = Timer.periodic(Duration(milliseconds: 500), (_) {
      context.read<CounterBloc>().add(IncrementCounter());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() => _isPressed = true);
        context.read<CounterBloc>().add(StopAutoDecrement());
        _startIncrement(context);
      },
      onLongPressEnd: (_) {
        setState(() => _isPressed = false);
        _incrementTimer?.cancel();
        context.read<CounterBloc>().add(StartAutoDecrement());
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          'Зажмите меня',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
