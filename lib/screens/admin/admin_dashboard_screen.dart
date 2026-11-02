import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_nav.dart';
import 'package:trash2treasure/screens/admin/reports_screen.dart';
import 'package:trash2treasure/screens/admin/user_management_screen.dart';
import 'package:trash2treasure/screens/admin/verification_queue_screen.dart';
import 'package:trash2treasure/widgets/menu_card.dart';

/// Screen 36: Admin Dashboard.
/// Numbers are dummy for now. BACKEND LATER: load real counts.
class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                const Row(
                  children: [
                    Expanded(
                      child: _AdminStat(value: '124', label: 'Active Listings'),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: _AdminStat(value: '248', label: 'Total Users'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Row(
                  children: [
                    Expanded(
                      child: _AdminStat(value: '5', label: 'Pending IDs'),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: _AdminStat(value: '5', label: 'Reports')),
                  ],
                ),
                const SizedBox(height: 20),
                MenuCard(
                  icon: Icons.verified_user_outlined,
                  label: 'Verification Queue',
                  onTap: () => _open(context, const VerificationQueueScreen()),
                ),
                MenuCard(
                  icon: Icons.flag_outlined,
                  label: 'Reports',
                  onTap: () => _open(context, const ReportsScreen()),
                ),
                MenuCard(
                  icon: Icons.manage_accounts_outlined,
                  label: 'User Management',
                  onTap: () => _open(context, const UserManagementScreen()),
                ),
                MenuCard(
                  icon: Icons.logout,
                  label: 'Log Out',
                  textColor: const Color(0xFFD32F2F),
                  iconColor: const Color(0xFFD32F2F),
                  backgroundColor: const Color(0xFFFDECEC),
                  borderColor: const Color(0xFFF5C2C2),
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

class _AdminStat extends StatelessWidget {
  final String value;
  final String label;

  const _AdminStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(fontSize: 11, color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}
