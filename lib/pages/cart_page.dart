import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CartPage extends StatefulWidget {
  final String username;

  const CartPage({super.key, required this.username});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final box = Hive.box('cartBox');

  List get userCart {
    return box.values
        .toList()
        .asMap()
        .entries
        .where((entry) => entry.value['username'] == widget.username)
        .toList();
  }
  void deleteItem(int index) async {
    await box.deleteAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
      final items = box.values
        .where((e) => e['username'] == widget.username)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F5FF),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('My Cart',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            color: Colors.white,
            child: ListTile(
              leading: Image.network(item['thumbnail'], width: 60),
              title: Text(item['title']),
              subtitle: Text('Qty: ${item['qty']} | \$${item['price']}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  box.deleteAt(index);
                  setState(() {});
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
