import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_nav.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/screens/seller/add_listing_screen.dart';

import 'package:trash2treasure/data/buyer_data.dart';
import 'package:trash2treasure/widgets/buyer_bottom_nav.dart';
import 'package:trash2treasure/screens/buyer/buyer_home_screen.dart';
import 'package:trash2treasure/screens/buyer/map_view_screen.dart';
import 'package:trash2treasure/screens/shared/messages_screen.dart';
import 'package:trash2treasure/screens/shared/profile_screen.dart';
import 'package:trash2treasure/screens/seller/seller_home_screen.dart';
import 'package:trash2treasure/core/app_colors.dart';

/// The main buyer screen: it holds the bottom bar ONCE and switches
/// the content above it. Home, Map, Messages and Profile are "tabs", so
/// the bottom bar is always visible on them (this fixes the Map problem).
///
/// IndexedStack keeps every tab alive, so the map does not reload and a
/// typed message is not lost when you switch tabs.
class BuyerShell extends StatefulWidget {
  const BuyerShell({super.key});

  @override
  State<BuyerShell> createState() => _BuyerShellState();
}

class _BuyerShellState extends State<BuyerShell> {
  // 0 = Home, 1 = Map, 2 = Sell (+), 3 = Messages, 4 = Profile
  int _currentIndex = 0;

  void _onTabTap(int index) {
    // The "+" is not a tab: it opens the "Start selling" sheet
    if (index == 2) {
      _onSellTap();
      return;
    }
    // Guests can only browse: Messages and Profile need an account
    if (index == 3 &&
        !AppNav.requireLogin(context, action: 'see your messages')) {
      return;
    }
    if (index == 4 &&
        !AppNav.requireLogin(context, action: 'see your profile')) {
      return;
    }
    setState(() => _currentIndex = index);
  }

  // The "+" button. Guests are asked to log in. Sellers go to the seller
  // side. Buyers who never enabled selling see the "Enable Selling" sheet.
  void _onSellTap() {
    if (!AppNav.requireLogin(context, action: 'sell your materials')) return;

    if (AppSession.canSell) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AppSession.isSellerOnly
              ? const AddListingScreen()
              : const SellerHomeScreen(),
        ),
      );
    } else {
      _showSellSheet();
    }
  }

  // Bottom sheet for buyers who want to sell (design screen 34:
  // "Enable Selling"). Continue opens the seller side (Seller Home).
  void _showSellSheet() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.bg,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.selected,
                  child: Icon(
                    Icons.sell_outlined,
                    size: 30,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 14),
                const Text(
                  'Start selling your materials',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Turn your waste into treasure and reach buyers near you.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textColor.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      Navigator.pop(sheetContext); // close the sheet
                      AppSession.role = UserRole.both; // selling is now on
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SellerHomeScreen(),
                        ),
                      );
                    },
                    child: const Text('Enable Selling'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // The Sell tab (2) has no screen, so the stack skips it:
    // we map the tab number to the position inside the stack.
    final stackIndex = _currentIndex > 2 ? _currentIndex - 1 : _currentIndex;

    return Scaffold(
      // IndexedStack shows only one child, but keeps the others alive
      body: IndexedStack(
        index: stackIndex,
        children: [
          // Home: "See all" etc. can jump to other tabs with this function
          // Sellers who chose "Seller" only start on the Seller Home
          AppSession.isSellerOnly
              ? const SellerHomeScreen()
              : BuyerHomeScreen(onOpenMap: () => setState(() => _currentIndex = 1)),
          const MapViewScreen(isTab: true),
          const MessagesScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BuyerBottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTap,
        messagesBadge: totalUnread,
      ),
    );
  }
}
