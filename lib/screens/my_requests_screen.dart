import 'package:flutter/material.dart';

import 'order_status_screen.dart';
import '../core/app_colors.dart';
import '../data/buyer_data.dart';
import '../widgets/filter_pill.dart';
import '../widgets/request_tile.dart';

/// Screen 19: My Requests.
/// Two tabs (Active / Completed) and a list of the buyer's pickup requests.
/// StatefulWidget because the selected tab changes.
///
/// CHANGED:
///  - the list comes from RequestStore, so a request you just sent shows up
///  - Canceled requests are now in the second tab with the finished ones
///    (the tab is called "Completed" like in your design)
///  - tapping a request opens ITS order status
///  - reachable from: Home card, Profile > My Request, and after sending
class MyRequestsScreen extends StatefulWidget {
  const MyRequestsScreen({super.key});

  @override
  State<MyRequestsScreen> createState() => _MyRequestsScreenState();
}

class _MyRequestsScreenState extends State<MyRequestsScreen> {
  // Which tab is selected: 'Active' or 'Completed'
  String _tab = 'Active';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text(
          'My Requests',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ValueListenableBuilder redraws the list when the store changes
      body: ValueListenableBuilder<List<BuyerRequest>>(
        valueListenable: RequestStore.requests,
        builder: (context, all, _) {
          // Only the requests that belong to the selected tab
          final requests = all
              .where((r) => _tab == 'Active' ? r.isActive : !r.isActive)
              .toList();

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // ---- Tabs: Active / Completed ----
                  Row(
                    children: [
                      for (final name in ['Active', 'Completed'])
                        // Expanded: both tabs share the width equally
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              right: name == 'Active' ? 10 : 0,
                            ),
                            child: FilterPill(
                              label: name,
                              isSelected: _tab == name,
                              // setState redraws the list for the new tab
                              onTap: () => setState(() => _tab = name),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // ---- List of requests ----
                  Expanded(
                    child: requests.isEmpty
                        ? const Center(
                            child: Text(
                              'No requests here',
                              style: TextStyle(color: AppColors.textColor),
                            ),
                          )
                        : ListView.builder(
                            itemCount: requests.length,
                            itemBuilder: (context, index) {
                              final r = requests[index];
                              return RequestTile(
                                image: r.listing.image,
                                title: r.listing.title,
                                price: r.listing.price,
                                distance: r.listing.distanceLabel,
                                status: r.status,
                                // Open Order Status (Screen 18) of THIS request
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrderStatusScreen(request: r),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
