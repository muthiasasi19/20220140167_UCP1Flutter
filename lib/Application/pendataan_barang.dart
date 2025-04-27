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
}
