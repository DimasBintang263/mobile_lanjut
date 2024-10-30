// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadEmailFromDatabase();
  }

  // Fungsi untuk memuat email dari database
  Future<void> _loadEmailFromDatabase() async {
    String email = await fetchEmailFromDatabase();
    setState(() {
      _emailController.text = email;
    });
  }

  // Fungsi contoh untuk mengambil email dari database
  Future<String> fetchEmailFromDatabase() async {
    // Ganti dengan logika query database sebenarnya
    return 'example@example.com';
  }

  // Fungsi untuk menyimpan data ke database
  Future<void> _saveProfile() async {
    String name = _nameController.text;
    String phoneNumber = _phoneNumberController.text;
    String address = _addressController.text;

    // Simpan data ke database (ganti dengan logika simpan database Anda)
    await saveProfileToDatabase(name, phoneNumber, address);

    print('Data disimpan:');
    print('Nama: $name');
    print('Nomor Telepon: $phoneNumber');
    print('Alamat: $address');
  }

  // Fungsi contoh untuk menyimpan data ke database
  Future<void> saveProfileToDatabase(String name, String phoneNumber, String address) async {
    // Logika simpan ke database di sini
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 120),
              // Row untuk menampilkan foto profil dan informasi di bawahnya
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage('https://picsum.photos/200/300'), // Ganti dengan URL foto profil Anda
                  ),
                  const SizedBox(height: 10), // Jarak antara foto dan informasi
                  // Column untuk menampilkan nama dan asal universitas di bawah foto
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text('Nama Lengkap', style: TextStyle(fontSize: 18)),
                      Text('Asal Universitas', style: TextStyle(fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                ),
              ),
              TextField(
                controller: _phoneNumberController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Nomor Telepon',
                ),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(
                  labelText: 'Alamat',
                ),
              ),
              const SizedBox(height: 40), // Jarak antara field dan tombol
              Center( // Membungkus tombol dalam Center
                child: SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    onPressed: _saveProfile, // Panggil fungsi untuk menyimpan profil
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Ubah Profil',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
