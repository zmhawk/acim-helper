import 'package:flutter/material.dart';

class ShareMenu extends StatefulWidget {
  const ShareMenu({Key? key}) : super(key: key);

  @override
  _ShareMenuState createState() => _ShareMenuState();
}

class _ShareMenuState extends State<ShareMenu> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.share),
      itemBuilder: (context) {
        return [
          const PopupMenuItem<String>(
            value: 'copy',
            child: Text('复制整段'),
          ),
          const PopupMenuItem<String>(
            value: 'copy_sentence',
            child: Text('复制句子'),
          ),
        ];
      },
    );
  }
}
