import '../back4app/back4app_custom_dio.dart';
import '../model/contact.dart';

class ContactRepository {
  final _customDio = Back4AppCustomDio();

  ContactRepository();

  Future<List<Contact>> getContacts() async {
    final url = '/contact';
    final result = await _customDio.dio.get(url);
    final data = result.data['results'] as List;
    final contacts = data.map((item) => Contact.fromJson(item)).toList();
    return contacts;
  }

  Future<void> createContact(Contact contact) async {
    try {
      await _customDio.dio.post(
        '/contact',
        data: contact.toJson(),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> updateContact(Contact contact) async {
    try {
      await _customDio.dio.put(
        '/classes/Pessoa/${contact.results?.first.objectId}', // Substitua 'Pessoa' pelo nome da sua classe no Back4App.
        data: contact.toJson(),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<void> deleteContact(String objectId) async {
    try {
      await _customDio.dio.delete(
        '/contact/$objectId', // Substitua 'Pessoa' pelo nome da sua classe no Back4App.
      );
    } catch (e) {
      throw e;
    }
  }
}
