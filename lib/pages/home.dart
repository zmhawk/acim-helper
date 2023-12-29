import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/text.dart';
import 'package:acim_helper/pages/favorite/favorite_btn.dart';
import 'package:acim_helper/pages/menu/menu.dart';
import 'package:acim_helper/pages/search/search.dart';
import 'package:acim_helper/pages/share/share.dart';
import 'package:acim_helper/pages/text.dart';
import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class HomeArguments {
  final int index;

  HomeArguments(this.index);
}

class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    CurrentText currentText = useContext().watch<CurrentText>();
    DataModel data = useContext().watch<DataModel>();
    HistoryModel history = useContext().watch<HistoryModel>();
    // ScaffoldState scaffold = Scaffold.of(context);

    useEffect(() {
      history.add(currentText.current);
      return null;
    }, [currentText.current]);

    return Scaffold(
      appBar: AppBar(
          title: const Text('ACIM 小帮手'),
          actions: const [SearchPage(), FavoriteBtn(), ShareMenu()]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextView(
                index: currentText.getCurrent.index,
                key: Key(currentText.getCurrent.index.toString()),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            currentText.changeText(data.randomIndex());
          });
        },
        child: const Icon(Icons.refresh_outlined),
      ),
      drawer: const MenuDrawer(),
    );
  }
}
