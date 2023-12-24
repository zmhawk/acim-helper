import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return SelectionArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              text,
              style: const TextStyle(fontSize: 30, height: 1.8),
            ),
          ],
        ),
      ),
    );
  }
}
