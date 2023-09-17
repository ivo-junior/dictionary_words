import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:dictionary_words/global_components/theme/app_colors.dart';

class InformationElement extends StatelessWidget {
  final String title;
  final String content;

  const InformationElement({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 95,
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.commissioner(
                color: AppColors.text.darkBlue,
                height: 2,
                fontSize: 18,
                fontWeight: FontWeight.w800),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                textAlign: TextAlign.left,
                style: GoogleFonts.commissioner(
                    color: AppColors.text.darkBlue,
                    height: 2,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
