import 'package:acim_helper/models/data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchView extends StatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    ScaffoldState scaffold = Scaffold.of(context);
    ThemeData theme = Theme.of(context);
    List<DataItem> dataList = context.watch<DataModel>().data;

    return [
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ChoiceChip(label: Text('模糊搜索'), selected: true),
          ChoiceChip(
            label: Text('精确搜索'),
            selected: false,
          )
        ],
      ),
      const Divider(),
      ...result.data.map((item) {
        return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Card(
                color: theme.colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(item.text),
                )));
      }),
    ].toList();
  }
}
