// Corrigido o nome do arquivo
import 'package:controleusuario/app/DataBase/usuario/usuarrio.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  final String baseUrl = 'http://192.168.0.147:3000/usuarios'; // URL correta

  Future<List<Usuario>> fetchUsuarios() async {
    final response = await http.get(Uri.parse(baseUrl)); // Corrigido

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao carregar usuários');
    }
  }
}
