import 'package:flutter/material.dart';

class EmptyStateWidget extends StatelessWidget {
  final VoidCallback onAddTask;

  const EmptyStateWidget({super.key, required this.onAddTask});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for illustration image
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.inbox, size: 100, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            Text("No tasks yet", style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 8),
            Text(
              "Tap the + button to add your first task",
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: onAddTask,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Add Task"),
            ),
          ],
        ),
      ),
    );
  }
}
