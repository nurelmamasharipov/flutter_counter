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
  Timer? _timer;
  bool _isPressed = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(BuildContext context) {
    _timer = Timer(Duration(seconds: 3), () {
      if (!_isPressed) {
        context.read<CounterBloc>().add(ResetCounter());
      }
    });
  }

  void _incrementCounter(BuildContext context) {
    context.read<CounterBloc>().add(IncrementCounter());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        _incrementCounter(context);
        _startTimer(context);
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        _timer?.cancel();
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
        _timer?.cancel();
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