import 'package:acim_helper/pages/menu/menu.dart';
import 'package:acim_helper/pages/search/search.dart';
import 'package:acim_helper/pages/text.dart';
import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DataItem current = DataItem(-1, 'Loading...');
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, DataModel data, child) {
      if (current.index == -1) {
        current = data.random();
      }
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SearchPage(),
              TextView(text: current.text),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              current = data.random();
            });
          },
          child: const Icon(Icons.refresh),
        ),
        drawer: const MenuDrawer(),
      );
    });
  }
}
