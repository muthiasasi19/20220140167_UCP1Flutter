import 'package:flutter/material.dart';

class DataPelanggan extends StatefulWidget {
  const DataPelanggan({super.key});

  @override
  State<DataPelanggan> createState() => _DataPelangganState();
}

class _DataPelangganState extends State<DataPelanggan> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController noTeleponController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController provinsiController = TextEditingController();
  final TextEditingController kodePosController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> daftarPelanggan = [];

  @override
  void dispose() {
    namaController.dispose();
    emailController.dispose();
    noTeleponController.dispose();
    alamatController.dispose();
    provinsiController.dispose();
    kodePosController.dispose();
    super.dispose();
  }

  void tambahPelanggan() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        daftarPelanggan.add({
          'nama': namaController.text,
          'email': emailController.text,
          'noTelepon': noTeleponController.text,
          'alamat': alamatController.text,
          'provinsi': provinsiController.text,
          'kodePos': kodePosController.text,
        });
        namaController.clear();
        emailController.clear();
        noTeleponController.clear();
        alamatController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pelanggan berhasil ditambahkan')),
      );
    }
  }
}
