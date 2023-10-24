import 'package:contatosapp/repositories/contact_repository.dart';
import 'package:flutter/material.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  ContactRepository contactRepository = ContactRepository();
  var _contactList = [];
  var carregando = false;

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  void getContacts() async {
    setState(() {
      carregando = true;
    });
    _contactList = await contactRepository.getContacts();
    setState(() {
      carregando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de contatos'),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {}),
        body: Container(
          child: Column(
            children: [
              carregando
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: _contactList.length,
                          itemBuilder: (BuildContext bc, int index) {
                            var contact = _contactList[index];
                            return Dismissible(
                              onDismissed:
                                  (DismissDirection dismissDirection) async {
                                await contactRepository
                                    .deleteContact(contact.objectId);
                                getContacts();
                              },
                              key: Key(contact.objectId),
                              child: ListTile(
                                title: Text(contact.name),
                                trailing: Text(contact.email),
                              ),
                            );
                          }),
                    ),
            ],
          ),
        ));
  }
}
