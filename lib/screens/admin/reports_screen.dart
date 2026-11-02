import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/widgets/button.dart';

/// Screen 39: Reports. Two tabs: reported Listings and reported Users.
/// "Resolve" removes the report from the list.
/// BACKEND LATER: load the reports that users send from Screen 37.
class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  String _tab = 'Listings';

  final List<Map<String, String>> _listingReports = [
    {'title': 'Spam listing', 'detail': 'Fabric scraps (mixed)', 'count': '3'},
    {'title': 'Fraud attempt', 'detail': 'Plastic Bottles', 'count': '1'},
  ];

  final List<Map<String, String>> _userReports = [
    {'title': 'Harassment', 'detail': 'Umar Ahmed', 'count': '2'},
    {'title': 'Fake profile', 'detail': 'Sana Malik', 'count': '1'},
  ];

  List<Map<String, String>> get _current =>
      _tab == 'Listings' ? _listingReports : _userReports;

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
    final reports = _current;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Reports',
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
                  _tabButton('Listings'),
                  const SizedBox(width: 8),
                  _tabButton('Users'),
                ],
              ),
              const SizedBox(height: 16),
              Expanded(
                child: reports.isEmpty
                    ? const Center(
                        child: Text(
                          'No reports.',
                          style: TextStyle(color: AppColors.textColor),
                        ),
                      )
                    : ListView.builder(
                        itemCount: reports.length,
                        itemBuilder: (context, index) {
                          final r = reports[index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundColor,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: AppColors.borderColor),
                            ),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: AppColors.selected,
                                child: Text(
                                  r['count']!,
                                  style: const TextStyle(
                                    color: AppColors.textColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                r['title']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                r['detail']!,
                                style: const TextStyle(fontSize: 11),
                              ),
                              trailing: TextButton(
                                onPressed: () {
                                  setState(() => reports.removeAt(index));
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Report resolved'),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Resolve',
                                  style: TextStyle(color: AppColors.textColor),
                                ),
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
