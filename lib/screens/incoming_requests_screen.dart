import 'package:flutter/material.dart';

import '../widgets/button.dart';
import '../core/app_colors.dart';

class IncomingRequestsScreen extends StatelessWidget {
  const IncomingRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> requests = [
      {
        'image': 'assets/images/profile.png',
        'name': 'Eman Tahir',
        'item': 'Fabric scraps (mixed)',
        'time': '1h',
      },
      {
        'image': 'assets/images/profile.png',
        'name': 'Dua Noor',
        'item': 'Plastic Bottles',
        'time': '2h',
      },
      {
        'image': 'assets/images/profile.png',
        'name': 'Minahil Nazeer',
        'item': 'Old Newspapers',
        'time': '11h',
      },
      {
        'image': 'assets/images/profile.png',
        'name': 'Seerat Iftikhar',
        'item': 'Cardboard Boxes',
        'time': '1d',
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
          'Incoming Requests',
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
            itemCount: requests.length,
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
                    backgroundImage: AssetImage(requests[index]['image']),
                  ),

                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        requests[index]['name'],
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      Text(
                        requests[index]['item'],
                        style: TextStyle(fontSize: 11),
                      ),

                      Text(
                        requests[index]['time'],
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),

                  subtitle: Row(
                    children: [
                      Expanded(
                        child: Button(buttonText: 'Accept', onPressed: () {}),
                      ),

                      SizedBox(width: 4),
                      Expanded(
                        child: Button(
                          buttonText: 'Reject',
                          buttonColor: Color(0xFFB42318),
                          buttonTextColor: Colors.white,
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
