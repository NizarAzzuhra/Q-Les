import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import provider untuk reset profil
import 'edit_profile_screen.dart'; // Untuk navigasi ke Edit Profile
import 'profile_model.dart'; // Import model untuk reset profil (jika diperlukan)
import 'main.dart'; // Import main.dart untuk LoginScreen

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          // SECTION: ACCOUNT
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ACCOUNT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.blueAccent,
              child: Icon(Icons.person_outline, color: Colors.white),
            ),
            title: const Text('Edit Profile'),
            subtitle: const Text('Update your personal information'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),

          // SECTION: ABOUT
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ABOUT',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.grey,
              child: Icon(Icons.info_outline, color: Colors.white),
            ),
            title: const Text('App Version'),
            subtitle: const Text('1.0.0'),
          ),

          // SECTION: ACTIONS
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'ACTIONS',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ),
          ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red[50],
              ),
              child: const Icon(Icons.logout, color: Colors.red),
            ),
            title: Text(
              'Logout',
              style: const TextStyle(color: Colors.red),
            ),
            onTap: () {
              // Tampilkan pesan logout
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('You have been logged out')),
              );

              // Reset profil ke nilai default (opsional)
              Provider.of<ProfileModel>(context, listen: false).reset();

              // Kembalikan ke LoginScreen dan hapus semua history sebelumnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
                (route) => false, // Ini akan menghapus semua route sebelumnya
              );
            },
          ),
        ],
      ),
    );
  }
}