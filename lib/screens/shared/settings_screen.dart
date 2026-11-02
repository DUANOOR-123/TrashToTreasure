import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_nav.dart';
import 'package:trash2treasure/core/app_session.dart';

import 'package:trash2treasure/widgets/menu_card.dart';
import 'package:trash2treasure/screens/shared/location_filter_screen.dart';
import 'package:trash2treasure/core/app_colors.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // "Switch Role": pick Buyer / Seller / Both, then reopen the app home.
  void _switchRole(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        Widget option(String title, UserRole role) {
          return ListTile(
            title: Text(title),
            trailing: AppSession.role == role
                ? const Icon(Icons.check, color: AppColors.textColor)
                : null,
            onTap: () {
              Navigator.pop(sheetContext);
              AppSession.role = role;
              AppNav.goHome(context);
            },
          );
        }

        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              option('Buyer', UserRole.buyer),
              option('Seller', UserRole.seller),
              option('Both (Buy & Sell)', UserRole.both),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(12),

            child: Column(
              children: [
                MenuCard(
                  icon: Icons.person_outline,
                  label: 'Account Information',
                ),

                MenuCard(
                  icon: Icons.notifications_outlined,
                  label: 'Notification Preferences',
                ),

                MenuCard(
                  icon: Icons.location_on_outlined,
                  label: 'Location Settings',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocationFilterScreen(),
                      ),
                    );
                  },
                ),

                MenuCard(icon: Icons.language, label: 'Language'),

                MenuCard(icon: Icons.lock_outline, label: 'Privacy & Security'),

                MenuCard(icon: Icons.help_outline, label: 'Help & Support'),

                MenuCard(
                  icon: Icons.swap_horiz,
                  label: 'Switch Role',
                  onTap: () => _switchRole(context),
                ),

                MenuCard(
                  icon: Icons.logout,
                  label: 'Log Out',
                  textColor: Color(0xFFD32F2F),
                  iconColor: Color(0xFFD32F2F),
                  backgroundColor: Color(0xFFFDECEC),
                  borderColor: Color(0xFFF5C2C2),
                  onTap: () => AppNav.logout(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
