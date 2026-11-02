import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/widgets/button.dart';
import 'package:trash2treasure/widgets/reusable_radio_tile.dart';
import 'package:trash2treasure/widgets/reusable_text_field.dart';

/// Screen 37: Report User / Listing.
/// [subject] is shown under the title, e.g. the listing being reported.
/// BACKEND LATER: send the report to the admin "Reports" list.
class ReportScreen extends StatefulWidget {
  final String? subject;

  const ReportScreen({super.key, this.subject});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? _type = 'listing';
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _submit() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Report sent. Thank you for helping us.')),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Report',
              style: TextStyle(
                color: AppColors.textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (widget.subject != null)
              Text(
                widget.subject!,
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What do you want to report?',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                RadioGroup<String>(
                  groupValue: _type,
                  onChanged: (value) => setState(() => _type = value),
                  child: Column(
                    children: [
                      ReusableRadioTile(
                        value: 'user',
                        title: 'Report User',
                        isSelected: _type == 'user',
                      ),
                      ReusableRadioTile(
                        value: 'listing',
                        title: 'Report Listing',
                        isSelected: _type == 'listing',
                      ),
                      ReusableRadioTile(
                        value: 'other',
                        title: 'Other',
                        isSelected: _type == 'other',
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                ReusableTextField(
                  label: 'Details (optional)',
                  hintText: 'Tell us what went wrong...',
                  controller: _detailsController,
                  maxLines: 4,
                ),
                const SizedBox(height: 20),
                Button(buttonText: 'Submit Report', onPressed: _submit),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
