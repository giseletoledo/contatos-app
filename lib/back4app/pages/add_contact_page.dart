import 'dart:io';

import 'package:flutter/material.dart';

import '../../model/contact.dart';
import '../../repositories/contact_repository.dart';

import 'package:image_picker/image_picker.dart';

import '../services/picker_service.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedImagePath; // Armazena o caminho da imagem selecionada

  final PickerService _pickerService = PickerService();

  Future<void> _getImage() async {
    final XFile? image = await _pickerService.getImage(ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    }
  }

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
            GestureDetector(
              onTap: () {
                _getImage();
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImagePath != null
                    ? FileImage(File(_selectedImagePath!))
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
            ),
            TextFormField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Telefone'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
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

    if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty) {
      final urlAvatar = _selectedImagePath ?? '';

      final newContact = Contacts(
        name: name,
        phone: phone,
        email: email,
        urlavatar: urlAvatar,
      );

      final contact = Contact(results: []);
      contact.results!.add(newContact);

      ContactRepository().createContact(contact);

      // Limpe os campos após adicionar o contato
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      setState(() {
        _selectedImagePath = null; // Limpe o caminho da imagem selecionada
      });
    } else {
      // Trate campos em branco
      // Exiba um Snackbar ou Toast para informar ao usuário
    }
  }
}
