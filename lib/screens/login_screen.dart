import 'package:collaborative_text_editor/colors.dart';
import 'package:collaborative_text_editor/repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void signIn(WidgetRef ref) {
    ref.read(authRepositoryProvider).signIn();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: ElevatedButton.icon(
        onPressed: () => signIn(ref),
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
