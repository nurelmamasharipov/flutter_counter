import 'package:meta/meta.dart';

@immutable
class CounterState {
  final int count;
  const CounterState({required this.count});
  CounterState copyWith({int? count}) => CounterState(count: count ?? this.count);
}