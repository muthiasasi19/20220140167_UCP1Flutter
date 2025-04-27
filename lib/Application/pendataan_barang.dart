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

  String formatTanggal(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year}';
  }

  String formatRupiah(int value) {
    String result = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $result';
  }

  @override
  void dispose() {
    jumlahBarangController.dispose();
    hargaSatuanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pendataan Barang'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isSubmitted ? buildStruk() : buildForm(),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Tanggal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 6),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Tanggal',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      prefixIcon: Icon(Icons.calendar_today),
                    ),

                    controller: TextEditingController(
                      text:
                          selectedDate != null
                              ? formatTanggal(selectedDate!)
                              : '',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Pilih tanggal';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          const Text(
            'Jenis Transaksi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              hintText: 'Jenis Transaksi',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            value: selectedJenisTransaksi,
            items:
                jenisTransaksiList.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                selectedJenisTransaksi = value;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pilih jenis transaksi';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          const Text(
            'Jenis Barang',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              hintText: 'Jenis Barang',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            value: selectedJenisBarang,
            items:
                barangDenganHarga.keys.map((value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
            onChanged: (value) {
              setState(() {
                selectedJenisBarang = value;
                hargaSatuanController.text =
                    barangDenganHarga[value!]!.toString();
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Pilih jenis barang';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Jumlah Barang',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: jumlahBarangController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Jumlah Barang',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukkan jumlah barang';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Harga Satuan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: hargaSatuanController,
                      readOnly: true,
                      decoration: const InputDecoration(
                        hintText: 'Harga Satuan',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: _submitForm,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Simpan', style: TextStyle(fontSize: 18)),
          ),
        ],
      ),
    );
  }

  Widget buildStruk() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Spacer(),
        const Center(
          child: Icon(Icons.check_circle, size: 100, color: Colors.green),
        ),
        const SizedBox(height: 16),
        const Center(
          child: Text(
            'Data Berhasil Disimpan!',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 24),
        buildRow('Tanggal', formatTanggal(selectedDate!)),
        buildRow('Jenis Transaksi', selectedJenisTransaksi!),
        buildRow('Jenis Barang', selectedJenisBarang!),
        buildRow('Jumlah Barang', jumlahBarangController.text),
        buildRow(
          'Harga Satuan',
          formatRupiah(int.parse(hargaSatuanController.text)),
        ),
        buildRow('Total Harga', formatRupiah(hitungTotalHarga())),
        const Spacer(),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text('Selesai', style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  Widget buildRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(value),
            ],
          ),
        ),
        const Divider(thickness: 1, color: Colors.grey),
      ],
    );
  }
}
