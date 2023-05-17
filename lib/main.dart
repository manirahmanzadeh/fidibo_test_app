import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'domain/usecases/home_bindings.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const FidiboTestApp());
}

class FidiboTestApp extends StatelessWidget {
  const FidiboTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Fidibo Test',
      initialBinding: HomeBindings(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: const HomeScreen()
    );
  }
}
