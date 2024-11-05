import 'package:flutter/material.dart';
import 'custom_card_view_mode.dart';

class CustomCard extends StatelessWidget {
  final CustomCardViewMode viewModel;
  final List<Widget>? listOptions; // Lista de opções para o menu

  const CustomCard({super.key, required this.viewModel, this.listOptions});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: viewModel.onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: viewModel.imageUrl != null &&
                        viewModel.imageUrl!.isNotEmpty
                    ? NetworkImage(viewModel.imageUrl!)
                    : const AssetImage('assets/images/placeholder.png')
                        as ImageProvider, // Use um ativo local como imagem de espaço reservado
                radius: 28.0,
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      viewModel.title,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(viewModel.subtitle),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${viewModel.value.toStringAsFixed(2)}\$',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: viewModel.onDecrease,
                  ),
                ],
              ),
              const SizedBox(width: 8.0),
              if (listOptions != null) ...listOptions!,
            ],
          ),
        ),
      ),
    );
  }
}
