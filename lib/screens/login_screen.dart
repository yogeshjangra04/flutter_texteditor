import 'package:collaborative_text_editor/colors.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: ElevatedButton.icon(
        onPressed: () {},
        icon: Image.asset(
          'assets/images/g-logo-2.png',
          height: 20,
        ),
        label: const Text(
          'Sign in with google',
          style: TextStyle(color: kBlack),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(150, 40),
          backgroundColor: kWhiteColor,
          foregroundColor: kGreyColor,
        ),
      ),
    );
  }
}
