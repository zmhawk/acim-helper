import 'package:acim_helper/models/text.dart';
import 'package:acim_helper/pages/search/copy.dart';
import 'package:acim_helper/pages/share/copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ShareMenu extends StatefulHookWidget {
  const ShareMenu({Key? key}) : super(key: key);

  @override
  _ShareMenuState createState() => _ShareMenuState();
}

class _ShareMenuState extends State<ShareMenu> {
  @override
  Widget build(BuildContext context) {
    CurrentText currentText = useContext().watch<CurrentText>();

    void copy() {
      Clipboard.setData(ClipboardData(text: currentText.getCurrent.text))
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('已复制'),
                ))
              });
    }

    void copySentenceStart() {
      showDialog(
          context: context,
          builder: (context) {
            return CopyList(currentText.getCurrent.text);
          });
    }

    return PopupMenuButton<String>(
      icon: const Icon(Icons.share),
      onSelected: (value) {
        switch (value) {
          case 'copy':
            copy();
            break;
          case 'copy_sentence':
            copySentenceStart();
            break;
        }
      },
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'copy',
            child: Text('复制整段'),
          ),
          PopupMenuItem<String>(
            value: 'copy_sentence',
            enabled: canCopySentence(currentText.getCurrent.text),
            child: const Text('复制句子'),
          ),
        ];
      },
    );
  }
}
