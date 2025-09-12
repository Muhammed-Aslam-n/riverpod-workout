// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:todo_app_riverpod/provider/riverpod_provider.dart';
// import 'package:todo_app_riverpod/provider/samples/notifier_multi_value.dart';
//
// class SampleScreen extends ConsumerWidget {
//   const SampleScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//     ref.listen(counterProvider, (k,l){
//       if(k!>5){
//         debugPrint('Value greater than 5');
//       }
//     });
//     return SafeArea(
//       child: Scaffold(
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             ref.read(counterProvider.notifier).state++;
//           },
//         ),
//         body: Padding(
//           padding: EdgeInsetsGeometry.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Text(ref.watch(greetingProvider)),
//               SizedBox(height: 20),
//               Text(ref.watch(counterProvider).toString()),
//               SizedBox(height: 20),
//               ref
//                   .watch(futureProvider)
//                   .when(
//                     data: (value) => Text(value),
//                     error: (error, stack) => Text('Error Occurred'),
//                     loading: () {
//                       return Column(
//                         children: [
//                           SizedBox(
//                             height: 20,
//                             child: CircularProgressIndicator.adaptive(),
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//
//               SizedBox(height: 20),
//               counter2Widget(ref),
//               SizedBox(height: 20),
//               personModelWidget(ref),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   counter2Widget(WidgetRef ref) {
//     return Container(
//       margin: EdgeInsets.all(12),
//       padding: EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.shade200, blurRadius: 2, spreadRadius: 2),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Counter is ${ref.watch(counterModelProvider).action ?? ''} and value is ${ref.watch(counterModelProvider).value ?? 0}',
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FloatingActionButton(
//                 onPressed: () {
//                   ref.read(counterModelProvider.notifier).incrementCounter();
//                 },
//                 child: Icon(Icons.add),
//               ),
//               SizedBox(width: 20),
//               FloatingActionButton(
//                 onPressed: () {
//                   ref.read(counterModelProvider.notifier).decrement();
//                 },
//                 child: Icon(Icons.remove),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Widget to display and update the state
//   Widget personModelWidget(WidgetRef ref) {
//     final state = ref.watch(personModelProvider);
//
//     ref.listen(counterProvider, (k,l){
//       if(k!>5){
//         debugPrint('Value greater than 5');
//       }
//     });
//
//     return Container(
//       margin: const EdgeInsets.all(12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.grey.shade200, blurRadius: 2, spreadRadius: 1),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text('Name: ${state.name ?? "No name"}'),
//           Text('Age: ${state.age ?? 0}'),
//           Text('DOB: ${state.dob?.toString() ?? "No DOB"}'),
//           const SizedBox(height: 20),
//           Row(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FloatingActionButton(
//                 onPressed: () {
//                   ref
//                       .read(personModelProvider.notifier)
//                       .updateName(
//                         'User ${DateTime.now().millisecondsSinceEpoch}',
//                       );
//                 },
//                 child: const Icon(Icons.person),
//               ),
//               const SizedBox(width: 20),
//               FloatingActionButton(
//                 onPressed: () {
//                   ref.read(personModelProvider.notifier).incrementAge();
//                 },
//                 child: const Icon(Icons.add),
//               ),
//               const SizedBox(width: 20),
//               FloatingActionButton(
//                 onPressed: () {
//                   ref
//                       .read(personModelProvider.notifier)
//                       .updateDob(DateTime.now());
//                 },
//                 child: const Icon(Icons.calendar_today),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
