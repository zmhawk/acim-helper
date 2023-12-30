import 'package:acim_helper/configuration.dart';
import 'package:acim_helper/firebase_options.dart';
import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/favorite.dart';
import 'package:acim_helper/models/history.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get_storage/get_storage.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key, required this.onInitializationComplete})
      : super(key: key);

  final Function onInitializationComplete;

  void initializeApp(BuildContext context) async {
    await GetStorage.init();
    Config.load();
    await Future.wait([
      Database.load(),
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
    ]);
    HistoryModel.load();
    FavoriteModel.load();
    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    if (!kIsWeb) {
      FlutterError.onError =
          FirebaseCrashlytics.instance.recordFlutterFatalError;
    }

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
