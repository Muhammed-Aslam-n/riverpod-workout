import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Client',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const WebSocketPage(),
    );
  }
}

class WebSocketPage extends StatefulWidget {
  const WebSocketPage({super.key});
  @override
  State<WebSocketPage> createState() => _WebSocketPageState();
}

class _WebSocketPageState extends State<WebSocketPage> {
  late WebSocketChannel channel;
  final TextEditingController controller = TextEditingController();
  String receivedMessage = '';

  @override
  void initState() {
    super.initState();
    // Connect to the local WebSocket server
    channel = WebSocketChannel.connect(
      Uri.parse('ws://localhost:8080'),
    );

    // Listen for incoming messages
    channel.stream.listen((message) {
      setState(() {
        receivedMessage = message;
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    controller.dispose();
    super.dispose();
  }

  void sendMessage() {
    if (controller.text.isNotEmpty) {
      channel.sink.add(controller.text);
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WebSocket Client')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(labelText: 'Enter message'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: sendMessage,
              child: const Text('Send Message'),
            ),
            const SizedBox(height: 20),
            Text('Server says: $receivedMessage'),
          ],
        ),
      ),
    );
  }
}
