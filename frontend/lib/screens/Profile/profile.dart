import 'package:flutter/material.dart';
import 'package:event_tracker/theme/colors.dart';
import 'package:event_tracker/widgets/button.dart';
import 'package:event_tracker/components/ui_utils.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onSurface;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            vSpace(20),

            // 👤 Profile Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: theme.colorScheme.primary.withAlpha(40),
              child: Icon(
                Icons.person,
                size: 60,
                color: theme.colorScheme.primary,
              ),
            ),

            vSpace(16),

            // 🧑 Name
            Text(
              "John Doe",
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            vSpace(6),
            Text(
              "john.doe@example.com",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: textColor.withAlpha(180),
              ),
            ),

            vSpace(30),

            // 🧾 Profile Details
            _buildDetailTile(
              context,
              icon: Icons.phone,
              title: "Phone",
              value: "+91 9876543210",
            ),
            _buildDetailTile(
              context,
              icon: Icons.location_on_outlined,
              title: "Location",
              value: "Mumbai, India",
            ),
            _buildDetailTile(
              context,
              icon: Icons.calendar_today,
              title: "Joined",
              value: "Jan 2024",
            ),

            vSpace(30),

            // ✏️ Edit Profile
            SizedBox(
              width: double.infinity,
              child: elevatedButton(
                label: "Edit Profile",
                onPressed: () {
                  // TODO: Navigate to Edit Profile
                },
              ),
            ),

            vSpace(16),

            // 🚪 Logout Button
            SizedBox(
              width: double.infinity,
              child: outlinedButton(
                label: "Logout",
                onPressed: () {
                  // TODO: Handle logout
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailTile(
      BuildContext context, {
        required IconData icon,
        required String title,
        required String value,
      }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? kDarkColor : kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark ? Colors.white10 : Colors.black12,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          hSpace(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                Text(
                  value,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
