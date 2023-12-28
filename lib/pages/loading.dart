import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/history.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  final Function onInitializationComplete;

  void initializeApp(BuildContext context) async {
    await Config.load();
    await DataModel().loadData();
    await HistoryModel.load();
    onInitializationComplete();
  }

  @override
  Widget build(BuildContext context) {
    initializeApp(context);

    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: const Scaffold(
          body: Center(
        child: CircularProgressIndicator(),
      )),
    );
  }
}
