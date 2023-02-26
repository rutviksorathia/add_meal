import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GoodJobView extends StatelessWidget {
  const GoodJobView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Text(
            'Good Job',
            style: GoogleFonts.elsie(
              fontSize: 50,
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}
