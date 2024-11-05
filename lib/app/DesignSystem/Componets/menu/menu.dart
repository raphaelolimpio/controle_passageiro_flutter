import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  final List<PopupMenuEntry> options;

  const Menu({Key? key, required this.options}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => options,
    );
  }
}
