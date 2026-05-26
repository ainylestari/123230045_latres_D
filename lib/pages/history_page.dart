import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'order_detail_page.dart';

class OrderHistoryPage
    extends StatelessWidget {

  final String username;

  const OrderHistoryPage({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {

    final transactionBox =
        Hive.box('transactionBox');

    final transactions =
        transactionBox.values
            .where(
              (item) =>
                  item['username'] ==
                  username,
            )
            .toList()
            .reversed
            .toList();

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5FF),

      appBar: AppBar(
        backgroundColor:
            Colors.blueAccent,

        elevation: 0,

        title: const Text(
          "Order History",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: transactions.isEmpty

          ? const Center(
              child: Text(
                "Belum ada pesanan",
              ),
            )

          : ListView.builder(

              padding:
                  const EdgeInsets.all(
                      16),

              itemCount:
                  transactions.length,

              itemBuilder:
                  (context, index) {

                final order =
                    transactions[index];

                final estimatedDate =
                  order['estimated_delivery'] != null

                      ? DateTime.parse(
                          order['estimated_delivery'],
                        )

                      : DateTime.now().add(
                          const Duration(days: 3),
                );

                final remainingDays =
                    estimatedDate
                        .difference(
                          DateTime.now(),
                        )
                        .inDays;

                return Card(
                  elevation: 4,

                  margin:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),

                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.all(
                            16),

                    leading: Container(
                      width: 55,
                      height: 55,

                      decoration:
                          BoxDecoration(
                        color:
                            getStatusColor(
                          order[
                              'status'],
                        ),

                        borderRadius:
                            BorderRadius
                                .circular(
                                    16),
                      ),

                      child: const Icon(
                        Icons.shopping_bag,
                        color: Colors.white,
                      ),
                    ),

                    title: Text(
                      "Order #${index + 1}",

                      style:
                          const TextStyle(
                        fontWeight:
                            FontWeight
                                .bold,

                        fontSize: 16,
                      ),
                    ),

                    subtitle: Padding(
                      padding:
                          const EdgeInsets.only(
                        top: 8,
                      ),

                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment
                                .start,

                        children: [

                          Text( 
                            order['status'] ?? 'Pending',
                            style:
                                TextStyle(
                              color:
                                  getStatusColor(
                                    order['status'] ?? 'Pending',
                              ),

                              fontWeight:
                                  FontWeight
                                      .bold,
                            ),
                          ),

                          const SizedBox(
                              height: 4),

                          Text(
                            remainingDays <= 0
                                ? "Package has arrived"
                                : "Arrives in $remainingDays day(s)",
                          ),

                          const SizedBox(
                              height: 4),

                          Text(
                            order['date']
                                .toString()
                                .substring(
                                  0,
                                  10,
                                ),
                          ),
                        ],
                      ),
                    ),

                    trailing: Text(
                      "\$${(order['total'] as num).toStringAsFixed(2)}",

                      style:
                          const TextStyle(
                        color:
                            Colors.blueAccent,

                        fontWeight:
                            FontWeight.bold,

                        fontSize: 16,
                      ),
                    ),

                    onTap: () {

                      Navigator.push(
                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                              OrderDetailPage(
                            order: order,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }

  Color getStatusColor(
      String status) {

    switch (status) {

      case 'Pending':
        return Colors.orange;

      case 'Packed':
        return Colors.deepOrange;

      case 'Shipped':
        return Colors.blue;

      case 'Delivered':
        return Colors.green;

      default:
        return Colors.grey;
    }
  }
}