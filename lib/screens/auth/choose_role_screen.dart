import 'package:flutter/material.dart';
import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/core/app_session.dart';
import 'package:trash2treasure/screens/auth/location_picker_screen.dart';

class ChooseRoleScreen extends StatefulWidget {
  const ChooseRoleScreen({super.key});
  @override
  State<ChooseRoleScreen> createState() => _ChooseRoleScreenState();
}

class _ChooseRoleScreenState extends State<ChooseRoleScreen> {
  String _selected = "seller";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(Icons.arrow_back,
                            size: 20, color: Colors.black87),
                      ),
                      const SizedBox(width: 12),
                      const Text("Choose Your Role",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text("Select how you want to use\nTrash2Treasure.",
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFF8A8A8A), height: 1.4)),
                  const SizedBox(height: 18),
                  _buildRoleBox(
                      title: "Seller",
                      subtitle: "Sell scrap",
                      icon: Icons.recycling_outlined,
                      value: "seller"),
                  const SizedBox(height: 10),
                  _buildRoleBox(
                      title: "Buyer",
                      subtitle: "Buy materials",
                      icon: Icons.shopping_bag_outlined,
                      value: "buyer"),
                  const SizedBox(height: 10),
                  _buildRoleBox(
                      title: "Both",
                      subtitle: "Buy and sell scrap",
                      icon: Icons.swap_horiz_outlined,
                      value: "both"),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 46,
                    child: ElevatedButton(
                      onPressed: () {
                        AppSession.role = AppSession.roleFromString(_selected);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LocationPickerScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1F7A3A),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                      ),
                      child: const Text("Continue",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        AppSession.role = AppSession.roleFromString(_selected);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const LocationPickerScreen()));
                      },
                      child: const Text("Skip for now",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color(0xFF9E9E9E),
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleBox(
      {required String title,
      required String subtitle,
      required IconData icon,
      required String value}) {
    bool isSelected = _selected == value;
    return GestureDetector(
      onTap: () => setState(() => _selected = value),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F8F2) : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: isSelected
                  ? const Color(0xFF1F7A3A)
                  : const Color(0xFFEAEAEA),
              width: isSelected ? 1.5 : 1),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1F7A3A) : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(icon,
                  color: isSelected ? Colors.white : const Color(0xFF1F7A3A),
                  size: 22),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isSelected
                            ? const Color(0xFF1F7A3A)
                            : Colors.black)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: const TextStyle(
                        fontSize: 11, color: Color(0xFF8A8A8A))),
              ],
            ),
            const Spacer(),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: Color(0xFF1F7A3A), size: 20),
          ],
        ),
      ),
    );
  }
}
