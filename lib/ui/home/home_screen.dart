import 'package:contatos/providers/contact.dart';
import 'package:contatos/ui/home/widgets/contacts_list.dart';
import 'package:contatos/ui/home/widgets/my_drawer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.push('/add'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: context.read<ContactProvider>().searchController,
              decoration: InputDecoration(label: Icon(Icons.search)),
            ),
          ),
          ContactList(),
        ],
      ),
      appBar: AppBar(title: Text('Contact List')),
    );
  }
}
