import 'package:flutter/material.dart';
import 'package:tezda/ui/auth/widgets/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: TezdaApp()));
}

class TezdaApp extends StatelessWidget {
  const TezdaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tezda',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginScreen(title: 'Login'),
      debugShowCheckedModeBanner: false,
    );
  }
}



