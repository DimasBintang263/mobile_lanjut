import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  String? emailError; // Menyimpan pesan kesalahan email
  String? passwordError; // Menyimpan pesan kesalahan password
  String? confirmPasswordError; // Menyimpan pesan kesalahan konfirmasi password

  bool isValidEmail(String email) {
    // Fungsi untuk memvalidasi format email
    const String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    final RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future<void> registerUser() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    // Reset pesan kesalahan
    setState(() {
      emailError = null;
      passwordError = null;
      confirmPasswordError = null;
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

    if (confirmPassword.isEmpty) {
      setState(() {
        confirmPasswordError = 'Konfirmasi password harus diisi';
      });
    } else if (password != confirmPassword) {
      setState(() {
        confirmPasswordError = 'Password tidak cocok';
      });
    }

    // Cek apakah ada kesalahan sebelum melanjutkan
    if (emailError == null && passwordError == null && confirmPasswordError == null) {
      // Kirim data ke server
      try {
        final response = await http.post(
          Uri.parse('http://10.0.2.2/mobile_lanjut/register.php'), // Ganti dengan URL API Anda
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          final responseData = json.decode(response.body);
          if (responseData['status'] == 'success') {
            // Pendaftaran berhasil, kembali ke halaman login
            // ignore: use_build_context_synchronously
            Navigator.pushNamed(context, '/login');
          } else {
            // Tampilkan pesan kesalahan jika pendaftaran gagal
            setState(() {
              emailError = responseData['message'] ?? 'Pendaftaran gagal. Silakan coba lagi.';
            });
          }
        } else {
          // Tampilkan pesan kesalahan jika pendaftaran gagal
          setState(() {
            emailError = 'Pendaftaran gagal. Silakan coba lagi.';
          });
        }
      } catch (e) {
        // Tangani error jaringan atau lainnya
        setState(() {
          emailError = 'Terjadi kesalahan: $e';
        });
      }
    }
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
                  'Daftar',
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
                    TextFormField(
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
                    TextFormField(
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
                const SizedBox(height: 20),

                // Input Konfirmasi Password
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Masukan Password (Konfirmasi)',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    TextFormField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Konfirmasi Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.blue),
                        ),
                      ),
                    ),
                    if (confirmPasswordError != null) // Tampilkan pesan kesalahan konfirmasi password
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          confirmPasswordError!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                ]),
                
                const SizedBox(height: 1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text('Sudah memiliki akun?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      child: const Text('Masuk'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Tombol Daftar
                SizedBox(
                  width: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      registerUser(); // Panggil fungsi untuk mendaftar
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
