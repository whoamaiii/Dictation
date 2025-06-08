import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'api_key_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          // API Key Section
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 8),
            child: Text(
              'API Key',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildSettingsTile(
            context: context,
            icon: Iconsax.key,
            title: 'API Key',
            subtitle: 'Manage your Gemini API key',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ApiKeyScreen()),
              );
            },
          ),
          
          // Data Section
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              'Data',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildSettingsTile(
            context: context,
            icon: Iconsax.document_copy,
            title: 'Data',
            subtitle: 'Manage your data',
            onTap: () {
              // TODO: Implement data management
            },
          ),
          
          // Language Section
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              'Language',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildSettingsTile(
            context: context,
            icon: Iconsax.global,
            title: 'Language',
            subtitle: 'Set the language for transcription',
            onTap: () {
              // TODO: Implement language settings
            },
          ),
          
          // Theme Section
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              'Theme',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildSettingsTile(
            context: context,
            icon: Iconsax.paintbucket,
            title: 'Theme',
            subtitle: 'Customize the app\'s appearance',
            onTap: () {
              // TODO: Implement theme settings
            },
          ),
          
          // About Section
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              'About',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _buildSettingsTile(
            context: context,
            icon: Iconsax.info_circle,
            title: 'Version',
            subtitle: 'Version 1.0.0',
            onTap: null,
          ),
          _buildSettingsTile(
            context: context,
            icon: Iconsax.shield_tick,
            title: 'Privacy Policy',
            subtitle: null,
            onTap: () {
              // TODO: Open privacy policy
            },
          ),
          _buildSettingsTile(
            context: context,
            icon: Iconsax.document_text,
            title: 'Terms of Service',
            subtitle: null,
            onTap: () {
              // TODO: Open terms of service
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFF3A3A3A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )
            : null,
        trailing: onTap != null
            ? const Icon(
                Icons.chevron_right,
                color: Colors.grey,
              )
            : null,
        onTap: onTap,
      ),
    );
  }
} 