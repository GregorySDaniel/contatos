import 'package:contatos/widgets/contacts_list.dart';
import 'package:contatos/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.push('/add'),
      ),
      body: Center(child: ContactList()),
      appBar: AppBar(title: Text('Contact List')),
    );
  }
}
