import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/widgets/button.dart';

/// Screen 38: ID Detail. Shows the three uploaded photos of one user.
/// It gives back `true` (approved) or `false` (rejected) to the queue.
/// BACKEND LATER: show the real uploaded photos.
class IdDetailScreen extends StatelessWidget {
  final String userName;

  const IdDetailScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'ID Detail',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 14),
                const Row(
                  children: [
                    Expanded(child: _PhotoBox(label: 'Front')),
                    SizedBox(width: 10),
                    Expanded(child: _PhotoBox(label: 'Back')),
                    SizedBox(width: 10),
                    Expanded(child: _PhotoBox(label: 'Selfie', person: true)),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Button(
                        buttonText: 'Approve',
                        onPressed: () => Navigator.pop(context, true),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Button(
                        buttonText: 'Reject',
                        buttonColor: const Color(0xFFB42318),
                        buttonTextColor: Colors.white,
                        onPressed: () => Navigator.pop(context, false),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PhotoBox extends StatelessWidget {
  final String label;
  final bool person;

  const _PhotoBox({required this.label, this.person = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 0.8,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: Icon(
              person ? Icons.person_outline : Icons.badge_outlined,
              size: 36,
              color: AppColors.textColor,
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: AppColors.textColor),
        ),
      ],
    );
  }
}
