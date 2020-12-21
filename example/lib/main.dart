import 'package:slerver/slerver.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Slerver server;
  final String host = '10.42.0.241';
  final int port = 9000;
  @override
  void initState() {
    super.initState();
    startServer();
  }

  startServer() async {
    server = await Slerver.createServer(host, port);
    var router = server.router;
    router
      ..on(
        '/name',
        (Map m) async =>
            {'received': m, 'message': 'Bonjour ${m['name']} ${m['surname']}'})
      ..on('/surname', (List p) async {
        await Future.delayed(Duration(seconds: 5));
        return p?.reversed?.toList();
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Row(children: [
            Center(
              child: FloatingActionButton(
                child: Text('Start Server'),
                onPressed: startServer,
              ),
            ),
            SizedBox(width: 100),
          ])),
    );
  }
}
