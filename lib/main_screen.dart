import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_riverpod/provider/riverpod_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.read(counterProvider.notifier).state++;
          },
        ),
        body: Padding(
          padding: EdgeInsetsGeometry.all(16),
          child: Column(
            children: [
              Text(ref.watch(greetingProvider)),
              SizedBox(height: 20),
              Text(ref.watch(counterProvider).toString()),
            ],
          ),
        ),
      ),
    );
  }
}
