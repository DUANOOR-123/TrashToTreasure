import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// Screen 27: Transaction History (seller side).
/// Dummy data for now. BACKEND LATER: load the seller's finished orders.
class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const transactions = <Map<String, String>>[
      {
        'name': 'Eman Tahir',
        'item': 'Fabric scraps (mixed)',
        'date': 'Jan 16',
        'amount': 'Rs. 400',
        'status': 'Completed',
      },
      {
        'name': 'Dua Noor',
        'item': 'Plastic Bottles',
        'date': 'Jan 15',
        'amount': 'Rs. 120',
        'status': 'Completed',
      },
      {
        'name': 'Minahil Nazeer',
        'item': 'Old Newspapers',
        'date': 'Jan 14',
        'amount': 'Rs. 90',
        'status': 'Pending',
      },
      {
        'name': 'Seerat Iftikhar',
        'item': 'Cardboard Boxes',
        'date': 'Jan 12',
        'amount': 'Rs. 250',
        'status': 'Completed',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Transaction History',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            final t = transactions[index];
            final bool done = t['status'] == 'Completed';
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: ListTile(
                leading: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/profile.png'),
                ),
                title: Text(
                  t['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  '${t['item']} - ${t['date']}',
                  style: const TextStyle(fontSize: 11),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      t['amount']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      t['status']!,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: done ? Colors.green : Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
