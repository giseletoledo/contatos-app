import 'package:flutter/material.dart';

import '../../model/contact.dart';
import '../../repositories/contact_repository.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _urlAvatarController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Contato'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
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
    );
  }

  void _addContact() {
    final name = _nameController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;
    final urlAvatar = _urlAvatarController.text;

    if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
      final newContact = Contacts(
        name: name,
        phone: phone,
        email: email,
        urlavatar: urlAvatar,
      );

      final contact = Contact(results: []);
      contact.results!.add(newContact);

      // Chame o método para criar o contato no repositório
      ContactRepository().createContact(contact);

      // Limpe os campos após adicionar o contato
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _urlAvatarController.clear();
    } else {
      // Trate campos em branco
      // Exiba um Snackbar ou Toast para informar ao usuário
    }
  }
}
