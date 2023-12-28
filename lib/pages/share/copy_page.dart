import 'package:acim_helper/pages/share/copy_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CopyList extends StatefulHookWidget {
  const CopyList(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  _CopyListState createState() => _CopyListState();
}

class _CopyListState extends State<CopyList> {
  CopySentence copySentence = CopySentence('');

  @override
  void initState() {
    super.initState();
    copySentence = CopySentence(widget.text);
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    void copy() {
      Clipboard.setData(ClipboardData(text: copySentence.copySentence()))
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
            copySentence.title,
            style: const TextStyle(fontSize: 18),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: copySentence.arr.length,
              itemBuilder: (context, index) {
                bool selected = copySentence.copyIndexes[index]!;
                return CheckboxListTile(
                  title: Text(copySentence.arr[index]),
                  value: selected,
                  onChanged: (value) {
                    setState(() {
                      copySentence.copyIndexes[index] = value!;
                    });
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
