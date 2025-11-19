import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io'; // Untuk FileImage
import 'profile_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController; // Tambahkan controller untuk email
  String _selectedRole = 'Student'; // Default role

  // State untuk foto
  String? _selectedPhotoPath; // Path lokal foto yang dipilih

  @override
  void initState() {
    super.initState();
    // Ambil data profil saat halaman dibuka
    final profile = Provider.of<ProfileModel>(context, listen: false);
    _nameController = TextEditingController(text: profile.name);
    _emailController = TextEditingController(text: profile.email); // Inisialisasi email
    _selectedRole = profile.role; // Jika role bisa diubah di masa mendatang
    _selectedPhotoPath = profile.photoUrl; // Foto sebelumnya
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose(); // Dispose controller email
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
    final profile = Provider.of<ProfileModel>(context); // Listen to changes for email/role if needed

    // Hitung kapan bisa ganti email lagi
    String emailChangeMessage = 'Email cannot be changed';
    if (profile.canChangeEmail()) {
      emailChangeMessage = '';
    } else if (profile.lastEmailChangeDate != null) {
      final nextChangeDate = profile.lastEmailChangeDate!.add(const Duration(days: 30));
      emailChangeMessage = 'You can change email again on ${nextChangeDate.day}/${nextChangeDate.month}/${nextChangeDate.year}';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
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
                          ? FileImage(
                              File(_selectedPhotoPath!), // Pastikan path valid
                            )
                          : null,
                      child: _selectedPhotoPath == null
                          ? const Icon(Icons.person_outline, size: 40, color: Colors.grey)
                          : null,
                    ),
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: Colors.blue,
                        child: const Icon(Icons.camera_alt, size: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Tap camera icon to change photo',
                  style: TextStyle(color: Colors.grey),
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
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Email Field (Editable only if allowed)
              const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                enabled: profile.canChangeEmail(), // Hanya bisa edit jika boleh
                decoration: InputDecoration(
                  filled: true,
                  fillColor: profile.canChangeEmail() ? Colors.white : Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.blue, width: 2),
                  ),
                  hintText: profile.email,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                emailChangeMessage,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 16),

              // Role (Read-only button)
              const Text(
                'Role',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: null, // Tidak bisa diubah
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade100,
                  foregroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(_selectedRole), // Gunakan role dari state/model
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

                    // Update email jika boleh
                    if (profile.canChangeEmail() && _emailController.text.isNotEmpty) {
                      Provider.of<ProfileModel>(context, listen: false)
                          .updateEmail(_emailController.text);
                    }

                    // Update foto jika ada
                    if (_selectedPhotoPath != null) {
                      Provider.of<ProfileModel>(context, listen: false)
                          .updatePhoto(_selectedPhotoPath);
                    }

                    // Tampilkan snackbar sukses
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile updated successfully!')),
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