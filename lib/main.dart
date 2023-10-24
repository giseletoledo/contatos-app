import 'package:contatosapp/pages/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(
    const MaterialApp(debugShowCheckedModeBanner: false, home: ContactList()),
  );
}
