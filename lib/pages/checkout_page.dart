import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class CheckoutPage extends StatefulWidget {
  final String username;
  final List cartItems;
  final double totalPrice;

  const CheckoutPage({
    super.key,
    required this.username,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  State<CheckoutPage> createState() =>
      _CheckoutPageState();
}

class _CheckoutPageState
    extends State<CheckoutPage> {

  final addressController =
      TextEditingController();

  final transactionBox =
      Hive.box('transactionBox');

  final cartBox =
      Hive.box('cartBox');

  String paymentMethod =
      "Cash On Delivery";

  double shippingFee = 5;

  double adminFee = 2;

  double getFinalTotal() {

    return widget.totalPrice +
        shippingFee +
        adminFee;
  }

  void checkout() {

    if (addressController.text
        .isEmpty) {

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Alamat wajib diisi",
          ),
        ),
      );

      return;
    }

    transactionBox.add({

      'username':
          widget.username,

      'items': widget.cartItems.map((item) {

        if (item is Map) {
          return Map<String, dynamic>.from(item);
        }

        if (item is MapEntry) {
          return Map<String, dynamic>.from(item.value);
        }

        return <String, dynamic>{};

      }).toList(),

      'subtotal':
          widget.totalPrice,

      'shipping_fee':
          shippingFee,

      'admin_fee':
          adminFee,

      'total':
          getFinalTotal(),

      'address':
          addressController.text,

      'payment_method':
          paymentMethod,

      'status': 'Pending',

      'estimated_delivery':
          DateTime.now()
              .add(const Duration(days: 3))
              .toString(),

      'tracking_steps': [
        'Order Confirmed',
        'Packed',
        'Shipped',
      ],

      'current_step': 0,

      'date':
          DateTime.now().toString(),
    });

    final keys =
        cartBox.keys.toList();

    for (var key in keys) {

      final item =
          cartBox.get(key);

      if (item['username'] ==
          widget.username) {

        cartBox.delete(key);
      }
    }

    ScaffoldMessenger.of(context)
        .showSnackBar(
      const SnackBar(
        content: Text(
          "Pembayaran berhasil",
        ),
      ),
    );

    Navigator.pop(context);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5FF),

      appBar: AppBar(
        backgroundColor:
            Colors.blueAccent,

        elevation: 0,

        title: const Text(
          "Checkout",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            const Text(
              "Alamat Pengiriman",

              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              controller:
                  addressController,

              maxLines: 3,

              decoration:
                  InputDecoration(
                hintText:
                    "Masukkan alamat lengkap",

                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          16),

                  borderSide:
                      BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Metode Pembayaran",

              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            DropdownButtonFormField(
              value: paymentMethod,

              decoration:
                  InputDecoration(
                filled: true,

                fillColor:
                    Colors.white,

                border:
                    OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(
                          16),

                  borderSide:
                      BorderSide.none,
                ),
              ),

              items: const [

                DropdownMenuItem(
                  value:
                      "Cash On Delivery",

                  child: Text(
                    "Cash On Delivery",
                  ),
                ),

                DropdownMenuItem(
                  value:
                      "E-Wallet",

                  child:
                      Text("E-Wallet"),
                ),

                DropdownMenuItem(
                  value:
                      "Transfer Bank",

                  child: Text(
                    "Transfer Bank",
                  ),
                ),
              ],

              onChanged: (value) {

                setState(() {

                  paymentMethod =
                      value!;
                });
              },
            ),

            const SizedBox(height: 30),

            const Text(
              "Payment Details",

              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Card(
              elevation: 3,

              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                        20),
              ),

              child: Padding(
                padding:
                    const EdgeInsets.all(
                        18),

                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(
                            "Subtotal"),

                        Text(
                          "\$${widget.totalPrice.toStringAsFixed(2)}",
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 12),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(
                            "Shipping Fee"),

                        Text(
                          "\$${shippingFee.toStringAsFixed(2)}",
                        ),
                      ],
                    ),

                    const SizedBox(
                        height: 12),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(
                            "Admin Fee"),

                        Text(
                          "\$${adminFee.toStringAsFixed(2)}",
                        ),
                      ],
                    ),

                    const Divider(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment
                              .spaceBetween,

                      children: [

                        const Text(
                          "Total Payment",

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight:
                                FontWeight
                                    .bold,
                          ),
                        ),

                        Text(
                          "\$${getFinalTotal().toStringAsFixed(2)}",

                          style:
                              const TextStyle(
                            fontSize: 22,
                            fontWeight:
                                FontWeight
                                    .bold,

                            color:
                                Colors.blueAccent,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,

              height: 58,

              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.blueAccent,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            18),
                  ),
                ),

                onPressed: checkout,

                child: const Text(
                  "Bayar Sekarang",

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
    );
  }
}
