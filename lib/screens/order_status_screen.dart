import 'package:flutter/material.dart';

import '../core/app_colors.dart';
import '../data/buyer_data.dart';
import '../widgets/button.dart';
import '../widgets/timeline_step.dart';
import 'contact_seller_screen.dart';
import 'my_requests_screen.dart';

/// Screen 18: Order Status.
/// Shows where the pickup request is, as a vertical timeline:
/// Request Sent -> Seller Confirmed -> Collection Scheduled -> Collected.
///
/// CHANGED:
///  - it now receives the request, so the timeline matches ITS status
///    (before, every request showed the same timeline)
///  - a summary card on top, and buttons at the bottom:
///    "Chat with Seller" and (right after sending) "View My Requests"
class OrderStatusScreen extends StatelessWidget {
  final BuyerRequest? request;

  /// true when the buyer has just sent the request (shows the success
  /// message and the "View My Requests" button)
  final bool justSent;

  const OrderStatusScreen({super.key, this.request, this.justSent = false});

  // How many timeline steps are finished for each status
  int _doneSteps(String status) {
    switch (status) {
      case 'Pending':
        return 1; // only "Request Sent"
      case 'Confirmed':
        return 2; // + "Seller Confirmed"
      case 'Completed':
        return 4; // everything
      default: // Canceled
        return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // If no request was given (opened from the test menu), show an example
    final req =
        request ??
        BuyerRequest(
          listing: kListings.first,
          quantity: 2,
          time: 'Today, 6:00 PM',
          status: 'Confirmed',
        );
    final done = _doneSteps(req.status);

    // Dummy steps (later: the times come from the backend).
    final steps = [
      {
        'title': 'Request Sent',
        'subtitle': justSent ? 'Just now' : 'Jan 16, 10:45 AM',
      },
      {
        'title': 'Seller Confirmed',
        'subtitle': done >= 2 ? 'Jan 16, 11:20 AM' : 'Waiting for the seller',
      },
      {
        'title': 'Collection Scheduled',
        'subtitle': done >= 3 ? req.time : '(coming soon)',
      },
      {'title': 'Collected', 'subtitle': done >= 4 ? 'Done' : '(coming soon)'},
    ];

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: const Text(
          'Order Status',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Success message (only right after sending)
                    if (justSent) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check_circle, color: Colors.green),
                            SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Request sent! The seller will confirm soon.',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // What was requested
                    _buildSummaryCard(req),
                    const SizedBox(height: 20),

                    // Canceled requests get a short note
                    if (req.status == 'Canceled') ...[
                      const Text(
                        'This request was canceled.',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Heading above the timeline
                    const Text(
                      'Request Pickup',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // One TimelineStep for each item in the list
                    for (int i = 0; i < steps.length; i++)
                      TimelineStep(
                        title: steps[i]['title']!,
                        subtitle: steps[i]['subtitle']!,
                        isDone: i < done,
                        // The last step has no line below it
                        isLast: i == steps.length - 1,
                      ),
                  ],
                ),
              ),
            ),

            // ---- Buttons at the bottom ----
            Container(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
              decoration: const BoxDecoration(
                color: AppColors.backgroundColor,
                border: Border(top: BorderSide(color: AppColors.borderColor)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Button(
                    buttonText: 'Chat with Seller',
                    icon: Icons.chat_bubble_outline,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContactSellerScreen(listing: req.listing),
                        ),
                      );
                    },
                  ),
                  if (justSent) ...[
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.textColor,
                          side: const BorderSide(color: AppColors.textColor),
                        ),
                        // Replace this screen, so Back goes to the material
                        onPressed: () => Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyRequestsScreen(),
                          ),
                        ),
                        child: const Text('View My Requests'),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Card: photo, title, quantity, pickup time, total
  Widget _buildSummaryCard(BuyerRequest req) {
    final total = (req.quantity * req.listing.price).round();
    final qty = req.quantity == req.quantity.roundToDouble()
        ? req.quantity.toStringAsFixed(0)
        : req.quantity.toString();

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              req.listing.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  req.listing.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  '$qty kg · ${req.listing.price == 0 ? 'Free' : 'Rs. $total'}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  'Pickup: ${req.time}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
