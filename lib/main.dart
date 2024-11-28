import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:netflix/screens/splashscreen.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensures all async services are initialized
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white, fontSize: 24),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 20),
        ),
        colorScheme: const ColorScheme.dark(),
        fontFamily: GoogleFonts.ptSans().fontFamily,
        // Uncomment below if Material 3 causes issues temporarily
        // useMaterial3: true,
      ),
      home: const Splashscreen(),
    );
  }
}
