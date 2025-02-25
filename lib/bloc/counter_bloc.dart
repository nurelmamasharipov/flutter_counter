import 'dart:async';

import 'package:bloc/bloc.dart';

import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(const CounterState(count: 1000)) {
    on<IncrementCounter>(_onIncrement);
    on<DecrementCounter>(_onDecrement);
    on<StartAutoDecrement>(_onStartAutoDecrement);
    on<StopAutoDecrement>(_onStopAutoDecrement);
  }

  void _onIncrement(IncrementCounter event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count + 500));
  }

  void _onDecrement(DecrementCounter event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: (state.count - 3000).clamp(1000, double.infinity).toInt()));
  }

  Timer? _autoDecrementTimer;

  void _onStartAutoDecrement(StartAutoDecrement event, Emitter<CounterState> emit) {
    _autoDecrementTimer?.cancel();
    _autoDecrementTimer = Timer.periodic(Duration(seconds: 3), (_) {
      add(DecrementCounter());
    });
  }

  void _onStopAutoDecrement(StopAutoDecrement event, Emitter<CounterState> emit) {
    _autoDecrementTimer?.cancel();
  }
}