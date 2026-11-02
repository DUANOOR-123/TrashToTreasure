import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

class ConfirmedPendingRequests extends StatelessWidget {
  final String user;

  final String distance;
  final bool isConfirmed;
  final String material;

  const ConfirmedPendingRequests({
    super.key,
    required this.user,
    required this.distance,
    required this.isConfirmed,
    required this.material,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/profile.png'),
        ),
        title: Text(
          user,
          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '$material - $distance',
          style: TextStyle(fontSize: 11, color: AppColors.textColor),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isConfirmed ? Icons.check_circle : Icons.access_time,
              size: 12,
              color: isConfirmed ? Colors.green : Colors.orange,
            ),
            SizedBox(width: 4),
            Text(
              isConfirmed ? 'Confirmed' : 'Pending',
              style: TextStyle(
                fontSize: 11,
                color: isConfirmed ? Colors.green : Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
