import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';

/// One chat message bubble.
/// isMe = true  -> bubble on the right (my message, darker green)
/// isMe = false -> bubble on the left, with the seller's small picture
class ChatBubble extends StatelessWidget {
  final String text; // the message
  final bool isMe; // who sent it

  const ChatBubble({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        // My messages go to the right, the seller's to the left
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Small seller picture, only on the seller's messages
          if (!isMe) ...[
            const CircleAvatar(
              radius: 14,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(width: 8),
          ],

          // ConstrainedBox stops a long message from using the full width
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.65,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? AppColors.selected : AppColors.backgroundColor,
                border: Border.all(color: AppColors.borderColor),
                // Corner next to the sender is less round (chat look)
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isMe ? 16 : 4),
                  bottomRight: Radius.circular(isMe ? 4 : 16),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
