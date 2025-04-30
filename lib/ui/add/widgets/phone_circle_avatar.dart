import 'package:contatos/providers/contact.dart';
import 'package:contatos/data/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

String? phone;

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({
    super.key,
    required this.contactId,
    required this.context,
  });
  final String? contactId;
  final BuildContext context;

  void onPressed() async {
    String phone = await getContactPhone();
    launchUrlString("tel://$phone");
  }

  Future<String> getContactPhone() async {
    ContactModel atual = await context.read<ContactProvider>().getContact(
      int.parse(contactId!),
    );

    return atual.phone;
  }

  @override
  Widget build(BuildContext context) {
    context.read<ContactProvider>();
    return CircleAvatar(
      radius: 28,
      child: IconButton(
        onPressed: () => onPressed(),
        icon: Icon(Icons.phone, size: 32),
      ),
    );
  }
}
