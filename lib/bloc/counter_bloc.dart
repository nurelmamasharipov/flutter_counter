import 'dart:async';
import 'package:bloc/bloc.dart';
import 'counter_event.dart';
import 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterState(count: 1000)) {
    on<IncrementCounter>(_onIncrement);
    on<ResetCounter>(_onReset);
  }

  void _onIncrement(IncrementCounter event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: state.count + 1));
  }

  void _onReset(ResetCounter event, Emitter<CounterState> emit) {
    emit(state.copyWith(count: 1000));
  }
}