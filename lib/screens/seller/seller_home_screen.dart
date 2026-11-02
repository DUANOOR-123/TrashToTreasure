import 'package:flutter/material.dart';
import 'package:trash2treasure/screens/seller/my_listings_screen.dart';
import 'package:trash2treasure/screens/seller/incoming_requests_screen.dart';
import 'package:trash2treasure/screens/seller/customers_list_screen.dart';
import 'package:trash2treasure/screens/seller/transaction_history_screen.dart';
import 'package:trash2treasure/screens/shared/notifications_screen.dart';

import 'package:trash2treasure/widgets/button.dart';
import 'package:trash2treasure/widgets/stat_card.dart';
import 'package:trash2treasure/widgets/confirmed_pending_requests.dart';
import 'package:trash2treasure/screens/seller/add_listing_screen.dart';

import 'package:trash2treasure/core/app_colors.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seller Home',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Customers',
            color: AppColors.textColor,
            icon: const Icon(Icons.people_outline),
            onPressed: () => _open(context, const CustomersListScreen()),
          ),
          IconButton(
            tooltip: 'Transaction History',
            color: AppColors.textColor,
            icon: const Icon(Icons.receipt_long_outlined),
            onPressed: () => _open(context, const TransactionHistoryScreen()),
          ),
          IconButton(
            tooltip: 'Notifications',
            color: AppColors.textColor,
            icon: const Icon(Icons.notifications_none),
            onPressed: () => _open(context, const NotificationsScreen()),
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                //good morning, user
                Text(
                  'Good Morning,',
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),

                Text(
                  'Ayesha Khan',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 10),

                //stat card
                Row(
                  children: [
                    Expanded(
                      // Tap = open My Listings (Screen 23)
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => _open(context, const MyListingsScreen()),
                        child: StatCard(value: '5', label: 'Total Listings'),
                      ),
                    ),

                    SizedBox(width: 10),

                    Expanded(
                      child: StatCard(value: '124', label: 'Total Views'),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // BUTTON +add listing
                Button(
                  icon: Icons.add,
                  buttonText: 'Add Listing', // your dark green
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddListingScreen(),
                      ),
                    );
                  },
                ),

                SizedBox(height: 15),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Recent Requests',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    // Opens Incoming Requests (Screen 24)
                    GestureDetector(
                      onTap: () =>
                          _open(context, const IncomingRequestsScreen()),
                      child: Text(
                        'See all',
                        style: TextStyle(
                          color: AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                ConfirmedPendingRequests(
                  user: 'Noor Zahra',
                  distance: '2km',
                  isConfirmed: true,
                  material: 'Plastic',
                ),

                SizedBox(height: 15),

                ConfirmedPendingRequests(
                  user: 'Esha Mirza',
                  distance: '2km',
                  isConfirmed: false,
                  material: 'Chart Papers',
                ),

                SizedBox(height: 15),

                ConfirmedPendingRequests(
                  user: 'Javeria Dawood',
                  distance: '1.1km',
                  isConfirmed: true,
                  material: 'Card-board',
                ),

                SizedBox(height: 15),

                ConfirmedPendingRequests(
                  user: 'Misbah Qureshi',
                  distance: '5km',
                  isConfirmed: false,
                  material: 'Chart papers',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
