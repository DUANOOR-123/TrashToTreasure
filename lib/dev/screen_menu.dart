import 'package:flutter/material.dart';

import 'package:trash2treasure/core/app_colors.dart';
import 'package:trash2treasure/screens/auth/splash_screen.dart';
import 'package:trash2treasure/screens/auth/welcome_screen.dart';
import 'package:trash2treasure/screens/auth/login_screen.dart';
import 'package:trash2treasure/screens/auth/signup_screen.dart';
import 'package:trash2treasure/screens/auth/forgot_password_screen.dart';
import 'package:trash2treasure/screens/auth/choose_role_screen.dart';
import 'package:trash2treasure/screens/auth/location_picker_screen.dart';
import 'package:trash2treasure/screens/auth/submit_id_screen.dart';
import 'package:trash2treasure/screens/auth/verification_status_screen.dart';
import 'package:trash2treasure/screens/auth/verification_result_screen.dart';
import 'package:trash2treasure/screens/buyer/buyer_shell.dart';
import 'package:trash2treasure/screens/buyer/categories_screen.dart';
import 'package:trash2treasure/screens/buyer/search_filters_screen.dart';
import 'package:trash2treasure/screens/buyer/map_view_screen.dart';
import 'package:trash2treasure/screens/buyer/listing_details_screen.dart';
import 'package:trash2treasure/screens/buyer/contact_seller_screen.dart';
import 'package:trash2treasure/screens/buyer/request_pickup_screen.dart';
import 'package:trash2treasure/screens/buyer/order_status_screen.dart';
import 'package:trash2treasure/screens/buyer/my_requests_screen.dart';
import 'package:trash2treasure/screens/seller/seller_home_screen.dart';
import 'package:trash2treasure/screens/seller/add_listing_screen.dart';
import 'package:trash2treasure/screens/seller/my_listings_screen.dart';
import 'package:trash2treasure/screens/seller/incoming_requests_screen.dart';
import 'package:trash2treasure/screens/seller/customers_list_screen.dart';
import 'package:trash2treasure/screens/seller/transaction_history_screen.dart';
import 'package:trash2treasure/screens/shared/messages_screen.dart';
import 'package:trash2treasure/screens/shared/profile_screen.dart';
import 'package:trash2treasure/screens/shared/settings_screen.dart';
import 'package:trash2treasure/screens/shared/location_filter_screen.dart';
import 'package:trash2treasure/screens/shared/notifications_screen.dart';
import 'package:trash2treasure/screens/shared/saved_items_screen.dart';
import 'package:trash2treasure/screens/shared/report_screen.dart';
import 'package:trash2treasure/screens/admin/admin_login_screen.dart';
import 'package:trash2treasure/screens/admin/admin_dashboard_screen.dart';
import 'package:trash2treasure/screens/admin/verification_queue_screen.dart';
import 'package:trash2treasure/screens/admin/reports_screen.dart';
import 'package:trash2treasure/screens/admin/user_management_screen.dart';

/// Developer shortcut: a list of EVERY screen, to open one by itself.
/// Not part of the real app. To use it, set `kShowScreenMenu = true`
/// in main.dart.
class ScreenMenu extends StatelessWidget {
  const ScreenMenu({super.key});

  void _open(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Trash2Treasure - All Screens',
          style: TextStyle(
            color: AppColors.textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const _Header('Onboarding & login'),
          _MenuButton(title: 'Splash', onTap: () => _open(context, const SplashScreen())),
          _MenuButton(title: 'Welcome', onTap: () => _open(context, const WelcomeScreen())),
          _MenuButton(title: 'Login', onTap: () => _open(context, const LoginScreen())),
          _MenuButton(title: 'Sign Up', onTap: () => _open(context, const SignupScreen())),
          _MenuButton(title: 'Forgot Password', onTap: () => _open(context, const ForgotPasswordScreen())),
          _MenuButton(title: 'Choose Role', onTap: () => _open(context, const ChooseRoleScreen())),
          _MenuButton(title: 'Location Picker', onTap: () => _open(context, const LocationPickerScreen())),
          _MenuButton(title: 'Submit ID', onTap: () => _open(context, const SubmitIdScreen())),
          _MenuButton(title: 'Verification Pending', onTap: () => _open(context, const VerificationStatusScreen())),
          _MenuButton(title: 'Verification Rejected', onTap: () => _open(context, const VerificationResultScreen())),
          const _Header('Main app (buyer)'),
          _MenuButton(title: 'Full app with bottom bar', onTap: () => _open(context, const BuyerShell())),
          _MenuButton(title: 'Categories', onTap: () => _open(context, const CategoriesScreen())),
          _MenuButton(title: 'Search & Filters', onTap: () => _open(context, const SearchFiltersScreen())),
          _MenuButton(title: 'Map View', onTap: () => _open(context, const MapViewScreen())),
          _MenuButton(title: 'Listing Details', onTap: () => _open(context, const ListingDetailsScreen())),
          _MenuButton(title: 'Contact Seller (chat)', onTap: () => _open(context, const ContactSellerScreen())),
          _MenuButton(title: 'Request Pickup', onTap: () => _open(context, const RequestPickupScreen())),
          _MenuButton(title: 'Order Status', onTap: () => _open(context, const OrderStatusScreen())),
          _MenuButton(title: 'My Requests', onTap: () => _open(context, const MyRequestsScreen())),
          const _Header('Seller'),
          _MenuButton(title: 'Seller Home', onTap: () => _open(context, const SellerHomeScreen())),
          _MenuButton(title: 'Add Listing', onTap: () => _open(context, const AddListingScreen())),
          _MenuButton(title: 'My Listings', onTap: () => _open(context, const MyListingsScreen())),
          _MenuButton(title: 'Incoming Requests', onTap: () => _open(context, const IncomingRequestsScreen())),
          _MenuButton(title: 'Customers List', onTap: () => _open(context, const CustomersListScreen())),
          _MenuButton(title: 'Transaction History', onTap: () => _open(context, const TransactionHistoryScreen())),
          const _Header('Shared'),
          _MenuButton(title: 'Messages', onTap: () => _open(context, const MessagesScreen())),
          _MenuButton(title: 'Profile', onTap: () => _open(context, const ProfileScreen())),
          _MenuButton(title: 'Settings', onTap: () => _open(context, const SettingsScreen())),
          _MenuButton(title: 'Location Filter', onTap: () => _open(context, const LocationFilterScreen())),
          _MenuButton(title: 'Notifications', onTap: () => _open(context, const NotificationsScreen())),
          _MenuButton(title: 'Saved Items', onTap: () => _open(context, const SavedItemsScreen())),
          _MenuButton(title: 'Report', onTap: () => _open(context, const ReportScreen())),
          const _Header('Admin'),
          _MenuButton(title: 'Admin Login', onTap: () => _open(context, const AdminLoginScreen())),
          _MenuButton(title: 'Admin Dashboard', onTap: () => _open(context, const AdminDashboardScreen())),
          _MenuButton(title: 'Verification Queue', onTap: () => _open(context, const VerificationQueueScreen())),
          _MenuButton(title: 'Reports', onTap: () => _open(context, const ReportsScreen())),
          _MenuButton(title: 'User Management', onTap: () => _open(context, const UserManagementScreen())),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String text;

  const _Header(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 8),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.textColor,
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _MenuButton({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: AppColors.backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.borderColor),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: AppColors.textColor,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: AppColors.textColor,
        ),
        onTap: onTap,
      ),
    );
  }
}
