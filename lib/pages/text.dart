import 'package:acim_helper/configuration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class TextView extends HookWidget {
  const TextView({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Config config = useContext().watch<Config>();

    return Expanded(
      child: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 75),
            child: SelectionArea(
              child: Text(
                text,
                style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: config.fontSize,
                    fontWeight: FontWeight.normal,
                    decoration: TextDecoration.none,
                    height: 1.8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
