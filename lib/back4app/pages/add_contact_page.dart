import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../model/contact.dart';
import '../../repositories/contact_repository.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _urlAvatarController = TextEditingController();
  final ValueNotifier<String> _urlAvatarNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _showImagePreview();
                },
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _urlAvatarController.text.isNotEmpty
                      ? CachedNetworkImageProvider(_urlAvatarNotifier.value)
                      : null,
                  child: const Icon(
                    Icons.camera,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor preencha o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Telefone'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor preencha um número de telefone';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (!isValidEmail(value)) {
                    return 'Por favor preencha um email válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _urlAvatarController,
                decoration:
                    const InputDecoration(labelText: 'URL da Imagem de Perfil'),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _addContact();
                },
                child: const Text('Adicionar Contato'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showImagePreview() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pré-Visualização da Imagem'),
          content: _urlAvatarController.text.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: _urlAvatarNotifier.value,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : const Text('Nenhuma URL fornecida'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _addContact() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final email = _emailController.text;
      final phone = _phoneController.text;
      final urlAvatar = _urlAvatarController.text;

      final newContact = Contact.criar(
          name: name,
          phone: phone,
          email: email,
          urlavatar: urlAvatar,
          idcontact: const Uuid().v4());

      // Chame o método para criar o contato no repositório
      ContactRepository().createContact(newContact);

      // Limpe os campos após adicionar o contato
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _urlAvatarController.clear();

      setState(() {
        // Limpe a imagem da URL
        _urlAvatarController.clear();
      });
    } else {
      // Campos em branco, mostrar um alerta
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Campos em Branco'),
            content: const Text('Por favor, preencha todos os campos.'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  bool isValidEmail(String email) {
    // Custom email validation logic, you can use a package like email_validator
    return RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email);
  }
}
