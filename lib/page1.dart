import 'package:flutter/material.dart';
import 'page2.dart';

class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  // ignore: library_private_types_in_public_api
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Text('OpenPix Demo'),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const Page2(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(primary: Colors.indigo),
              child: const Text('Doar')),
        ],
      ),
    );
  }
}
