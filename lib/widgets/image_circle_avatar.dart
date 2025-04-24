import 'dart:io';

import 'package:contatos/repository/models/contact.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCircleAvatar extends StatefulWidget {
  Map<String, dynamic> newContact;

  ImageCircleAvatar({super.key, required this.newContact});

  @override
  State<ImageCircleAvatar> createState() => _ImageCircleAvatarState(newContact);
}

class _ImageCircleAvatarState extends State<ImageCircleAvatar> {
  Map<String, dynamic> newContact;

  _ImageCircleAvatarState(this.newContact);
  XFile? pickedFile;

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

    return Stack(
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
    );
  }
}
