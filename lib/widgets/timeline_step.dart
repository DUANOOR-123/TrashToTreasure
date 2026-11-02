import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// One step in the order timeline:
///   (circle) Title
///      |     Date / time
///      |
/// Done steps have a dark green circle with a check mark.
/// Steps not done yet are faded with a clock icon.
class TimelineStep extends StatelessWidget {
  final String title; // e.g. 'Request Sent'
  final String subtitle; // e.g. 'Jan 16, 10:45 AM'
  final bool isDone; // true = finished step
  final bool isLast; // true = no line below this step

  const TimelineStep({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isDone,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    // IntrinsicHeight makes the left line stretch to the height of the text
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ---- Left side: circle + vertical line ----
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // The circle
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isDone ? AppColors.textColor : AppColors.selected,
                  ),
                  child: Icon(
                    isDone ? Icons.check : Icons.access_time,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                // The line to the next step (not drawn after the last step)
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      color: isDone
                          ? AppColors.textColor
                          : AppColors.borderColor,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // ---- Right side: title and time ----
          Expanded(
            child: Padding(
              // Space below, so the next circle is not too close
              padding: const EdgeInsets.only(top: 2, bottom: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      // Faded text for steps that are not done yet
                      color: isDone
                          ? AppColors.textColor
                          : AppColors.textColor.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textColor.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
