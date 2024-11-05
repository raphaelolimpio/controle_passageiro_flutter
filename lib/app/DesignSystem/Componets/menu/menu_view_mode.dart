import 'package:flutter/material.dart';

class MenuViewMode {
  static List<PopupMenuEntry> getMenuOptions(BuildContext context) {
    return [
      PopupMenuItem(
        child: TextButton(
          onPressed: () {
            // Implementação da ação 1
          },
          child: const Text('Opção 1'),
        ),
      ),
      PopupMenuItem(
        child: TextButton(
          onPressed: () {
            // Implementação da ação 2
          },
          child: const Text('Opção 2'),
        ),
      ),
      // Adicione mais opções conforme necessário
    ];
  }
}
