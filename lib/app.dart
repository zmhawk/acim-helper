import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/pages/home.dart';
import 'package:acim_helper/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final loaded = false.obs;

    return Obx(() {
      if (!loaded.value) {
        return LoadingPage(onInitializationComplete: () {
          loaded.value = true;
        });
      }

      return MaterialApp(
        title: 'ACIM 小帮手',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
            useMaterial3: true),
        darkTheme: ThemeData.dark(),
        themeMode: Config().themeMode,
        home: const HomePage(),
      );
    });
  }
}
