import 'package:acim_helper/models/data.dart';
import 'package:acim_helper/models/viewItem.dart';
import 'package:acim_helper/pages/share/copy_utils.dart';
import 'package:acim_helper/pages/share/copy_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class ShareMenu extends StatelessWidget {
  const ShareMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void copy() {
      Clipboard.setData(ClipboardData(text: viewItem.value.text))
          .then((value) => {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('已复制'),
                ))
              });
    }

    void copySentenceStart() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return CopyList(
              viewItem.value.text,
            );
          },
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height - 64,
          ),
          isScrollControlled: true,
          useSafeArea: true);
    }

    return PopupMenuButton<String>(
      icon: const Icon(Icons.share_outlined),
      position: PopupMenuPosition.under,
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
            enabled: canCopySentence(viewItem.value.text),
            child: const Text('复制句子'),
          ),
        ];
      },
    );
  }
}
