import 'package:controleusuario/app/DesignSystem/Componets/Card/custom_card.dart';
import 'package:controleusuario/app/DesignSystem/Componets/Card/custom_card_view_mode.dart';
import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final List<CustomCardViewMode> cards; // Lista de ViewModels para os cards

  const ListCard({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return CustomCard(
          viewModel: cards[index],
          listOptions: const [
            // Defina as opções do ListButtons aqui, se necessário
          ],
        );
      },
    );
  }
}
