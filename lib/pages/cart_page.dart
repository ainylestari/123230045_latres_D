import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'checkout_page.dart';

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
        .where(
          (entry) =>
              entry.value['username'] ==
              widget.username,
        )
        .toList();
  }

  double getTotalPrice() {

    double total = 0;

    for (var entry in userCart) {

      final item = entry.value;

      total +=
          item['price'] * item['qty'];
    }

    return total;
  }

  void deleteItem(int hiveIndex) async {
    await box.deleteAt(hiveIndex);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5FF),

      appBar: AppBar(
        backgroundColor: Colors.blueAccent,

        title: const Text(
          'My Cart',

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              padding:
                  const EdgeInsets.all(16),

              itemCount: userCart.length,

              itemBuilder: (context, index) {

                final entry =
                    userCart[index];

                final hiveIndex =
                    entry.key;

                final item =
                    entry.value;

                return Card(
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            18),
                  ),

                  color: Colors.white,

                  child: ListTile(
                    leading: Image.network(
                      item['thumbnail'],
                      width: 60,
                    ),

                    title:
                        Text(item['title']),

                    subtitle: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,

                      children: [

                        Text(
                          'Qty: ${item['qty']} | \$${item['price']}',
                        ),

                        Text(
                          "Total = \$${item['price'] * item['qty']}",
                        ),
                      ],
                    ),

                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),

                      onPressed: () {
                        deleteItem(hiveIndex);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
  padding: const EdgeInsets.all(16),

  decoration: const BoxDecoration(
    color: Colors.white,

    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    ),
  ),

  child: Column(
    mainAxisSize: MainAxisSize.min,

    children: [

      Row(
        mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

        children: [

          const Text(
            "Total",

            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(
            "\$${getTotalPrice().toStringAsFixed(2)}",

            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
        ],
      ),

      const SizedBox(height: 15),

      SizedBox(
        width: double.infinity,
        height: 55,

        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(
            backgroundColor:
                Colors.blueAccent,

            shape:
                RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(
                      16),
            ),
          ),

          onPressed: () {

            Navigator.push(
              context,

              MaterialPageRoute(
                builder: (_) =>
                    CheckoutPage(
                  username:
                      widget.username,

                  cartItems:
                      userCart,

                  totalPrice:
                      getTotalPrice(),
                ),
              ),
            );
          },

          child: const Text(
            "Checkout",

            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight:
                  FontWeight.bold,
            ),
          ),
        ),
      ),
    ],
  ),
),
        ],
      ),
    );
  }
}