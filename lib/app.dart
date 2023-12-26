import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/models/text.dart';
import 'package:acim_helper/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/data.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var currentPage = 1;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var themeMode = Config().themeMode;
    print('themeMode: $themeMode');
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true),
      darkTheme: ThemeData.dark(),
      themeMode: Config().themeMode,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => DataModel()),
        ChangeNotifierProvider(create: (context) => CurrentText()),
      ], child: const HomePage()),
    );
  }
}
