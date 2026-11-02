import 'package:flutter/material.dart';

import '../core/app_colors.dart';

class CustomersListScreen extends StatelessWidget {
  const CustomersListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> customers = [
      {
        'image': 'assets/images/profile.png',
        'name': 'Eman Tahir',
        'orders': '10 orders',
      },
      {
        'image': 'assets/images/profile.png',
        'name': 'Dua Noor',
        'orders': '5 orders',
      },
      {
        'image': 'assets/images/profile.png',
        'name': 'Minahil Nazeer',
        'orders': '3 orders',
      },
      {
        'image': 'assets/images/profile.png',
        'name': 'Seerat Iftikhar',
        'orders': '2 orders',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),

        title: const Text(
          'Customers List',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(15),
          child: ListView.builder(
            itemCount: customers.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 24,
                    backgroundImage: AssetImage(customers[index]['image']),
                  ),

                  title: Text(
                    customers[index]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(customers[index]['orders']),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
