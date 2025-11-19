import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_model.dart';

class JoinClassModal extends StatefulWidget {
  const JoinClassModal({super.key});

  @override
  State<JoinClassModal> createState() => _JoinClassModalState();
}

class _JoinClassModalState extends State<JoinClassModal> {
  final TextEditingController _classCodeController = TextEditingController();

  @override
  void dispose() {
    _classCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Judul Modal
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Join Class',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context); // Tutup modal
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          
          // Input Field
          TextField(
            controller: _classCodeController,
            decoration: InputDecoration(
              labelText: 'Enter class code',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // Tombol Join
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_classCodeController.text.isNotEmpty) {
                  // Simulasikan nama kelas dari kode (misal: Class ABC123)
                  final className = 'Class ${_classCodeController.text}';
                  
                  // Tambahkan kelas ke model
                  Provider.of<ProfileModel>(context, listen: false)
                      .joinClass(className, _classCodeController.text);

                  // Tutup modal
                  Navigator.pop(context);

                  // Tampilkan snackbar sukses
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Joined class: $className')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a class code')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Join',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}