import 'dart:async';

import 'package:acim_helper/pages/search/search_panel.dart';
import 'package:acim_helper/pages/share/share.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchPage extends StatefulHookWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final ContainerTransitionType _containerTransitionType =
      ContainerTransitionType.fade;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
    ThemeData theme = Theme.of(context);

    return OpenContainer(
      transitionType: _containerTransitionType,
      transitionDuration: const Duration(milliseconds: 500),
      tappable: false,
      openBuilder: (context, _) {
        return const SearchPanel();
      },
      closedShape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
      closedColor: theme.colorScheme.surface,
      openColor: theme.colorScheme.surface,
      middleColor: theme.colorScheme.surface,
      closedBuilder: (context, openContainer) {
        return SearchBar(
          hintText: '搜索',
          focusNode: focusNode,
          onTap: () {
            openContainer();
          },
          leading: IconButton(
            onPressed: () {
              scaffold.openDrawer();
            },
            icon: const Icon(Icons.menu),
          ),
          trailing: const [
            ShareMenu(),
          ],
        );
      },
      onClosed: (data) {
        Timer(
          const Duration(milliseconds: 10),
          () {
            focusNode.unfocus();
          },
        );
      },
    );
  }
}
