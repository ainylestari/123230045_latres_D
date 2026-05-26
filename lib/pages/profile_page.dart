import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_page.dart';
import 'history_page.dart';

class ProfilePage extends StatelessWidget {

  final String username;

  const ProfilePage({
    super.key,
    required this.username,
  });

  Future<void> logout(
      BuildContext context) async {

    SharedPreferences prefs =
        await SharedPreferences
            .getInstance();

    await prefs.clear();

    Navigator.pushAndRemoveUntil(
      context,

      MaterialPageRoute(
        builder: (_) =>
            const LoginPage(),
      ),

      (route) => false,
    );
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
          "Profile",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
                FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [

            Container(
              width: double.infinity,

              padding:
                  const EdgeInsets.all(
                      24),

              decoration:
                  BoxDecoration(
                color: Colors.white,

                borderRadius:
                    BorderRadius.circular(
                        28),

                boxShadow: [

                  BoxShadow(
                    color: Colors.black
                        .withOpacity(0.05),

                    blurRadius: 10,

                    offset:
                        const Offset(0, 4),
                  ),
                ],
              ),

              child: Column(
                children: [

                  CircleAvatar(
                    radius: 45,

                    backgroundColor:
                        Colors.blueAccent
                            .withOpacity(
                                0.15),

                    child: const Icon(
                      Icons.person,

                      size: 50,

                      color:
                          Colors.blueAccent,
                    ),
                  ),

                  const SizedBox(
                      height: 18),

                  Text(
                    username,

                    style:
                        const TextStyle(
                      fontSize: 24,

                      fontWeight:
                          FontWeight.bold,
                    ),
                  ),

                  const SizedBox(
                      height: 6),

                  Container(
                    padding:
                        const EdgeInsets
                            .symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),

                    decoration:
                        BoxDecoration(
                      color: Colors
                          .blueAccent
                          .withOpacity(
                              0.1),

                      borderRadius:
                          BorderRadius
                              .circular(
                                  20),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            buildMenuTile(
              icon: Icons.receipt_long,
              title: "Order History",

              onTap: () {

                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder: (_) =>
                        OrderHistoryPage(
                      username:
                          username,
                    ),
                  ),
                );
              },
            ),

            buildMenuTile(
              icon: Icons.location_on,
              title: "Shipping Address",

              onTap: () {},
            ),

            buildMenuTile(
              icon: Icons.payment,
              title: "Payment Method",

              onTap: () {},
            ),

            buildMenuTile(
              icon: Icons.notifications,
              title: "Notifications",

              onTap: () {},
            ),

            buildMenuTile(
              icon: Icons.settings,
              title: "Settings",

              onTap: () {},
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,

              height: 58,

              child: ElevatedButton(
                onPressed: () =>
                    logout(context),

                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.red,

                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(
                            20),
                  ),
                ),

                child: const Text(
                  "Logout",

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

  Widget buildMenuTile({

    required IconData icon,

    required String title,

    required VoidCallback onTap,

  }) {

    return Container(
      margin:
          const EdgeInsets.only(
        bottom: 14,
      ),

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius:
            BorderRadius.circular(
                22),

        boxShadow: [

          BoxShadow(
            color:
                Colors.black.withOpacity(
                    0.04),

            blurRadius: 8,

            offset: const Offset(0, 3),
          ),
        ],
      ),

      child: ListTile(
        leading: Container(
          padding:
              const EdgeInsets.all(10),

          decoration:
              BoxDecoration(
            color:
                Colors.blueAccent
                    .withOpacity(0.1),

            borderRadius:
                BorderRadius.circular(
                    14),
          ),

          child: Icon(
            icon,
            color: Colors.blueAccent,
          ),
        ),

        title: Text(
          title,

          style: const TextStyle(
            fontWeight:
                FontWeight.w600,
          ),
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 18,
        ),

        onTap: onTap,
      ),
    );
  }
}