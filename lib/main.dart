import 'package:flutter/material.dart';
import 'package:flutter_project/view/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark));
  runApp(const WayToStars());
}

class WayToStars extends StatelessWidget {
  const WayToStars({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.firaSansTextTheme(),
        primarySwatch: Colors.teal,
      ),
      home: const HomePage(),
    );
  }
}
