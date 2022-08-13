import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

Future<Charge> fetchCharge() async {
  final response = await http.get(
      Uri.parse('https://mocki.io/v1/f5da9654-d587-4386-9ed6-1bd90806eb89'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Charge.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load pix');
  }
}

class Charge {
  final int charge;
  final String status;
  final String key;

  const Charge({
    required this.charge,
    required this.status,
    required this.key,
  });

  factory Charge.fromJson(Map<String, dynamic> json) {
    return Charge(
      charge: json['charge'],
      status: json['status'],
      key: json['key'],
    );
  }
}

void main() => runApp(const Page2());

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  late Future<Charge> futureCharge;
  @override
  void initState() {
    super.initState();
    futureCharge = fetchCharge();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'OpenPix Example',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: Scaffold(
            appBar: AppBar(
              title: const Text('OpenPix Demo'),
            ),
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //##QrCode##
                  Center(
                    child: FutureBuilder<Charge>(
                      future: futureCharge,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return QrImage(
                            data: snapshot.data!.key,
                            version: QrVersions.auto,
                            size: 200.0,
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),

                  //##status##

                  Center(
                    child: FutureBuilder<Charge>(
                      future: futureCharge,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text('Status: ' '${snapshot.data!.status}');
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }

                        // By default, show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo), // Background color
                      child: const Text(
                        'VALIDADE DONATION',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.indigo),
                      child: const Text('Voltar a pagina inicial'))
                ])));
  }
}
