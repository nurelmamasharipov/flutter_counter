abstract class CounterEvent {}
class IncrementCounter extends CounterEvent {}
class DecrementCounter extends CounterEvent {}
class StartAutoDecrement extends CounterEvent {}
class StopAutoDecrement extends CounterEvent {}