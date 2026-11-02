import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

class ListingTile extends StatelessWidget {
  final String image;
  final String title;
  final int price;
  final String weight;
  final String status;

  const ListingTile({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.weight,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),

      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rs. $price - $weight', style: TextStyle(fontSize: 11)),
            Text(
              status,
              style: TextStyle(fontSize: 12, color: AppColors.textColor),
            ),
          ],
        ),
        leading: SizedBox(
          height: 60,
          width: 60,
          child: Image.asset(image, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
