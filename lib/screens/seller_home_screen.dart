import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../widgets/stat_card.dart';
import '../widgets/confirmed_pending_requests.dart';
import 'add_listing_screen.dart';

import '../core/app_colors.dart';

class SellerHomeScreen extends StatelessWidget {
  const SellerHomeScreen({super.key});

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
                      child: StatCard(value: '5', label: 'Total Listings'),
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

                Text(
                  'Recent Requests',
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
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
