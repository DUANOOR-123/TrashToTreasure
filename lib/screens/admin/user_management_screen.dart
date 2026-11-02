import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/widgets/button.dart';

/// Screen 40: User Management. Two tabs: Users and Banned.
/// The switch bans / unbans a user and moves them to the other tab.
/// BACKEND LATER: load users and save the ban state.
class UserManagementScreen extends StatefulWidget {
  const UserManagementScreen({super.key});

  @override
  State<UserManagementScreen> createState() => _UserManagementScreenState();
}

class _AdminUser {
  final String name;
  final String role;
  bool banned;

  _AdminUser(this.name, this.role, {this.banned = false});
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  String _tab = 'Users';

  final List<_AdminUser> _users = [
    _AdminUser('Ayesha Khan', 'Buyer & Seller'),
    _AdminUser('Umar Ahmed', 'Seller'),
    _AdminUser('Sana Malik', 'Buyer'),
    _AdminUser('Rida Khan', 'Buyer'),
    _AdminUser('Zara Ali', 'Seller', banned: true),
  ];

  Widget _tabButton(String label) {
    final selected = _tab == label;
    return Expanded(
      child: Button(
        buttonText: label,
        fontSize: 12,
        buttonTextColor: selected ? Colors.white : AppColors.textColor,
        buttonColor: selected ? AppColors.textColor : AppColors.backgroundColor,
        onPressed: () => setState(() => _tab = label),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shown = _users.where((u) => u.banned == (_tab == 'Banned')).toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'User Management',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  _tabButton('Users'),
                  const SizedBox(width: 8),
                  _tabButton('Banned'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: shown.isEmpty
                    ? const Center(
                        child: Text(
                          'No users here.',
                          style: TextStyle(color: AppColors.textColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: shown.length,
                        itemBuilder: (context, index) {
                          final u = shown[index];
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
                                backgroundImage: AssetImage(
                                  'assets/images/profile.png',
                                ),
                              ),
                              title: Text(
                                u.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                u.role,
                                style: const TextStyle(fontSize: 11),
                              ),
                              trailing: Switch(
                                value: !u.banned,
                                activeTrackColor: AppColors.textColor,
                                onChanged: (active) {
                                  setState(() => u.banned = !active);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
