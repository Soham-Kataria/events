import 'package:flutter/material.dart';
import '../../dummy/dummy_data.dart';

class ProfileController with ChangeNotifier {
  /// Load data from dummy file
  String _name = dummyUser["name"]!;
  String _email = dummyUser["email"]!;
  String _phone = dummyUser["phone"]!;
  String _location = dummyUser["location"]!;
  String _joinedDate = dummyUser["joinedDate"]!;

  // Getters
  String get name => _name;
  String get email => _email;
  String get phone => _phone;
  String get location => _location;
  String get joinedDate => _joinedDate;

  /// Update profile fields (for future edit feature)
  void updateProfile({
    String? name,
    String? email,
    String? phone,
    String? location,
  }) {
    if (name != null) _name = name;
    if (email != null) _email = email;
    if (phone != null) _phone = phone;
    if (location != null) _location = location;

    notifyListeners();
  }

  /// Logout logic (can be expanded later)
  Future<void> logout(BuildContext context) async {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
