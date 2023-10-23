import 'package:contatosapp/back4app/pages/add_contact_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    const MaterialApp(home: AddContactPage()),
  );
}
