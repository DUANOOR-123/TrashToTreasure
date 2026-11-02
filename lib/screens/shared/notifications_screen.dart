import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// Screen 30: Notifications.
/// Dummy data for now. BACKEND LATER: load the user's notifications.
class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationItem {
  final IconData icon;
  final String title;
  final String message;
  final String time;
  bool unread;

  _NotificationItem({
    required this.icon,
    required this.title,
    required this.message,
    required this.time,
    this.unread = false,
  });
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<_NotificationItem> _items = [
    _NotificationItem(
      icon: Icons.check_circle_outline,
      title: 'Request accepted',
      message: 'Your request has been accepted by the seller.',
      time: '10 min ago',
      unread: true,
    ),
    _NotificationItem(
      icon: Icons.chat_bubble_outline,
      title: 'New message',
      message: 'Ayesha-Fabrics: Yes, it is. Would you like to see photos?',
      time: '1 h ago',
      unread: true,
    ),
    _NotificationItem(
      icon: Icons.local_shipping_outlined,
      title: 'Order updated',
      message: 'Your collection has been scheduled.',
      time: 'Yesterday',
    ),
    _NotificationItem(
      icon: Icons.verified_outlined,
      title: 'Welcome to Trash 2 Treasure',
      message: 'Start browsing materials near you.',
      time: 'Mon',
    ),
  ];

  void _markAllRead() {
    setState(() {
      for (final item in _items) {
        item.unread = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: _markAllRead,
            child: const Text(
              'Mark all read',
              style: TextStyle(color: AppColors.textColor, fontSize: 12),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: _items.length,
          itemBuilder: (context, index) {
            final item = _items[index];
            return InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => setState(() => item.unread = false),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: item.unread
                      ? AppColors.selected.withValues(alpha: 0.45)
                      : AppColors.backgroundColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.borderColor),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: AppColors.selected,
                      child: Icon(item.icon, color: AppColors.textColor),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.message,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppColors.textColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item.time,
                            style: TextStyle(
                              fontSize: 10,
                              color: AppColors.textColor.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (item.unread)
                      const Padding(
                        padding: EdgeInsets.only(top: 4),
                        child: Icon(Icons.circle, size: 10, color: Colors.red),
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
