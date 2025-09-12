// // Define the provider
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// final personModelProvider = NotifierProvider<CounterNotifier, ({String? name, int? age, DateTime? dob})>(
//       () => CounterNotifier(),
// );
//
// // Notifier to manage the record state
// class CounterNotifier extends Notifier<({String? name, int? age, DateTime? dob})> {
//   @override
//   ({String? name, int? age, DateTime? dob}) build() {
//     return (name: null, age: null, dob: null); // Initial state
//   }
//
//   void updateName(String newName) {
//     state = (name: newName, age: state.age, dob: state.dob); // Create new record
//   }
//
//   void incrementAge() {
//     state = (name: state.name, age: (state.age ?? 0) + 1, dob: state.dob); // Create new record
//   }
//
//   void updateDob(DateTime newDob) {
//     state = (name: state.name, age: state.age, dob: newDob); // Create new record
//   }
// }