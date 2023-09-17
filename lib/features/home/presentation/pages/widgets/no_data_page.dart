import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';

class NodataPage extends StatelessWidget {
  const NodataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.data_object,
            size: 100,
            color: AppColors.darkBlue,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Text(
              "OOPS!",
              style: GoogleFonts.commissioner(
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                  letterSpacing: 1,
                  color: AppColors.blueViolet,
                  fontSize: 26,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Text(
            "Nada por aqui ainda!",
            textAlign: TextAlign.center,
            style: GoogleFonts.commissioner(
                letterSpacing: 1,
                color: AppColors.input.darkBlue,
                fontSize: 14,
                fontWeight: FontWeight.w400),
          ),
          const Padding(
            padding: EdgeInsets.only(bottom: 110),
          )
        ],
      ),
    );
  }
}
