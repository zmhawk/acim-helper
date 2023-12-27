import 'dart:async';

import 'package:acim_helper/pages/search/search_panel.dart';
import 'package:acim_helper/pages/share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SearchPage extends StatefulHookWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
    return SearchBar(
      hintText: '搜索',
      focusNode: focusNode,
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return const SearchPanel();
            });
        Timer(const Duration(milliseconds: 10), () {
          focusNode.unfocus(
              disposition: UnfocusDisposition.previouslyFocusedChild);
        });
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
  }
}
