import 'package:contatos/widgets/custom_circle_avatar.dart';
import 'package:contatos/widgets/form.dart';
import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key, this.contactId});

  final String? contactId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          spacing: 24,
          children: [
            CustomForm(contactId: contactId),
            SizedBox(height: 88),
            Visibility(
              visible: contactId == null ? false : true,
              child: CustomCircleAvatar(contactId: contactId),
            ),
          ],
        ),
      ),
    );
  }
}
