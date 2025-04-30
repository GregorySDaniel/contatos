import 'package:contatos/ui/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSwitch extends StatefulWidget {
  const ThemeSwitch({super.key});

  @override
  State<ThemeSwitch> createState() => _ThemeSwitchState();
}

class _ThemeSwitchState extends State<ThemeSwitch> {
  bool light = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: Colors.white,
      onChanged: (bool value) {
        context.read<ThemeProvider>().switchTheme();
        setState(() {
          light = value;
        });
      },
    );
  }
}
