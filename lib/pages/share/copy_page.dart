import 'package:acim_helper/pages/share/copy_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';

class CopyList extends StatelessWidget {
  const CopyList(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    final copySentence = CopySentence(text).obs;

    void copy() {
      Clipboard.setData(ClipboardData(text: copySentence.value.copySentence()))
          .then((value) {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('已复制'),
        ));
      });
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(
            copySentence.value.title,
            style: const TextStyle(fontSize: 18),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: copySentence.value.arr.length,
              itemBuilder: (context, index) {
                bool selected = copySentence.value.copyIndexes[index]!;
                return CheckboxListTile(
                  title: Text(copySentence.value.arr[index]),
                  value: selected,
                  onChanged: (value) {
                    copySentence.value.copyIndexes[index] = value!;
                  },
                  selected: selected,
                  selectedTileColor: theme.colorScheme.primaryContainer,
                  dense: true,
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('取消')),
              FilledButton(
                onPressed: copy,
                child: const Text('复制'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
