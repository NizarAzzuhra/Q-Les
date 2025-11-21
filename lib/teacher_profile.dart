// lib/teacher_profile_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'profile_model.dart';
import 'edit_profile_teacher_screen.dart';

class TeacherProfileScreen extends StatelessWidget {
  const TeacherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileTeacherScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Profile Picture & Basic Info
              Center(
                child: Column(
                  children: [
                    // Avatar
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: profile.photoUrl != null
                          ? FileImage(File(profile.photoUrl!))
                          : null,
                      child: profile.photoUrl == null
                          ? Icon(
                              Icons.person_outline,
                              size: 60,
                              color: Colors.grey.shade600,
                            )
                          : null,
                    ),
                    const SizedBox(height: 16),

                    // Name
                    Text(
                      profile.name.isNotEmpty ? profile.name : 'Teacher Name',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Email
                    Text(
                      profile.email.isNotEmpty ? profile.email : 'teacher@demo.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Role Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade100,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.school_outlined,
                            size: 18,
                            color: Colors.blue.shade800,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            profile.role.isNotEmpty ? profile.role : 'Teacher',
                            style: TextStyle(
                              color: Colors.blue.shade800,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Edit Profile Button
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditProfileTeacherScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit_outlined),
                        label: const Text('Edit Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.blue,
                          side: const BorderSide(color: Colors.blue),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Stats Cards
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.menu_book_outlined,
                      label: 'Classes',
                      value: '5',
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.quiz_outlined,
                      label: 'Questions',
                      value: '48',
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.people_outline,
                      label: '',
                      value: '127',
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard(
                      icon: Icons.comment_outlined,
                      label: 'Comments',
                      value: '23',
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 32),

              // Account Information Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Account Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow(
                      icon: Icons.person_outline,
                      label: 'Full Name',
                      value: profile.name.isNotEmpty ? profile.name : 'Not set',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      icon: Icons.email_outlined,
                      label: 'Email Address',
                      value: profile.email.isNotEmpty ? profile.email : 'Not set',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      icon: Icons.badge_outlined,
                      label: 'Role',
                      value: profile.role.isNotEmpty ? profile.role : 'Teacher',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Member Since',
                      value: 'January 2024',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Actions
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Quick Actions',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _buildActionCard(
                context: context,
                icon: Icons.history,
                title: 'Activity History',
                subtitle: 'View your recent activities',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Activity History coming soon')),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildActionCard(
                context: context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help with the app',
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Help & Support coming soon')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, size: 32, color: color),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey.shade600),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(icon, color: Colors.blue),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}