import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:onvocation/custom/appcolor.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _register(BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'name': nameController.text,
        'email': emailController.text,
      });

      // Berhasil mendaftar, lanjutkan ke layar lain atau tindakan lainnya
      // misalnya menampilkan pesan sukses atau mengarahkan ke beranda.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('Kata sandi terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        print('Email sudah digunakan.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(102, 218, 255, 1.0),
      appBar: AppBar(
        backgroundColor: Colors
            .transparent, // Mengatur latar belakang AppBar menjadi transparan
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(0.0),
        child: Column(
          children: [
            Container(
                child: Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/onvocation-81249.appspot.com/o/Group%201744.png?alt=media&token=95198e97-b7e5-49ab-8004-61d877a6c31b&_gl=1*ukaioh*_ga*NTYyMDIyOTE4LjE2ODQxNzY3MzU.*_ga_CW55HF8NVT*MTY4NTUzOTE2Mi4xOS4xLjE2ODU1NDAwMzAuMC4wLjA.')),
            SizedBox(height: 16.0),
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(35),
                  topLeft: Radius.circular(35),
                ),
                child: Container(
                  color: AppColor.whiteColor,
                  child: Column(
                    children: [
                      Container(),
                      SizedBox(height: 16.0),
                      Container(
                        width: 230,
                        height: 45,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.whiteColor,
                            labelText: 'Name',
                            labelStyle: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                            hintText: 'Masukkan nama',
                            hintStyle: TextStyle(fontSize: 12),
                            prefixIcon: Icon(Icons.people),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 230,
                        height: 45,
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.whiteColor,
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                            hintText: 'Email Address',
                            hintStyle: TextStyle(fontSize: 12),
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Container(
                        width: 230,
                        height: 45,
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: AppColor.whiteColor,
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: AppColor.primaryColor,
                                fontWeight: FontWeight.bold),
                            hintText: 'Masukkan Password',
                            hintStyle: TextStyle(fontSize: 12),
                            prefixIcon: Icon(Icons.lock),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          style: TextStyle(fontSize: 12.0),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(200.0, 35.0),
                          primary: Color.fromRGBO(20, 0, 92, 1.0),
                        ),
                        onPressed: () => _register(context),
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
