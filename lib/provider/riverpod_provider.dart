// Simple
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final greetingProvider = Provider((ref) => 'Hello from Riverpod!');

final counterProvider = StateProvider<int>((ref) => 0);

// FutureProvider
final futureProvider = FutureProvider<String>((ref) async {
  // await twoSecFuture();
  // await fourSecFuture();
  // await sixSecFuture();
  // return 'Data Loaded';
  // return Future.wait([
  //   twoSecFuture(),
  //   fourSecFuture(),
  //   sixSecFuture()
  // ]).then((_) => 'Data Loaded');
  //
  return Future.delayed(Duration(milliseconds: 1000)).then((_) {
    return 'Data Loaded';
  });
});

Future twoSecFuture() async {
  return await Future.delayed(
    Duration(seconds: 2),
  ).then((_) => debugPrint('2 sec completed'));
}

Future fourSecFuture() async => await Future.delayed(
  Duration(seconds: 2),
).then((_) => debugPrint('2 sec completed'));

Future sixSecFuture() async => await Future.delayed(
  Duration(seconds: 6),
).then((_) => debugPrint('6 sec completed'));

// using the model

final counterModelProvider = NotifierProvider<CounterNotifier, Sample>(
  () => CounterNotifier(),
);

class CounterNotifier extends Notifier<Sample> {
  Sample sample = Sample();

  @override
  Sample build() {
    return sample;
  }

  incrementCounter() {
    state = Sample(action: 'Incrementing', value: (state.value ?? 0) + 1);
  }

  decrement() {
    state = Sample(action: 'Decrementing', value: (state.value ?? 0) - 1);
  }
}

class Sample {
  String? action;
  int? value;

  Sample({this.action, this.value});
}




