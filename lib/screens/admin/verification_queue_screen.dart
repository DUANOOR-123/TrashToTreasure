import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/screens/admin/id_detail_screen.dart';

/// Screen 37: Verification Queue. Lists users waiting for ID approval.
/// "View" opens the ID Detail screen (38); Approve / Reject removes
/// the user from the queue.
class VerificationQueueScreen extends StatefulWidget {
  const VerificationQueueScreen({super.key});

  @override
  State<VerificationQueueScreen> createState() =>
      _VerificationQueueScreenState();
}

class _VerificationQueueScreenState extends State<VerificationQueueScreen> {
  final List<Map<String, String>> _queue = [
    {'name': 'Ayesha Khan', 'time': 'Jan 16, 10:45 AM'},
    {'name': 'Umar Ahmed', 'time': 'Jan 16, 9:10 AM'},
    {'name': 'Sana Malik', 'time': 'Jan 15, 6:30 PM'},
    {'name': 'Rida Khan', 'time': 'Jan 15, 2:05 PM'},
    {'name': 'Zara Ali', 'time': 'Jan 14, 11:20 AM'},
  ];

  Future<void> _view(Map<String, String> user) async {
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => IdDetailScreen(userName: user['name']!),
      ),
    );

    if (!mounted || result == null) return;

    setState(() => _queue.remove(user));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          result
              ? '${user['name']} approved'
              : '${user['name']} rejected',
        ),
      ),
    );
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
          'Verification Queue',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: _queue.isEmpty
            ? const Center(
                child: Text(
                  'No pending verifications.',
                  style: TextStyle(color: AppColors.textColor),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: _queue.length,
                itemBuilder: (context, index) {
                  final user = _queue[index];
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
                        user['name']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        user['time']!,
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.textColor,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () => _view(user),
                        child: const Text('View'),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
