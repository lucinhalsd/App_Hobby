

import 'package:app_hobby_application_1/pages/home_page.dart';
import 'package:app_hobby_application_1/services/auth_service.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text('Entrar'),
              onPressed: () async {
                await AuthService() .login(emailController.text, passwordController.text);
                Navigator.push(context , MaterialPageRoute(builder: (context) => HomePage()));
                // Handle login logic
              },
              ),
          ],
        ),
      ),
    );
  }
  // LoginPage implementation goes here
}