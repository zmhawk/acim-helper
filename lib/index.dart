import 'dart:js_interop';

import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String text = 'Hello World';

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, DataModel data, child) {
      var item = data.random();
      if (item.isNull) {
        return const Scaffold(
          body: Center(
            child: Text('Loading...'),
          ),
        );
      }
      text = item!.value;
      return Scaffold(
        body: Center(
          child: SelectionArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    text,
                    style: const TextStyle(fontSize: 20, height: 1.8),
                  ),
                ],
              ),
            ),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: _incrementCounter,
        //   tooltip: 'Increment',
        //   child: const Icon(Icons.add),
        // ), // This trailing comma makes auto-formatting nicer for build methods.
      );
    });
  }
}
