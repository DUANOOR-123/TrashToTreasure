import 'package:flutter/material.dart';

import 'package:trash2treasure/screens/buyer/request_pickup_screen.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/data/buyer_data.dart';
import 'package:trash2treasure/widgets/chat_bubble.dart';

/// Screen 16: Contact Seller (Chat).
/// Shows the conversation and lets the buyer type and send messages.
/// StatefulWidget because new messages are added while the screen is open.
///
/// CHANGED: it can be opened in two ways:
///  - from Listing Details:  ContactSellerScreen(listing: item)
///  - from the Messages tab: ContactSellerScreen(sellerName: 'Sara Textiles')
/// Either way the top of the chat shows the material being discussed,
/// with a "Request Pickup" button, so the buyer can request without leaving.
class ContactSellerScreen extends StatefulWidget {
  final String? sellerName;
  final Listing? listing;

  const ContactSellerScreen({super.key, this.sellerName, this.listing});

  @override
  State<ContactSellerScreen> createState() => _ContactSellerScreenState();
}

class _ContactSellerScreenState extends State<ContactSellerScreen> {
  // Controller = lets us read and clear what is typed in the text box
  final TextEditingController _controller = TextEditingController();

  // Lets us scroll the list to the newest message
  final ScrollController _scroll = ScrollController();

  // Dummy conversation (later: comes from the backend)
  // isMe: true = sent by the buyer, false = sent by the seller
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hi! Is this still available?', 'isMe': true},
    {'text': 'Yes, it is. Would you like to see some photos?', 'isMe': false},
    {'text': 'Great! Can you share your location?', 'isMe': true},
  ];

  // Seller's name: from the listing, or the name we were given
  String get _name =>
      widget.listing?.sellerName ?? widget.sellerName ?? 'Ayesha-Fabrics';

  // The material this chat is about. If we only know the seller (opened from
  // Messages), we use that seller's first listing.
  Listing get _listing =>
      widget.listing ??
      kListings.firstWhere(
        (l) => l.sellerName == _name,
        orElse: () => kListings.first,
      );

  // Opens Request Pickup (Screen 17) for this material
  void _openRequest() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RequestPickupScreen(listing: _listing),
      ),
    );
  }

  // Called when the send button is pressed
  void _sendMessage() {
    final text = _controller.text.trim(); // remove extra spaces
    if (text.isEmpty) return; // don't send empty messages

    // Add the message to the list and redraw the screen
    setState(() {
      _messages.add({'text': text, 'isMe': true});
    });
    _controller.clear(); // empty the text box

    // After the screen redraws, scroll down to the newest message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // Free the controllers' memory when the screen closes
  @override
  void dispose() {
    _controller.dispose();
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      // ---- Top bar: seller picture, name and "Online" ----
      appBar: AppBar(
        backgroundColor: AppColors.bg,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 18,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const Text(
                  'Online',
                  style: TextStyle(fontSize: 11, color: Colors.green),
                ),
              ],
            ),
          ],
        ),

        // Truck icon on the right, opens Request Pickup (Screen 17)
        actions: [
          IconButton(
            tooltip: 'Request pickup',
            icon: const Icon(
              Icons.local_shipping_outlined,
              color: AppColors.iconColor,
            ),
            onPressed: _openRequest,
          ),
        ],
      ),

      body: SafeArea(
        child: Column(
          children: [
            // ---- The material this chat is about + Request button ----
            _buildListingBanner(),

            // ---- Messages list (takes all the space above the input bar) ----
            Expanded(
              child: ListView.builder(
                controller: _scroll,
                padding: const EdgeInsets.all(16),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return ChatBubble(
                    text: msg['text'] as String,
                    isMe: msg['isMe'] as bool,
                  );
                },
              ),
            ),

            // ---- Input bar at the bottom ----
            _buildInputBar(),
          ],
        ),
      ),
    );
  }

  // Small card under the top bar: photo, title, price and a Request button
  Widget _buildListingBanner() {
    final item = _listing;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.image,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  '${item.priceLabel} · ${item.distanceLabel}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: _openRequest,
            style: TextButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: AppColors.textColor,
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: const Text('Request', style: TextStyle(fontSize: 12)),
          ),
        ],
      ),
    );
  }

  // Row with: + button, text box, send button
  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: const BoxDecoration(
        color: AppColors.backgroundColor,
        border: Border(top: BorderSide(color: AppColors.borderColor)),
      ),
      child: Row(
        children: [
          // "+" for attachments (does nothing yet)
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppColors.iconColor,
            ),
            onPressed: () {},
          ),

          // Expanded: text box takes the remaining width
          Expanded(
            child: TextField(
              controller: _controller,
              // Pressing "enter" on the keyboard also sends
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: 'Type a message...',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppColors.borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: AppColors.textColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),

          // Round send button
          InkWell(
            onTap: _sendMessage,
            customBorder: const CircleBorder(),
            child: Container(
              height: 42,
              width: 42,
              decoration: const BoxDecoration(
                color: AppColors.textColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
