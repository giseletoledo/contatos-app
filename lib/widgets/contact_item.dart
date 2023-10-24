import 'package:cached_network_image/cached_network_image.dart';
import 'package:contatosapp/model/contact.dart';
import 'package:contatosapp/repositories/contact_repository.dart';
import 'package:flutter/material.dart';

class ContactItem extends StatelessWidget {
  final Contact contact;

  const ContactItem({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(contact.urlavatar ?? 'sem imagem'),
      ),
      title: Text(contact.name ?? "sem nome"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Telefone: ${contact.phone}"),
          Text("Email: ${contact.email}"),
          Text("Data de criação: ${contact.createdAt}"),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              //showEditDialog(context, contact);
            },
          ),
        ],
      ),
    );
  }

  void showEditDialog(BuildContext context, Contact contact) {
    TextEditingController nameController =
        TextEditingController(text: contact.name);
    TextEditingController phoneController =
        TextEditingController(text: contact.phone);
    TextEditingController emailController =
        TextEditingController(text: contact.email);
    TextEditingController urlAvatarController =
        TextEditingController(text: contact.urlavatar);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Edit Contact"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      _showImagePreview(urlAvatarController.text, context);
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: urlAvatarController.text.isNotEmpty
                          ? CachedNetworkImageProvider(urlAvatarController.text)
                          : null,
                      child: urlAvatarController.text.isNotEmpty
                          ? null
                          : const Icon(
                              Icons.camera,
                              size: 40,
                              color: Colors.white,
                            ),
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  TextFormField(
                    controller: urlAvatarController,
                    decoration: const InputDecoration(
                        labelText: 'URL da Imagem de Perfil'),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text("Save"),
                  onPressed: () {
                    // Update the contact with the edited data
                    contact.name = nameController.text;
                    contact.phone = phoneController.text;
                    contact.email = emailController.text;
                    contact.urlavatar = urlAvatarController.text;
                    ContactRepository().updateContact(contact);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showImagePreview(String url, BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pré-Visualização da Imagem'),
          content: url.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: url,
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
}
