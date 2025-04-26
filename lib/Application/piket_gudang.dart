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

  void _tambahTugas() {
    if (_namaController.text.isNotEmpty && _tugasController.text.isNotEmpty) {
      setState(() {
        _daftarTugas.add({
          'nama': _namaController.text,
          'tanggal': 'Tanggal belum dipilih',
          'tugas': _tugasController.text,
        });
        _tugasController.clear();
      });
    }
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tugasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Piket Gudang',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Nama Anggota'),
              const SizedBox(height: 8),
              TextField(
                controller: _namaController,
                decoration: InputDecoration(
                  hintText: 'Admin',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
  }
}
