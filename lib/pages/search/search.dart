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
  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);

    return SearchBar(
      hintText: '搜索',
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return const SearchPanel();
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
