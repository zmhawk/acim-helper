import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: SelectionArea(
          child: Text(
            text,
            // textAlign: TextAlign.justify,
            style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.none,
                height: 1.8),
          ),
        ),
      ),
    );
  }
}
