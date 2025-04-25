import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Gambar 1
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'assets/images/profile.jpg',
                  height: 120,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 24),

              // Tombol-tombol Menu
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _menuCard(Icons.group, 'Data Piket'),
                  _menuCard(Icons.people, 'Data Pelanggan'),
                  _menuCard(
                    Icons.inventory,
                    'Barang Masuk/Keluar',
                    isFullWidth: true,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // Background  header
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.deepOrange,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
            ),
          ),
          padding: const EdgeInsets.only(top: 50, left: 16, right: 16),
          child: SafeArea(child: SizedBox(height: 90)),
        ),
      ),
    );
  }

  Widget _menuCard(IconData icon, String title, {bool isFullWidth = false}) {
    return Container(
      width: isFullWidth ? double.infinity : null,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
