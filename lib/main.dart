import 'package:flutter/material.dart';
import 'package:prova_target/features/auth/presentation/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prova Target',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color.fromRGBO(67, 189, 110, 1),
        elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              Color.fromRGBO(67, 189, 110, 1),
            ),
            minimumSize: MaterialStatePropertyAll(Size(80, 50)),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            textStyle: MaterialStatePropertyAll(
              TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.white),
          ),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          contentPadding: EdgeInsets.all(8),
          errorMaxLines: 2,
          errorStyle: TextStyle(
            decorationColor: Colors.amber,
            color: Color.fromARGB(255, 255, 0, 0),
            fontSize: 14,
            shadows: [
              Shadow(color: Color.fromRGBO(255, 0, 0, 1), offset: Offset(1, 1), blurRadius: 0.2),
              Shadow(color: Color.fromRGBO(0, 0, 0, 1), offset: Offset(-1, -1), blurRadius: 0.5)
            ],
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          fillColor: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: const LoginScreen(),
    );
  }
}
