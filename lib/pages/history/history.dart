import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/history.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class HistoryPage extends HookWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryModel historyModel = useContext().watch<HistoryModel>();
    List<DataItem> history = historyModel.history;

    return Scaffold(
        appBar: AppBar(
          title: const Text('浏览历史'),
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: const Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: history.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                dense: true,
                title: Text(
                  history[index].text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }));
  }
}
