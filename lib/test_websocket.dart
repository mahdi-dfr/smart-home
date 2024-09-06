import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient extends StatefulWidget {
  final String serverUri;

  WebSocketClient({required this.serverUri});

  @override
  _WebSocketClientState createState() => _WebSocketClientState();
}

class _WebSocketClientState extends State<WebSocketClient> {
  late WebSocketChannel channel;
  TextEditingController _controller = TextEditingController();
  List<String> _messages = [];

  @override
  void initState() {
    super.initState();
    // Connect to the WebSocket server
    channel = IOWebSocketChannel.connect('ws://esp32-server.local:81');

    // Listen for incoming messages
    channel.stream.listen((message) {
      setState(() {
        _messages.add("Message from server: $message");
      });
    }, onError: (error) {
      setState(() {
        _messages.add("Error: $error");
      });
    }, onDone: () {
      setState(() {
        _messages.add("Connection closed by the server.");
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      final message = {"clientData": _controller.text};
      channel.sink.add(json.encode(message));
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WebSocket Client'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_messages[index]),
                  );
                },
              ),
            ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter your message',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _sendMessage,
              child: Text('Send'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                channel.sink.close();
              },
              child: Text('Close Connection'),
            ),
          ],
        ),
      ),
    );
  }
}

