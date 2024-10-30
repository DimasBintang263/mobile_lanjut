import 'package:flutter/material.dart';
import 'package:tugas_apikasi/auth/login.dart';
import 'package:tugas_apikasi/dashboard/profil.dart';
import 'akun.dart'; // Impor halaman akun

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Menyimpan indeks menu yang dipilih

  // Daftar halaman yang akan ditampilkan
  final List<Widget> _pages = [
    // Halaman Home
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        const Text(
          'Guest',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const Text(
          'Widget GridView ->',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 200, // Set a fixed height for the horizontal GridView
          child: GridView.builder(
            scrollDirection: Axis.horizontal, // Enable horizontal scrolling
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Only one item per row
              mainAxisSpacing: 8, // Space between items
              crossAxisSpacing: 8, // Space between items
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return const Card(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.square),
                    Icon(Icons.circle),
                    Text('Artist'),
                    Text('Song'),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Widget ListView ->',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // Membuat ListView di dalam SingleChildScrollView
        SizedBox(
          height: 300, // Set a fixed height for the ListView
          child: ListView.builder(
            itemCount: 9,
            itemBuilder: (context, index) {
              return const Card(
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.square),
                      Icon(Icons.circle),
                    ],
                  ),
                  title: Text('Headline'),
                  subtitle: Text(
                    'Description duis aute irure dolor in reprehenderit in volup...',
                  ),
                  trailing: Text('+ Today · 23 min'),
                ),
              );
            },
          ),
        ),
      ],
    ),
    // Halaman Akun
    const AccountPage(), // Menggunakan halaman akun yang diimpor
    // Halaman Logout
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 2) {
        _logout(); // Panggil fungsi logout jika item yang dipilih adalah Logout
      } else {
        _selectedIndex = index; // Mengubah indeks yang dipilih
      }
    });
  }

  void _logout() {
    // Tambahkan logika untuk menghapus token autentikasi jika diperlukan
    // Misalnya: await AuthService.logout();
    
    // Kembali ke halaman login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Ganti dengan halaman login Anda
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0), // Padding di kiri dan kanan
        child: _pages[_selectedIndex], // Menampilkan halaman yang sesuai
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Akun',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
        currentIndex: _selectedIndex, // Menampilkan menu yang dipilih
        onTap: _onItemTapped, // Mengatur fungsi saat menu dipilih
      ),
    );
  }
}
