class Usuario {
  final String nome;
  final String escola;
  final String endereco; // Adicionando o campo endereco
  final double deposito;
  final String? imagem; // Permitir que a imagem seja nula

  Usuario({
    required this.nome,
    required this.escola,
    required this.endereco, // Adicionando o parametro endereco
    required this.deposito,
    this.imagem,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      nome: json['nome'] ?? 'Nome não disponível',
      escola: json['escola'] ?? 'Escola não disponível',
      endereco:
          json['endereco'] ?? 'Endereço não disponível', // Tratando o endereco
      deposito: double.tryParse(json['deposito'] ?? '0.0') ??
          0.0, // Convertendo string para double
      imagem: json['imagem'], // A imagem pode ser nula
    );
  }
}
