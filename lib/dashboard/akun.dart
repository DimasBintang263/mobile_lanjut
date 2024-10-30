import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Mengatur agar konten berada di tengah
          children: [
            const SizedBox(height: 10), // Ruang atas
            // Center widget untuk menempatkan foto profil di tengah
            const Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage('https://picsum.photos/200/300'), // Ganti dengan URL foto profil Anda
              ),
            ),
            const SizedBox(height: 20), // Jarak antara foto dan informasi
            const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Nama Lengkap', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('Asal Universitas', style: TextStyle(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 20), // Jarak antara informasi dan daftar
            ListTile(
              title: const Text('Kelola Akun'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/profil');
                // Navigasi ke halaman kelola akun
              },
            ),
            ListTile(
              title: const Text('Notifikasi'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman notifikasi
              },
            ),
            ListTile(
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman privacy policy
              },
            ),
            ListTile(
              title: const Text('Terms of Service'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navigasi ke halaman terms of service
              },
            ),
          ],
        ),
      ),
    );
  }
}
