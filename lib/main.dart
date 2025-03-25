import 'package:flutter/material.dart';
import 'package:tezda/ui/product_list/widgets/product_list_screen.dart';
import 'package:tezda/ui/profile/widgets/profile_screen.dart';

void main() {
  runApp(const TezdaApp());
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
      home: const ProductListScreen(title: 'Products'),
      debugShowCheckedModeBanner: false,
    );
  }
}

