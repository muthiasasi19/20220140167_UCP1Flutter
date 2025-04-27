import 'package:flutter/material.dart';
import 'package:ucp_satu/Application/home_page.dart';

class PendataanBarangPage extends StatefulWidget {
  const PendataanBarangPage({super.key});

  @override
  State<PendataanBarangPage> createState() => _PendataanBarangPageState();
}

class _PendataanBarangPageState extends State<PendataanBarangPage> {
  final _formKey = GlobalKey<FormState>();

  DateTime? selectedDate;
  String? selectedJenisTransaksi;
  String? selectedJenisBarang;
  final TextEditingController jumlahBarangController = TextEditingController();
  final TextEditingController hargaSatuanController = TextEditingController();

  bool isSubmitted = false;

  final List<String> jenisTransaksiList = ['Barang Masuk', 'Barang Keluar'];
  final Map<String, int> barangDenganHarga = {
    'Carier': 540000,
    'Sleeping Bag': 250000,
    'Tenda': 70000,
    'Sepatu': 350000,
  };

  void _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  int hitungTotalHarga() {
    int jumlah = int.tryParse(jumlahBarangController.text) ?? 0;
    int harga = int.tryParse(hargaSatuanController.text) ?? 0;
    return jumlah * harga;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitted = true;
      });
    }
  }

  // void _resetForm() {
  //   _formKey.currentState!.reset();
  //   setState(() {
  //     selectedDate = null;
  //     selectedJenisTransaksi = null;
  //     selectedJenisBarang = null;
  //     isSubmitted = false;
  //   });
  //   jumlahBarangController.clear();
  //   hargaSatuanController.clear();
  // }
}
