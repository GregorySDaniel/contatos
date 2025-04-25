import 'package:contatos/widgets/theme_switch.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(leading: ThemeSwitch(), title: Text('Change theme')),
        ],
      ),
    );
  }
}
