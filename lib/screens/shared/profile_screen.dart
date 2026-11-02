import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/screens/seller/my_listings_screen.dart';
import 'package:trash2treasure/screens/shared/notifications_screen.dart';
import 'package:trash2treasure/screens/shared/saved_items_screen.dart';

import 'package:trash2treasure/widgets/stat_card.dart';
import 'package:trash2treasure/widgets/menu_card.dart';

import 'package:trash2treasure/screens/shared/settings_screen.dart';
import 'package:trash2treasure/screens/buyer/my_requests_screen.dart';
import 'package:trash2treasure/screens/shared/messages_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3FAF4),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Profile header
              Container(
                margin: const EdgeInsets.only(left: 12, right: 12),

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/profile.png'),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Ayesha Khan',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1B3A2D),
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'Farmer',
                            style: TextStyle(
                              fontSize: 15,
                              color: Color(0xFF7A8B83),
                            ),
                          ),

                          const SizedBox(height: 5),

                          Row(
                            children: [
                              Icon(
                                Icons.verified,
                                size: 16,
                                color: Color(0xFF1B3A2D),
                              ),
                              Text(
                                'Verified',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF1B3A2D),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 15),

              // Statistics cards
              Container(
                margin: const EdgeInsets.fromLTRB(4, 15, 4, 15),
                child: Row(
                  children: [
                    Expanded(
                      child: StatCard(value: '320kg', label: 'Waste Recovered'),
                    ),

                    const SizedBox(width: 3),

                    Expanded(
                      child: StatCard(value: '12', label: 'Exchange'),
                    ),

                    const SizedBox(width: 3),

                    Expanded(
                      child: StatCard(value: '4.8', label: 'Community Rating'),
                    ),
                  ],
                ),
              ),

              // Profile menu items
              Column(
                children: [
                  MenuCard(
                    icon: Icons.people_alt_outlined,
                    label: 'My Listing',
                    onTap: () {
                      if (AppSession.canSell) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyListingsScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Tap the + button to enable selling first',
                            ),
                          ),
                        );
                      }
                    },
                  ),

                  // CHANGED: these two now open their screens
                  MenuCard(
                    icon: Icons.group_outlined,
                    label: 'My Request',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyRequestsScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(
                    icon: Icons.local_shipping_outlined,
                    label: 'My Conversations',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MessagesScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(
                    icon: Icons.bookmark_border,
                    label: 'Saved Items',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SavedItemsScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(
                    icon: Icons.notifications_outlined,
                    label: 'Notifications',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NotificationsScreen(),
                        ),
                      );
                    },
                  ),

                  MenuCard(icon: Icons.info_outline, label: 'Help & Support'),

                  MenuCard(
                    icon: Icons.settings_outlined,
                    label: 'Settings',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
