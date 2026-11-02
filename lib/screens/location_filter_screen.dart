import 'package:flutter/material.dart';

import '../widgets/reusable_radio_tile.dart';
import '../core/app_colors.dart';

class LocationFilterScreen extends StatefulWidget {
  const LocationFilterScreen({super.key});

  @override
  State<LocationFilterScreen> createState() => _LocationFilterScreen();
}

class _LocationFilterScreen extends State<LocationFilterScreen> {
  String? selectedValue = '2km';
  String? selectedSort = 'near';

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

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Location Filter',
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Find materials near you.',
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(15),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Search Radius',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),

                SizedBox(height: 10),

                RadioGroup<String>(
                  groupValue: selectedValue,
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value;
                    });
                  },
                  child: Column(
                    children: [
                      // Tiles will go here

                      ReusableRadioTile(
                        value: '2km',
                        title: 'Within 2km',
                        isSelected: selectedValue == '2km',
                      ),

                      ReusableRadioTile(
                        value: '5km',
                        title: 'Within 5km',
                        isSelected: selectedValue == '5km',
                      ),

                      ReusableRadioTile(
                        value: '10km',
                        title: 'Within 10km',
                        isSelected: selectedValue == '10km',
                      ),

                      ReusableRadioTile(
                        value: '25km',
                        title: 'Within 25km',
                        isSelected: selectedValue == '25km',
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                Text(
                  'Sort by',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),

                SizedBox(height: 10),

                RadioGroup<String>(
                  groupValue: selectedSort,
                  onChanged: (value) {
                    setState(() {
                      selectedSort = value;
                    });
                  },
                  child: Column(
                    children: [
                      // Tiles will go here

                      ReusableRadioTile(
                        value: 'near',
                        title: 'Nearest first',
                        isSelected: selectedSort == 'near',
                      ),

                      ReusableRadioTile(
                        value: 'new',
                        title: 'Newest first',
                        isSelected: selectedSort == 'new',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
