import 'dart:developer';

import 'package:acim_helper/pages/search/search_panel.dart';
import 'package:acim_helper/pages/search/search_utils.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  final ContainerTransitionType _containerTransitionType =
      ContainerTransitionType.fadeThrough;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    loadWords();

    log('SearchPage');

    return IconButton(
      icon: const Icon(Icons.search_outlined),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const SearchPanel(),
                fullscreenDialog: true));
      },
    );
  }
}
