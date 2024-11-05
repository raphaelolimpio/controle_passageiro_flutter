import 'package:flutter/material.dart';

import '../../../DataBase/usuario/usuarrio.dart';

class CustomCardViewMode {
  final String title;
  final String subtitle;
  final String? imageUrl; // URL da imagem
  final Function()? onTap; // Ação ao tocar no cartão
  final double value; // Valor que será exibido no centro
  final Function()? onDecrease; // Ação do botão "-"
  final Function()? onMoreOptions; // Ação do botão "..."

  CustomCardViewMode({
    required this.title,
    required this.subtitle,
    this.imageUrl,
    required this.value,
    this.onTap,
    this.onDecrease,
    this.onMoreOptions,
  });

  // Método de fábrica para criar uma instância a partir de um usuário
  factory CustomCardViewMode.fromUsuario(Usuario usuario) {
    return CustomCardViewMode(
      title: usuario.nome,
      subtitle: usuario.escola,
      imageUrl: usuario.imagem,
      value: usuario.deposito,
    );
  }
}
