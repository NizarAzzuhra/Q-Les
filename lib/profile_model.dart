import 'package:flutter/material.dart';

class ProfileModel extends ChangeNotifier {
  String _name = 'Student Demo';
  String _email = 'student@demo.com';
  String _role = 'Student';
  String? _photoUrl; // URL atau path foto profil

  // Simulasi tanggal terakhir perubahan email (untuk batasan 1x/bulan)
  DateTime? _lastEmailChangeDate;

  // Daftar kelas yang diikuti
  final List<Class> _joinedClasses = [];

  String get name => _name;
  String get email => _email;
  String get role => _role;
  String? get photoUrl => _photoUrl;
  DateTime? get lastEmailChangeDate => _lastEmailChangeDate;
  List<Class> get joinedClasses => [..._joinedClasses]; // Return copy

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _email = newEmail;
    _lastEmailChangeDate = DateTime.now(); // Set tanggal perubahan
    notifyListeners();
  }

  void updatePhoto(String? photoUrl) {
    _photoUrl = photoUrl;
    notifyListeners();
  }

  // Cek apakah boleh mengubah email (hanya sekali per bulan)
  bool canChangeEmail() {
    if (_lastEmailChangeDate == null) return true;
    final now = DateTime.now();
    final difference = now.difference(_lastEmailChangeDate!).inDays;
    return difference >= 30; // Bisa ganti jika sudah 30 hari
  }

  // Method untuk menambahkan kelas
  void joinClass(String className, String classCode) {
    final newClass = Class(
      name: className,
      code: classCode,
      questionCount: 0, // Default 0 soal
    );
    _joinedClasses.add(newClass);
    notifyListeners(); // Beri tahu widget bahwa daftar kelas telah diperbarui
  }

  // Method untuk menghapus kelas (opsional)
  void leaveClass(String classCode) {
    _joinedClasses.removeWhere((c) => c.code == classCode);
    notifyListeners();
  }

  // Reset model (opsional)
  void reset() {
    _name = 'Student Demo';
    _email = 'student@demo.com';
    _lastEmailChangeDate = null;
    _photoUrl = null;
    _joinedClasses.clear(); // Hapus semua kelas
    notifyListeners();
  }
}

// Model kelas sederhana
class Class {
  final String name;
  final String code;
  final int questionCount;

  Class({
    required this.name,
    required this.code,
    required this.questionCount,
  });
}