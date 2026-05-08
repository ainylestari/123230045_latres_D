import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class DetailPage extends StatefulWidget {
  final Map product;
  final String username;

  const DetailPage({
    super.key,
    required this.product,
    required this.username,
  });

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int qty = 1;

  void addToCart() async {
    final box = Hive.box('cartBox');

    await box.add({
      'username': widget.username,
      'title': widget.product['title'],
      'price': widget.product['price'],
      'thumbnail': widget.product['thumbnail'],
      'qty': qty,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Added to cart'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int stock = widget.product['stock'];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          'Detail Produk',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.network(
                  widget.product['thumbnail'],
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),

              const SizedBox(height: 20),

              Text(
                widget.product['title'],
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Brand: ${widget.product['brand'] ?? '-'} | Category: ${widget.product['category']}',
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 18),

              Text(
                '\$${widget.product['price']}',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),

              const SizedBox(height: 14),

              Wrap(
                spacing: 16,
                runSpacing: 16,
                children: [
                  const Icon(Icons.star, color: Colors.orange),
                  Text(
                    '${widget.product['rating']}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const Text('|', style: TextStyle(fontSize: 18)),
                  Text(
                    'Stok: $stock',
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(height: 18),
              const Divider(),
              const SizedBox(height: 18),

              const Text(
                'Deskripsi:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                  widget.product['description'],
                  style: const TextStyle(
                    fontSize: 17,
                    height: 1.5,
                  ),
                ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            if (qty > 1) {
                              setState(() => qty--);
                            }
                          },
                          icon: const Icon(Icons.remove_circle_outline),
                        ),
                        Text(
                          qty.toString(),
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (qty < stock) {
                              setState(() => qty++);
                            }
                          },
                          icon: const Icon(Icons.add_circle_outline),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: SizedBox(
                      height: 60,
                      child: ElevatedButton(
                        onPressed: addToCart,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      child: const Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}