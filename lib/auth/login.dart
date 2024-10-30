import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailError; // Menyimpan pesan kesalahan email
  String? passwordError; // Menyimpan pesan kesalahan password
  String? errorMessage; // Menyimpan pesan kesalahan umum

  Future<void> loginUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    // Reset pesan kesalahan
    setState(() {
      emailError = null;
      passwordError = null;
      errorMessage = null;
    });

    // Validasi semua kolom harus diisi
    if (email.isEmpty) {
      setState(() {
        emailError = 'Email harus diisi';
      });
    } else if (!isValidEmail(email)) {
      setState(() {
        emailError = 'Email tidak valid. Silakan masukkan email yang benar.';
      });
    }

    if (password.isEmpty) {
      setState(() {
        passwordError = 'Password harus diisi';
      });
    }

    // Cek apakah ada kesalahan sebelum melanjutkan
    if (emailError == null && passwordError == null) {
      // Kirim data ke server
      final response = await http.post(
        Uri.parse('http://10.0.2.2/mobile_lanjut/login.php'), // Ganti dengan URL API Anda
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          // Login berhasil, navigasi ke halaman berikutnya
          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, '/home'); // Ganti '/home' dengan halaman yang sesuai
        } else {
          // Tampilkan pesan kesalahan jika login gagal
          setState(() {
            // Menentukan jenis kesalahan
            if (responseData['message'] == 'Email tidak terdaftar') {
              emailError = responseData['message'];
            } else if (responseData['message'] == 'Password salah') {
              passwordError = responseData['message'];
            } else {
              errorMessage = responseData['message'];
            }
          });
        }
      } else {
        // Tampilkan pesan kesalahan jika terjadi kesalahan server
        setState(() {
          errorMessage = 'Terjadi kesalahan, silakan coba lagi.';
        });
      }
    }
  }

  bool isValidEmail(String email) {
    // Fungsi untuk memvalidasi format email
    const String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: MediaQuery.of(context).size.width * 0.2,
                      height: MediaQuery.of(context).size.width * 0.2,
                    ),
                    const SizedBox(width: 8),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Responsi',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '2024',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Input Email
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukan Email',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    if (emailError != null) // Tampilkan pesan kesalahan email
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          emailError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                ]),
                const SizedBox(height: 20),

                // Input Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukan Password',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    if (passwordError != null) // Tampilkan pesan kesalahan password
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          passwordError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                ]),
                const SizedBox(height: 1),
                
                // Tampilkan pesan kesalahan umum jika ada
                if (errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Belum punya akun?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text('Daftar'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      loginUser(); // Panggil fungsi untuk login
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/password');
                  },
                  child: const Text('Lupa Password?'),
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
