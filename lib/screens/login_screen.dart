import 'package:collaborative_text_editor/colors.dart';
import 'package:collaborative_text_editor/repository/auth_repository.dart';
import 'package:collaborative_text_editor/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void signIn(WidgetRef ref, BuildContext context) async {
    final scaffold = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final res = await ref.read(authRepositoryProvider).signIn();
    if (res.error == null) {
      ref.read(userProvider.notifier).update((state) => res.data);
      navigator.push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } else {
      scaffold.showSnackBar(
        SnackBar(
          content: Text(res.error!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen'),
      ),
      body: ElevatedButton.icon(
        onPressed: () => signIn(ref, context),
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
