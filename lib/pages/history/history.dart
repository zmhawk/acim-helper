import 'package:acim_helper/models/drawItem.dart';
import 'package:acim_helper/models/history.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  drawItem.value = history[index];
                  viewItem.value = history[index];
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
