import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class HistoryPage extends HookWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    HistoryModel historyModel = useContext().watch<HistoryModel>();
    List<DataItem> history = historyModel.history;
    CurrentText currentText = useContext().watch<CurrentText>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('浏览历史'),
          leading: IconButton(
              onPressed: () => {Navigator.pop(context)},
              icon: const Icon(Icons.arrow_back_outlined)),
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
                onTap: () {
                  currentText.changeText(history[index].index);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Navigator.defaultRouteName,
                    (route) => false,
                  );
                },
              );
            }));
  }
}
