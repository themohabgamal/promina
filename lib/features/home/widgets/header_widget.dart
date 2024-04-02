import 'package:flutter/material.dart';
import 'package:promina/core/helpers/fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Welcome \nMina",
          style: MyFonts.mediumFont
              .copyWith(fontWeight: FontWeight.w400, fontSize: 30),
          textAlign: TextAlign.left,
        ),
        const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/images/boy.png'),
        )
      ],
    );
  }
}
