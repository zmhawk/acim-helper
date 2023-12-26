import 'package:acim_helper/models/text.dart';
import 'package:acim_helper/pages/menu/menu.dart';
import 'package:acim_helper/pages/search/search.dart';
import 'package:acim_helper/pages/text.dart';
import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CurrentText current = useContext().read<CurrentText>();
    DataModel data = useContext().read<DataModel>();
    print('home');
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SearchPage(),
            TextView(text: current.getCurrent.text),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            current.changeText(data.randomIndex());
          });
        },
        child: const Icon(Icons.refresh),
      ),
      drawer: const MenuDrawer(),
    );
  }
}
