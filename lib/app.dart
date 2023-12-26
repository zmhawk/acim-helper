import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/text.dart';
import 'package:acim_helper/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

import 'models/data.dart';

class GlobalProvider extends StatelessWidget {
  const GlobalProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DataModel()),
        ChangeNotifierProxyProvider<DataModel, CurrentText>(
          create: (context) => CurrentText(),
          update: (context, dataModel, currentText) => currentText!..update(),
        ),
        ChangeNotifierProxyProvider<DataModel, HistoryModel>(
          create: (context) => HistoryModel(),
          update: (context, dataModel, historyModel) => historyModel!..update(),
        ),
        ChangeNotifierProvider(create: (context) => Config())
      ],
      child: const App(),
    );
  }
}

class App extends HookWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Config config = useContext().watch<Config>();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true),
      darkTheme: ThemeData.dark(),
      themeMode: config.themeMode,
      home: const HomePage(),
    );
  }
}
