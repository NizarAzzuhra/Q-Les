// lib/add_class_modal.dart

import 'package:flutter/material.dart';
import 'class_model.dart';

class AddClassModal extends StatefulWidget {
  final Function(ClassModel) onAddClass;

  const AddClassModal({super.key, required this.onAddClass});

  @override
  State<AddClassModal> createState() => _AddClassModalState();
}

class _AddClassModalState extends State<AddClassModal> {
  final TextEditingController _classNameController = TextEditingController();

  @override
  void dispose() {
    _classNameController.dispose();
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Add New Class',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),

          TextField(
            controller: _classNameController,
            decoration: InputDecoration(
              labelText: 'Enter class name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            autofocus: true,
          ),
          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_classNameController.text.isNotEmpty) {
                  final code = _generateRandomCode();
                  final newClass = ClassModel(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    name: _classNameController.text.trim(),
                    code: code,
                    questionCount: 0,
                  );
                  widget.onAddClass(newClass);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Class "${newClass.name}" created')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a class name')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  String _generateRandomCode() {
    final characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String result = '';
    for (int i = 0; i < 6; i++) {
      result += characters[DateTime.now().millisecondsSinceEpoch % characters.length];
    }
    return result;
  }
}