import 'package:flutter/material.dart';
import 'package:promina/core/helpers/fonts.dart';

class ImageTextContainer extends StatelessWidget {
  final String imagePath;
  final String text;
  const ImageTextContainer({
    super.key,
    required this.imagePath,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Image.asset(
          imagePath,
          width: 30,
        ),
        Text(text,
            style: MyFonts.mediumFont
                .copyWith(fontWeight: FontWeight.w400, fontSize: 18))
      ]),
    );
  }
}
