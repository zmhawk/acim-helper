import 'package:acim_helper/index/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/data.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var currentPage = 1;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: ChangeNotifierProvider(
          create: (context) => DataModel(),
          child: Scaffold(
              body: const MyHomePage(),
              bottomNavigationBar: NavigationBar(
                selectedIndex: currentPage,
                onDestinationSelected: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                destinations: const [
                  // NavigationDestination(
                  //   icon: Icon(Icons.history),
                  //   label: '历史',
                  //   selectedIcon: Icon(Icons.history),
                  // ),
                  NavigationDestination(
                    icon: Icon(Icons.search),
                    label: '搜索',
                    selectedIcon: Icon(Icons.search),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.home),
                    label: '首页',
                    selectedIcon: Icon(Icons.home),
                  ),
                  NavigationDestination(
                    icon: Icon(Icons.settings),
                    label: '设置',
                    selectedIcon: Icon(Icons.settings),
                  ),
                ],
              )),
        ));
  }
}
