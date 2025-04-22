import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomCircleAvatar extends StatelessWidget {
  const CustomCircleAvatar({super.key, required this.contactId});
  final String contactId;

  @override
  Widget build(BuildContext context) {
    context.read<ContactProvider>();
    return CircleAvatar(
      radius: 36,
      child: IconButton(
        onPressed: () {
          launchUrlString("tel://214324234");
        },
        icon: Icon(Icons.phone, size: 48),
      ),
    );
  }
}
