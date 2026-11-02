import 'package:flutter/material.dart';
import 'package:trash2treasure/data/seller_data.dart';
import 'package:trash2treasure/widgets/manage_listing_sheet.dart';

import 'package:trash2treasure/widgets/listing_tile.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/widgets/button.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreen();
}

class _MyListingsScreen extends State<MyListingsScreen> {
  String selected = 'All';

  // All listings now live in SellerStore (data/seller_data.dart), so
  // "Publish", "Edit", "Mark as Sold" and "Delete" show up here.
  List<Map<String, dynamic>> get allListings => SellerStore.listings.value;

  @override
  void initState() {
    super.initState();
    SellerStore.listings.addListener(_refresh);
  }

  @override
  void dispose() {
    SellerStore.listings.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    if (mounted) setState(() {});
  }

  //filter according to the selected button
  List<Map<String, dynamic>> get filtered {
    if (selected == 'All') {
      return allListings;
    } else {
      return allListings.where((e) => e['status'] == selected).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'My Listings',
          style: TextStyle(
            color: Color(0xFF1B3A2D),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              //BUTTONS
              Row(
                children: [
                  Expanded(
                    child: Button(
                      buttonText: 'All',
                      fontSize: 10,
                      buttonTextColor: selected == 'All'
                          ? Colors.white
                          : AppColors.textColor,
                      buttonColor: selected == 'All'
                          ? AppColors.textColor
                          : AppColors.backgroundColor,
                      onPressed: () {
                        setState(() {
                          selected = 'All';
                        });
                      },
                    ),
                  ),

                  SizedBox(width: 5),

                  Expanded(
                    child: Button(
                      buttonText: 'Active',
                      fontSize: 10,
                      buttonTextColor: selected == 'Active'
                          ? Colors.white
                          : AppColors.textColor,
                      buttonColor: selected == 'Active'
                          ? AppColors.textColor
                          : AppColors.backgroundColor,
                      onPressed: () {
                        setState(() {
                          selected = 'Active';
                        });
                      },
                    ),
                  ),

                  SizedBox(width: 5),

                  Expanded(
                    child: Button(
                      buttonText: 'Sold',
                      fontSize: 10,
                      buttonTextColor: selected == 'Sold'
                          ? Colors.white
                          : AppColors.textColor,
                      buttonColor: selected == 'Sold'
                          ? AppColors.textColor
                          : AppColors.backgroundColor,
                      onPressed: () {
                        setState(() {
                          selected = 'Sold';
                        });
                      },
                    ),
                  ),

                  SizedBox(width: 5),

                  Expanded(
                    child: Button(
                      buttonText: 'Draft',
                      fontSize: 10,
                      buttonTextColor: selected == 'Draft'
                          ? Colors.white
                          : AppColors.textColor,
                      buttonColor: selected == 'Draft'
                          ? AppColors.textColor
                          : AppColors.backgroundColor,
                      onPressed: () {
                        setState(() {
                          selected = 'Draft';
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final item = filtered[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      // Tap = Manage Listing options (Screen 25)
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => showManageListingSheet(context, item),
                        child: ListingTile(
                          image: item['image'],
                          title: item['title'],
                          price: item['price'],
                          weight: item['weight'],
                          status: item['status'],
                        ),
                      ),
                    );
                  },
                ),
              ),

              //all listingss
            ],
          ),
        ),
      ),
    );
  }
}
