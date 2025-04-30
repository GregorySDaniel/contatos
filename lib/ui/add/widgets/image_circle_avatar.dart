import 'dart:io';

import 'package:contatos/data/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageCircleAvatar extends StatefulWidget {
  final Map<String, dynamic> newContact;

  const ImageCircleAvatar({super.key, required this.newContact});

  @override
  State<ImageCircleAvatar> createState() => _ImageCircleAvatarState();
}

class _ImageCircleAvatarState extends State<ImageCircleAvatar> {
  XFile? pickedFile;

  void onPressedPicker() async {
    final imagePicker = ImagePicker();
    final currentPickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (currentPickedFile != null) {
      setState(() {
        pickedFile = currentPickedFile;
        widget.newContact[imgColumn] = pickedFile!.path;
      });
    }
  }

  Image displayImage() {
    if (widget.newContact[imgColumn] != '') {
      return Image.file(File(widget.newContact[imgColumn]));
    }

    if (pickedFile != null) {
      return Image.file(File(pickedFile!.path));
    } else {
      return Image(image: AssetImage('assets/person.jpg'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Stack(
      alignment: AlignmentDirectional.bottomEnd,
      children: [
        CircleAvatar(radius: 112.0, backgroundImage: displayImage().image),
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
