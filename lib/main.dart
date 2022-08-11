import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String msg = "ACTIVE";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              //title: const Text('OpenPix on Flutter'),
              ),
          body: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                QrImage(
                  data: "1234567890",
                  version: QrVersions.auto,
                  size: 200.0,
                ),
                const Text("status"),
                Text(
                  msg,
                  style: TextStyle(fontSize: 13, fontStyle: FontStyle.normal),
                ),
                Container(
                  margin: const EdgeInsets.all(25),
                  child: ElevatedButton(
                    onPressed: _changeText,
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                    ), // Background color
                    child: const Text(
                      'Doar',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ]))),
    );
  }

  _changeText() {
    setState(() {
      if (msg == 'ACTIVE') {
        msg = 'COMPLETED';
      } else if (msg == 'COMPLETED') {
        msg = 'ACTIVE';
      }
    });
  }
}
