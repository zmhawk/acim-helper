import 'package:acim_helper/pages/loading.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true),
      darkTheme: ThemeData.dark(),
      home: ChangeNotifierProvider(
        create: (context) => DataModel(),
        child: const LoadingPage(),
      ),
    );
  }
}
