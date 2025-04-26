import 'package:flutter/material.dart';

class PiketGudang extends StatefulWidget {
  const PiketGudang({super.key});

  @override
  State<PiketGudang> createState() => _PiketGudangState();
}

class _PiketGudangState extends State<PiketGudang> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tugasController = TextEditingController();
  DateTime? _selectedDate;
  final List<Map<String, String>> _daftarTugas = [];

  // Fungsi pilih tanggal DINONAKTIFKAN
  Future<void> _pickDate() async {
    // Dikosongkan dulu
  }
}
