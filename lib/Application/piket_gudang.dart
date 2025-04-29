import 'package:flutter/material.dart';
import 'package:ucp_satu/Application/login_page.dart';

class AppColors {
  static const Color merahTua = Color(0xFF63100E);
  static const Color orens = Color(0xFFE9963E);
}

class PiketGudang extends StatefulWidget {
  const PiketGudang({super.key});

  @override
  State<PiketGudang> createState() => _PiketGudangState();
}

class _PiketGudangState extends State<PiketGudang> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _tanggalController = TextEditingController();

  final TextEditingController _tugasController = TextEditingController();
  final List<Map<String, String>> _daftarTugas = [];

  void _tambahTugas() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _daftarTugas.add({
          'nama': _namaController.text,
          'tanggal': _tanggalController.text,
          'tugas': _tugasController.text,
        });
        _tugasController.clear();
      });
    }
  }

  @override // Memanggil email
  void initState() {
    super.initState();
    _namaController.text = LoginPage.loggedInEmail;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _tanggalController.dispose();
    _tugasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orens,
      appBar: AppBar(
        backgroundColor: AppColors.merahTua,
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Nama Anggota'),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _namaController,
                  readOnly: true,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama anggota tidak boleh kosong';
                    }
                    return null;
                  },
                  onChanged: (_) {
                    if (_formKey.currentState != null) {
                      _formKey.currentState!.validate();
                    }
                  },
                ),
                const SizedBox(height: 20),
                buildLabel('Pilih Tanggal'),
                buildInputField(
                  _tanggalController,
                  readOnly: true,
                  prefixIcon: const Icon(Icons.calendar_today),
                  hintText: 'Pilih tanggal ',
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      _tanggalController.text =
                          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                    }
                  },
                  isTanggal: true,
                ),

                const SizedBox(height: 20),
                const Text('Tugas Piket'),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 56,
                        child: TextFormField(
                          controller: _tugasController,
                          style: const TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Tugas Piket',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tugas tidak boleh kosong';
                            }
                            return null;
                          },
                          onChanged: (_) {
                            if (_formKey.currentState != null) {
                              _formKey.currentState!.validate();
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _tambahTugas,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.merahTua,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: const Text(
                            'Tambah',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    'Daftar Tugas Piket',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 20),
                _daftarTugas.isEmpty
                    ? const Center(
                      child: Text(
                        'Belum ada Data',
                        style: TextStyle(fontSize: 16),
                      ),
                    )
                    : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _daftarTugas.length,
                      itemBuilder: (context, index) {
                        final tugas = _daftarTugas[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            color: AppColors.merahTua,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ListTile(
                            title: Text(
                              tugas['tugas'] ?? '',
                              style: const TextStyle(color: Colors.white),
                            ),

                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder:
                                      (context) => DetailPiket(
                                        nama: tugas['nama'] ?? '',
                                        tanggal: tugas['tanggal'] ?? '',
                                        tugas: tugas['tugas'] ?? '',
                                      ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Tambahin fungsi buildLabel
Widget buildLabel(String text) {
  return Text(
    text,
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  );
}

// Tambahin fungsi buildInputField
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
    readOnly: readOnly,
    style: const TextStyle(color: Colors.black),
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

// DETAIL PIKET
class DetailPiket extends StatelessWidget {
  final String nama;
  final String tanggal;
  final String tugas;

  const DetailPiket({
    super.key,
    required this.nama,
    required this.tanggal,
    required this.tugas,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.orens,
      appBar: AppBar(
        backgroundColor: AppColors.merahTua,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Detail $tugas',
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  tanggal,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.merahTua,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    nama,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.merahTua,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                tugas,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
