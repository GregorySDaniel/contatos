import 'package:contatos/providers/contact.dart';
import 'package:contatos/repository/models/contact.dart';
import 'package:contatos/widgets/image_circle_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_regex/flutter_regex.dart';
import 'package:go_router/go_router.dart';
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

  @override
  Widget build(BuildContext context) {
    // final ThemeData theme = Theme.of(context);

    return Form(
      key: _formKey,
      child: Column(
        spacing: 12.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          ImageCircleAvatar(newContact: newContact),
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
            child: Text(isEditing ? 'Confirm' : 'Add'),
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

  bool validateRegex(String column, String value) {
    switch (column) {
      case 'nameColumn':
        return true;
      case 'emailColumn':
        return value.isEmail() ? true : false;
      case 'phoneColumn':
        return value.isPhone() ? true : false;
      default:
        return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    myController.value = TextEditingValue(text: value ?? '');
    return TextFormField(
      controller: myController,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        if (!validateRegex(column, value)) {
          return 'Please enter a valid value';
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
