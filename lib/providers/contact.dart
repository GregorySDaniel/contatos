import 'package:contatos/repository/models/contact.dart';
import 'package:contatos/repository/contact.dart';
import 'package:flutter/material.dart';

class ContactProvider extends ChangeNotifier {
  List<Contact> contacts = [];
  TextEditingController searchController = TextEditingController();

  bool filter(Contact contato) {
    final String txt = searchController.text;

    return txt.isEmpty ||
        contato.name.toUpperCase().contains(txt.toUpperCase());
  }

  addContact(Map<String, dynamic> contact) async {
    int id = await ContactDatabase().addContact(contact);
    Map<String, dynamic> newContactMap = {...contact, idColumn: id};
    final Contact newContact = Contact.fromMap(newContactMap);
    contacts.add(newContact);
    notifyListeners();
  }

  removeContact(int id) async {
    await ContactDatabase().removeById(id);
    contacts.removeWhere((contact) => contact.id == id);
    notifyListeners();
  }

  getAllContacts() async {
    contacts = await ContactDatabase().getAllContacs();
    notifyListeners();
  }

  Future<Contact> getContact(int id) async {
    return contacts.where((contact) => contact.id == id).first;
  }

  editContact(int id, Map<String, dynamic> contact) async {
    await ContactDatabase().updateContact(id, contact);
    getAllContacts();
  }
}
