import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/data/buyer_data.dart';
import 'package:trash2treasure/screens/buyer/contact_seller_screen.dart';

/// Messages tab (Screen 29): the buyer's recent conversations.
/// Tapping one opens the chat (Screen 16).
///
/// NEW: before, chat was only reachable from inside a listing. Now every
/// conversation is listed here, newest first, with an unread badge.
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        // This screen is a tab, so no back arrow
        automaticallyImplyLeading: false,
        title: const Text(
          'Messages',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: kConversations.isEmpty
            ? const Center(
                child: Text(
                  'No messages yet.\nOpen a material and tap Chat to start.',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.textColor),
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: kConversations.length,
                itemBuilder: (context, index) {
                  final c = kConversations[index];
                  return _ConversationTile(
                    conversation: c,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ContactSellerScreen(sellerName: c.sellerName),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}

/// One row: [picture] Name ............ time
///                    last message ...... (badge)
class _ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final VoidCallback onTap;

  const _ConversationTile({required this.conversation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unread > 0;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.sellerName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                      Text(
                        conversation.time,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textColor.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          conversation.lastMessage,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            // Bold + darker when there is something new
                            fontWeight: hasUnread
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: AppColors.textColor.withValues(
                              alpha: hasUnread ? 1 : 0.7,
                            ),
                          ),
                        ),
                      ),
                      if (hasUnread) ...[
                        const SizedBox(width: 8),
                        CircleAvatar(
                          radius: 9,
                          backgroundColor: AppColors.textColor,
                          child: Text(
                            '${conversation.unread}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
