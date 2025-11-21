// lib/edit_profile_teacher_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'profile_model.dart';

class EditProfileTeacherScreen extends StatefulWidget {
  const EditProfileTeacherScreen({super.key});

  @override
  State<EditProfileTeacherScreen> createState() => _EditProfileTeacherScreenState();
}

class _EditProfileTeacherScreenState extends State<EditProfileTeacherScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;

  // State untuk foto
  String? _selectedPhotoPath;

  @override
  void initState() {
    super.initState();
    // Ambil data profil saat halaman dibuka
    final profile = Provider.of<ProfileModel>(context, listen: false);
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email);
    _selectedPhotoPath = profile.photoUrl;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedPhotoPath = result.files.single.path!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<ProfileModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar + Camera Icon
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey.shade200,
                      backgroundImage: _selectedPhotoPath != null
                          ? FileImage(File(_selectedPhotoPath!))
                          : null,
                      child: _selectedPhotoPath == null
                          ? Icon(
                              Icons.person_outline,
                              size: 50,
                              color: Colors.grey.shade600,
                            )
                          : null,
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.blue,
                        child: const Icon(
                          Icons.camera_alt,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  'Tap camera icon to change photo',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Name Field
              const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Email Field (Read-only for teachers)
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Email cannot be changed',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),

              // Role (Read-only)
              const Text(
                'Role',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  profile.role,
                  style: TextStyle(
                    color: Colors.blue.shade800,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_nameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Name cannot be empty')),
                      );
                      return;
                    }

                    // Update nama
                    Provider.of<ProfileModel>(context, listen: false)
                        .updateName(_nameController.text);

                    // Update foto jika ada
                    if (_selectedPhotoPath != null) {
                      Provider.of<ProfileModel>(context, listen: false)
                          .updatePhoto(_selectedPhotoPath);
                    }

                    // Tampilkan snackbar sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Profile updated: ${_nameController.text}'),
                      ),
                    );

                    // Kembali ke halaman sebelumnya
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}