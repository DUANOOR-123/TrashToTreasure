/// Which side(s) of the app the user chose on the "Choose Role" screen.
enum UserRole { buyer, seller, both }

/// Who is using the app right now (kept in memory only).
///
/// Every screen reads this one place, so the whole app agrees on:
///  - is this a guest? (guests can only browse)
///  - can this user sell?
///
/// BACKEND LATER: fill these values from your login response
/// (Firebase user + user document) instead of setting them by hand.
class AppSession {
  AppSession._();

  static UserRole role = UserRole.both;
  static bool isGuest = false;
  static String? authToken;

  /// Shown on greetings / profile when you connect real accounts.
  static String userName = 'Ayesha Khan';

  /// True when the user may open the seller side.
  static bool get canSell =>
      !isGuest && (role == UserRole.seller || role == UserRole.both);

  /// True for users who ONLY sell. Their Home tab is the Seller Home.
  static bool get isSellerOnly => !isGuest && role == UserRole.seller;

  /// Logged in normally (after Login, or after the onboarding steps).
  static void signIn() {
    isGuest = false;
  }

  /// "Continue as Guest": browse only, no posting / requesting / chatting.
  static void startGuest() {
    isGuest = true;
    role = UserRole.buyer;
    authToken = null;
  }

  /// Log out: forget everything.
  static void reset() {
    isGuest = false;
    role = UserRole.both;
    authToken = null;
  }

  /// Turns the text value from the Choose Role screen into a [UserRole].
  static UserRole roleFromString(String value) {
    switch (value) {
      case 'buyer':
        return UserRole.buyer;
      case 'seller':
        return UserRole.seller;
      default:
        return UserRole.both;
    }
  }
}
