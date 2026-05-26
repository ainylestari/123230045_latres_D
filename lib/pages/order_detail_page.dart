import 'package:flutter/material.dart';

class OrderDetailPage
    extends StatelessWidget {

  final dynamic order;

  const OrderDetailPage({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {

    final orderDate =
        DateTime.parse(order['date']);

    final days =
        DateTime.now()
            .difference(orderDate)
            .inDays;

    int currentStep = 0;

    String currentStatus =
        "Pending";

    if (days >= 1) {

      currentStep = 1;

      currentStatus = "Packed";
    }

    if (days >= 2) {

      currentStep = 2;

      currentStatus = "Shipped";
    }

    if (days >= 3) {

      currentStep = 3;

      currentStatus = "Delivered";
    }

    final trackingSteps = [

      "Order Confirmed",

      "Packed",

      "Shipped",

      "Delivered",
    ];

    return Scaffold(
      backgroundColor:
          const Color(0xFFF8F5FF),

      appBar: AppBar(
        backgroundColor:
            Colors.blueAccent,

        elevation: 0,

        title: const Text(
          "Order Detail",

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

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                      20),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        24),
              ),

              child: Column(
                children: [

                  Icon(
                    currentStep == 3
                        ? Icons.check_circle
                        : Icons.local_shipping,

                    color:
                        currentStep == 3
                            ? Colors.green
                            : Colors.blueAccent,

                    size: 60,
                  ),

                  const SizedBox(
                      height: 12),

                  Text(
                    currentStatus,

                    style:
                        const TextStyle(
                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 8),

                  Text(
                    currentStep == 3
                        ? "Your package has arrived"
                        : "Your package is on delivery process",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Tracking Order",

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              padding:
                  const EdgeInsets.all(
                      20),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        24),
              ),

              child: Column(
                children:
                    List.generate(

                  trackingSteps.length,

                  (index) {

                    final isActive =
                        index <=
                            currentStep;

                    return Row(
                      crossAxisAlignment:
                          CrossAxisAlignment
                              .start,

                      children: [

                        Column(
                          children: [

                            Container(
                              width: 20,
                              height: 20,

                              decoration:
                                  BoxDecoration(
                                color: isActive
                                    ? Colors
                                        .blueAccent
                                    : Colors
                                        .grey
                                        .shade300,

                                shape: BoxShape
                                    .circle,
                              ),
                            ),

                            if (index !=
                                trackingSteps
                                        .length -
                                    1)

                              Container(
                                width: 3,
                                height: 50,

                                color: isActive
                                    ? Colors
                                        .blueAccent
                                    : Colors
                                        .grey
                                        .shade300,
                              ),
                          ],
                        ),

                        const SizedBox(
                            width: 14),

                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets
                                    .only(
                              top: 1,
                            ),

                            child: Text(
                              trackingSteps[
                                  index],

                              style:
                                  TextStyle(
                                fontSize:
                                    16,

                                fontWeight:
                                    isActive
                                        ? FontWeight
                                            .bold
                                        : FontWeight
                                            .normal,

                                color: isActive
                                    ? Colors
                                        .black
                                    : Colors
                                        .grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Order Information",

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                      20),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        24),
              ),

              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                children: [

                  buildInfoRow(
                    "Payment",
                    order[
                        'payment_method'],
                  ),

                  buildInfoRow(
                    "Address",
                    order['address'],
                  ),

                  buildInfoRow(
                    "Order Date",
                    order['date']
                        .toString()
                        .substring(
                          0,
                          10,
                        ),
                  ),

                  buildInfoRow(
                    "Subtotal",
                    "\$${(order['subtotal'] as num).toStringAsFixed(2)}",
                  ),

                  buildInfoRow(
                    "Shipping Fee",
                    "\$${(order['shipping_fee'] as num).toStringAsFixed(2)}",
                  ),

                  buildInfoRow(
                    "Admin Fee",
                    "\$${(order['admin_fee'] as num).toStringAsFixed(2)}",
                  ),

                  const Divider(
                    height: 28,
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
                              FontWeight.bold,
                        ),
                      ),

                      Text(
                        "\$${(order['total'] as num).toStringAsFixed(2)}",

                        style:
                            const TextStyle(
                          fontSize: 20,

                          color:
                              Colors.blueAccent,

                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              "Items",

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            Column(
              children: List.generate(

                order['items'].length,

                (index) {

                  final item =
                      order['items']
                          [index];

                  return Container(
                    margin:
                        const EdgeInsets.only(
                      bottom: 14,
                    ),

                    padding:
                        const EdgeInsets.all(
                            16),

                    decoration:
                        BoxDecoration(
                      color: Colors.white,

                      borderRadius:
                          BorderRadius.circular(
                              20),
                    ),

                    child: Row(
                      children: [

                        ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                                  16),

                          child: Image.network(
                            item['thumbnail'],

                            width: 70,
                            height: 70,

                            fit: BoxFit.cover,
                          ),
                        ),

                        const SizedBox(
                            width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                            children: [

                              Text(
                                item['title'],

                                maxLines: 2,

                                overflow:
                                    TextOverflow
                                        .ellipsis,

                                style:
                                    const TextStyle(
                                  fontWeight:
                                      FontWeight
                                          .bold,

                                  fontSize:
                                      16,
                                ),
                              ),

                              const SizedBox(
                                  height: 8),

                              Text(
                                "\$${item['price']}",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(
    String title,
    String value,
  ) {

    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 14,
      ),

      child: Row(
        crossAxisAlignment:
            CrossAxisAlignment.start,

        mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

        children: [

          Text(
            title,

            style: TextStyle(
              color:
                  Colors.grey.shade700,
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Text(
              value,

              textAlign:
                  TextAlign.right,

              style:
                  const TextStyle(
                fontWeight:
                    FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}