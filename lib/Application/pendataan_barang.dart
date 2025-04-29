import 'package:flutter/material.dart';
import 'package:ucp_satu/Application/home_page.dart';

class AppColors {
  static const Color merahTua = Color(0xFF63100E);
  static const Color orens = Color(0xFFE9963E);
}

class PendataanBarangPage extends StatefulWidget {
  const PendataanBarangPage({super.key});

  @override
  State<PendataanBarangPage> createState() => _PendataanBarangPageState();
}

class _PendataanBarangPageState extends State<PendataanBarangPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController tanggalController = TextEditingController();
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

  String formatRupiah(int value) {
    String result = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $result';
  }

  String formatTanggal(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  void dispose() {
    tanggalController.dispose();
    jumlahBarangController.dispose();
    hargaSatuanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isSubmitted ? Colors.white : AppColors.orens,
      appBar: AppBar(
        title: const Text(
          'Pendataan Barang',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.merahTua,
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
          buildLabel('Pilih Tanggal'),
          buildInputField(
            tanggalController,
            readOnly: true,
            prefixIcon: const Icon(Icons.calendar_today),
            hintText: 'Pilih tanggal',
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (pickedDate != null) {
                setState(() {
                  selectedDate = pickedDate;
                  tanggalController.text = formatTanggal(pickedDate);
                });
              }
            },
            isTanggal: true,
          ),
          const SizedBox(height: 16),

          const Text(
            'Jenis Transaksi',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
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
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              filled: true,
              fillColor: Colors.white,
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
                      style: const TextStyle(color: Colors.black),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
                      style: const TextStyle(color: Colors.black),
                      readOnly: true,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
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
              backgroundColor: AppColors.merahTua,
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text(
              'Simpan',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
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

        const SizedBox(height: 30),

        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.merahTua,
            minimumSize: const Size.fromHeight(50),
          ),
          child: const Text(
            'Selesai',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
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

Widget buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  );
}

Widget buildInputField(
  TextEditingController controller, {
  bool readOnly = false,
  Widget? prefixIcon,
  String? hintText,
  VoidCallback? onTap,
  bool isTanggal = false,
}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: Colors.black),
    readOnly: readOnly,
    decoration: InputDecoration(
      filled: true,
      fillColor: Colors.white,
      hintText: hintText,
      prefixIcon: prefixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return isTanggal
            ? 'Tanggal tidak boleh kosong'
            : 'Field tidak boleh kosong';
      }
      return null;
    },
    onTap: onTap,
  );
}
