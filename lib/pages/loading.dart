import 'package:acim_helper/pages/home.dart';
import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, DataModel data, child) {
      if (data.isEmpty) {
        return const Center(
          child: Text('Loading...'),
        );
      }

      return const HomePage();
    });
  }
}
