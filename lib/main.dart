import 'package:flutter/material.dart';
import 'package:petstore_app/features/pet_add/ui/add_pet_screen.dart';
import 'package:petstore_app/features/home/ui/home_screen.dart';
import 'package:petstore_app/features/pet_detail/ui/pet_detail_screen.dart';
import 'package:petstore_app/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Store App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/detail': (context) => const PetDetailScreen(),
        '/add': (context) => const AddPetScreen(),
      },
    );
  }
}
