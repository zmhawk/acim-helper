import 'package:acim_helper/configuration.dart';
import 'package:flutter/material.dart';

class TextView extends StatelessWidget {
  const TextView({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Expanded(
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: SelectionArea(
            child: Text(
              text,
              style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: Config().fontSize.toDouble(),
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  height: 1.8),
            ),
          ),
        ),
      ),
    );
  }
}
