import 'dart:io';

import 'package:contatos/providers/contact.dart';
import 'package:contatos/repository/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

Map<String, dynamic> newContact = {imgColumn: ''};

class CustomForm extends StatefulWidget {
  const CustomForm({super.key, this.contactId});
  final String? contactId;

  @override
  State<CustomForm> createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();
  bool isEditing = false;
  XFile? pickedFile;

  @override
  void initState() {
    super.initState();
    if (widget.contactId != null) {
      isEditing = true;
      fetchExistingData(int.parse(widget.contactId!), context);
    } else {
      newContact.clear();
      newContact[imgColumn] = '';
    }
  }

  void onPressed() {
    if (_formKey.currentState!.validate()) {
      isEditing
          ? context.read<ContactProvider>().editContact(
            int.parse(widget.contactId!),
            newContact,
          )
          : context.read<ContactProvider>().addContact(newContact);
      context.pop();
    }
  }

  void fetchExistingData(int id, BuildContext context) async {
    Contact existingContact = await context.read<ContactProvider>().getContact(
      id,
    );
    setState(() {
      newContact[nameColumn] = existingContact.name;
      newContact[imgColumn] = existingContact.img;
      newContact[emailColumn] = existingContact.email;
      newContact[phoneColumn] = existingContact.phone;
    });
  }

  void onPressedPicker() async {
    final imagePicker = ImagePicker();
    final currentPickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (currentPickedFile != null) {
      setState(() {
        pickedFile = currentPickedFile;
        newContact[imgColumn] = pickedFile!.path;
      });
    }
  }

  Widget displayImage() {
    if (newContact[imgColumn] != '') {
      return ClipOval(
        child: Image.file(
          File(newContact[imgColumn]),
          fit: BoxFit.fill,
          width: double.infinity,
        ),
      );
    }
    if (pickedFile != null) {
      return ClipOval(
        child: Image.file(
          File(pickedFile!.path),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    } else {
      return Icon(Icons.person, size: 128);
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        spacing: 12.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(radius: 112.0, child: displayImage()),
              IconButton(
                onPressed: () => onPressedPicker(),
                icon: Icon(Icons.add, size: 48),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(
                    theme.scaffoldBackgroundColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          CustomTextFormField(
            name: 'Name',
            column: nameColumn,
            value: newContact[nameColumn],
          ),
          CustomTextFormField(
            name: 'Phone',
            column: phoneColumn,
            value: newContact[phoneColumn],
          ),
          CustomTextFormField(
            name: 'Email',
            column: emailColumn,
            value: newContact[emailColumn],
          ),
          ElevatedButton(
            onPressed: () => onPressed(),
            child: Text(isEditing ? 'Edit' : 'Add'),
          ),
        ],
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    required this.name,
    required this.column,
    this.value,
  });
  final String? value;
  final String name;
  final String column;
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    myController.value = TextEditingValue(text: value ?? '');
    return TextFormField(
      controller: myController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        newContact[column] = value;
        return null;
      },
      decoration: InputDecoration(
        label: Text(name),
        border: OutlineInputBorder(),
      ),
    );
  }
}
