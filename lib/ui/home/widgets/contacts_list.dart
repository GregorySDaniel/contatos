import 'dart:io';

import 'package:contatos/providers/contact.dart';
import 'package:contatos/data/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ContactList extends StatelessWidget {
  const ContactList({super.key});

  @override
  Widget build(BuildContext context) {
    List<ContactModel> contacts = context.watch<ContactProvider>().contacts;

    context.read<ContactProvider>().getAllContacts();

    void onPressed(int id) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeleteAlertDialog(id: id);
        },
      );
    }

    void onTap(int id) async {
      context.push('/add?edit=$id');
    }

    return ListView(
      shrinkWrap: true,
      children: [
        ...contacts
            .where(context.read<ContactProvider>().filter)
            .map(
              (ContactModel contact) => ListTile(
                onTap: () => onTap(contact.id),
                leading: CircleAvatar(
                  backgroundImage:
                      contact.img != ''
                          ? Image.file(File(contact.img)).image
                          : Image(image: AssetImage('assets/person.jpg')).image,
                ),
                title: Text(contact.name),
                subtitle: Text(contact.phone),
                trailing: IconButton(
                  onPressed: () => onPressed(contact.id),
                  icon: Icon(Icons.delete_outline),
                ),
              ),
            ),
      ],

      //     .toList(),
    );
  }
}

class DeleteAlertDialog extends StatelessWidget {
  const DeleteAlertDialog({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Are you sure?'),
      actions: [
        TextButton(
          onPressed: () {
            context.read<ContactProvider>().removeContact(id);
            context.pop();
          },
          child: Text('Yes'),
        ),
        TextButton(onPressed: () => context.pop(), child: Text('No')),
      ],
    );
  }
}
