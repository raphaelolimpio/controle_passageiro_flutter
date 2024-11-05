import 'package:controleusuario/app/DesignSystem/Componets/Buttons/action_button.dart';
import 'package:controleusuario/app/DesignSystem/Componets/Buttons/action_button_view_mode.dart';
import 'package:controleusuario/app/DesignSystem/Componets/imagens/avatar.dart';
import 'package:controleusuario/app/DesignSystem/Componets/imagens/avatar_view_mode.dart';
import 'package:controleusuario/app/DesignSystem/Componets/input/text.dart';
import 'package:controleusuario/app/DesignSystem/shared/colors.dart';
import 'package:controleusuario/app/views/cadastro/cadastro_view.dart';
import 'package:controleusuario/app/views/home/home_view_mode.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CadastroViewMode extends StatefulWidget {
  const CadastroViewMode({super.key});

  @override
  State<CadastroViewMode> createState() => _CadastroViewModeState();
}

class _CadastroViewModeState extends State<CadastroViewMode> {
  late CadastroView _viewModel;
  late ActionButtonViewMode _cadastroButtonViewModel;
  // ignore: non_constant_identifier_names
  late AvatarViewModel _AvatarViewModel;
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _viewModel = CadastroView();

    // Imagem do perfil
    _AvatarViewModel = AvatarViewModel(
      model: AvatarModel.large,
      addImageIcon: const Icon(Icons.add_a_photo),
      allowEdit: true,
      removeImageIcon: const Icon(Icons.remove_circle),
      onImageChanged: (image) {
        setState(() {
          _selectedImage = File(image!.path); // Armazena a imagem selecionada
        });
      },
      getImageSource: () async {
        return ImageSource.gallery;
      },
      getPreferredCameraDevice: () async {
        return CameraDevices.rear;
      },
      onImageRemoved: () {
        setState(() {
          _selectedImage = null;
        });
      },
    );

    _cadastroButtonViewModel = ActionButtonViewMode(
      size: ActionButtonSize.large,
      style: ActionButtonStyle.primary,
      text: 'Cadastrar',
      onPressed: _handleCadastro,
      icon: null,
    );
  }

  Future<void> _handleCadastro() async {
    final url = Uri.parse('http://192.168.0.147:3000/usuarios');
    final request = http.MultipartRequest('POST', url);

    // Collect input values
    String nome = _viewModel.nomeViewModel.controller!.text;
    String escola = _viewModel.escolaViewModel.controller!.text;
    String endereco = _viewModel.enderecoViewModel.controller!.text;
    String deposito = _viewModel.depositoViewModel.controller!.text;

    if (nome.isEmpty ||
        escola.isEmpty ||
        endereco.isEmpty ||
        deposito.isEmpty) {
      _showErrorMessage('Por favor, preencha todos os campos.');
      return;
    }

    double? depositoValue = _parseDecimal(deposito);
    if (depositoValue == null || depositoValue <= 0) {
      _showErrorMessage('O valor do depósito deve ser um número positivo.');
      return;
    }

    request.fields['nome'] = nome;
    request.fields['escola'] = escola;
    request.fields['endereco'] = endereco;
    request.fields['deposito'] = depositoValue.toStringAsFixed(2);

    if (_selectedImage != null) {
      request.files.add(
          await http.MultipartFile.fromPath('imagem', _selectedImage!.path));
    }

    try {
      final response = await request.send();
      if (response.statusCode != 201) {
        String responseBody = await response.stream.bytesToString();
        _showErrorMessage('Erro ao cadastrar usuário: ${response.statusCode}');
      } else {
        String responseBody = await response.stream.bytesToString();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeViewMode()));
      }
    } catch (e) {
      _showErrorMessage('Erro de conexão: $e');
    }
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  double? _parseDecimal(String value) {
    // Remove o símbolo da moeda e espaços
    String sanitizedValue =
        value.replaceAll('R\$', '').replaceAll(' ', '').replaceAll(',', '.');
    return double.tryParse(sanitizedValue);
  }

  @override
  void dispose() {
    _viewModel.nomeViewModel.controller?.dispose();
    _viewModel.escolaViewModel.controller?.dispose();
    _viewModel.enderecoViewModel.controller?.dispose();
    _viewModel.depositoViewModel.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: PagerTwoColor,
          title: const Text("Cadastro"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //imagem
              Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Avatar(viewModel: _AvatarViewModel)),

              //inputTExt
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Campo nome
                    InputText.instantiate(viewModel: _viewModel.nomeViewModel),
                    const SizedBox(height: 25.0),

                    // Campo nome da escola
                    InputText.instantiate(
                        viewModel: _viewModel.escolaViewModel),
                    const SizedBox(height: 25.0),

                    // Campo endereço
                    InputText.instantiate(
                        viewModel: _viewModel.enderecoViewModel),
                    const SizedBox(height: 25.0),

                    // Campo depósito
                    InputText.instantiate(
                        viewModel: _viewModel.depositoViewModel),
                  ],
                ),
              ),

              //buton criar conta
              Padding(
                padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10.0),
                    ActionButton.instantiate(
                        viewModel: _cadastroButtonViewModel), //
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
