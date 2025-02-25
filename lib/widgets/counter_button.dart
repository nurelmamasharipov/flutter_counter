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
  Timer? _resetTimer;
  bool _isPressed = false;

  @override
  void dispose() {
    _incrementTimer?.cancel();
    _resetTimer?.cancel();
    super.dispose();
  }

  void _startIncrement(BuildContext context) {
    _incrementTimer?.cancel();
    _incrementTimer = Timer.periodic(Duration(milliseconds: 500), (_) {
      context.read<CounterBloc>().add(IncrementCounter());
    });
  }

  void _startResetTimer(BuildContext context) {
    _resetTimer?.cancel();
    _resetTimer = Timer(Duration(seconds: 3), () {
      context.read<CounterBloc>().add(DecrementCounter());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        setState(() => _isPressed = true);
        _startIncrement(context);
      },
      onLongPressEnd: (_) {
        setState(() => _isPressed = false);
        _incrementTimer?.cancel();
        _startResetTimer(context);
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