import 'package:acim_helper/pages/search/search_panel.dart';
import 'package:acim_helper/pages/search/search_utils.dart';
import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  final ContainerTransitionType _containerTransitionType =
      ContainerTransitionType.fadeThrough;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    loadWords();

    return OpenContainer(
      transitionType: _containerTransitionType,
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, _) {
        return SearchPanel();
      },
      closedColor: theme.colorScheme.surface,
      openColor: theme.colorScheme.surface,
      middleColor: theme.colorScheme.surface,
      closedElevation: 0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      closedBuilder: (context, openContainer) {
        return IconButton(
          icon: const Icon(Icons.search_outlined),
          onPressed: () {
            openContainer();
          },
        );
      },
    );
  }
}
