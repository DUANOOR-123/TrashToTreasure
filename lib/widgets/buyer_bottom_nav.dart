import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// Bottom bar of the buyer app: Home, Map, Sell (+), Messages, Profile.
/// It lives ONCE inside BuyerShell, so it stays visible on every tab.
///
/// CHANGED: "Explore" is now "Map" (categories are on the Home screen),
/// and the Messages tab can show a red badge with the unread count.
class BuyerBottomNav extends StatelessWidget {
  final int currentIndex; // which tab is highlighted (0 = Home)
  final ValueChanged<int> onTap; // called with the tapped tab's index
  final int messagesBadge; // unread messages (0 = no badge)

  const BuyerBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.messagesBadge = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      // SafeArea keeps the bar above the phone's gesture/home area
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _item(0, Icons.home_outlined, Icons.home, 'Home'),
              _item(1, Icons.map_outlined, Icons.map, 'Map'),
              _sellButton(),
              _item(
                3,
                Icons.chat_bubble_outline,
                Icons.chat_bubble,
                'Messages',
                badge: messagesBadge,
              ),
              _item(4, Icons.person_outline, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  // A normal tab: icon + label, dark when selected, faded when not.
  Widget _item(
    int index,
    IconData icon,
    IconData activeIcon,
    String label, {
    int badge = 0,
  }) {
    final bool selected = currentIndex == index;
    final Color color = selected
        ? AppColors.textColor
        : AppColors.textColor.withValues(alpha: 0.5);

    Widget iconWidget = Icon(
      selected ? activeIcon : icon,
      color: color,
      size: 24,
    );

    // Red badge in the corner of the icon (only if there is something new)
    if (badge > 0) {
      iconWidget = Badge(
        label: Text('$badge'),
        backgroundColor: Colors.red,
        child: iconWidget,
      );
    }

    return InkWell(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            iconWidget,
            const SizedBox(height: 2),
            Text(label, style: TextStyle(fontSize: 10, color: color)),
          ],
        ),
      ),
    );
  }

  // The big round "+" in the middle (tab index 2). Seller side, for later.
  Widget _sellButton() {
    return GestureDetector(
      onTap: () => onTap(2),
      child: Container(
        height: 46,
        width: 46,
        decoration: const BoxDecoration(
          color: AppColors.textColor,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
