import 'package:dictionary_words/core/routes/auth_routes.dart';
import 'package:dictionary_words/global_components/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestLogin extends StatelessWidget {
  RequestLogin({super.key});

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Text(
            'Você ainda não esta conectado. Faça login ou crie uma conta.',
            textAlign: TextAlign.center,
            style: GoogleFonts.commissioner(
                color: AppColors.text.darkBlue,
                height: 2,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 40,
          ),
          ElevatedButton(
            onPressed: () => Get.offAllNamed(AuthRoutes.LOGIN.value),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.darkBlue,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Text(
                'SingIn/SingUp',
                textAlign: TextAlign.center,
                style: GoogleFonts.commissioner(
                    color: Colors.white,
                    height: 2,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
    );
  }
}
