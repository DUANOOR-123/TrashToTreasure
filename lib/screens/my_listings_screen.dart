import 'package:flutter/material.dart';

import '../widgets/listing_tile.dart';

import '../core/app_colors.dart';
import '../widgets/button.dart';

class MyListingsScreen extends StatefulWidget {
  const MyListingsScreen({super.key});

  @override
  State<MyListingsScreen> createState() => _MyListingsScreen();
}

class _MyListingsScreen extends State<MyListingsScreen> {
  String selected = 'All';

  //all listing detailss
  List<Map<String, dynamic>> allListings = [
    {
      'image': 'assets/images/waste.png',
      'title': 'Cardboard Boxes',
      'price': 250,
      'weight': '5 kg',
      'status': 'Active',
    },
    {
      'image': 'assets/images/waste.png',
      'title': 'Plastic Bottles',
      'price': 60,
      'weight': '2 kg',
      'status': 'Active',
    },
    {
      'image': 'assets/images/waste.png',
      'title': 'Waste Paper',
      'price': 120,
      'weight': '3 kg',
      'status': 'Sold',
    },
    {
      'image': 'assets/images/waste.png',
      'title': 'Polythene Bags',
      'price': 20,
      'weight': '1 kg',
      'status': 'Draft',
    },
  ];

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
                      child: ListingTile(
                        image: item['image'],
                        title: item['title'],
                        price: item['price'],
                        weight: item['weight'],
                        status: item['status'],
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
